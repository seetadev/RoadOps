import { web3 } from "@project-serum/anchor";
import axios, { Method } from "axios";
import { DateTime } from "luxon";
import b58 from "bs58";

export const web3Posts = axios.create({
  baseURL: "http://localhost:4000/posts",
});

type MessageSigner = {
  signMessage(message: Uint8Array): Promise<Uint8Array>;
  publicKey: web3.PublicKey;
};

/**
 * Singleton class for storing a valid signature on-memory.
 */
export class MemoryStoredToken {
  private constructor(public token: string | null = null) {}
  private static instance: MemoryStoredToken;
  static getInstance(): MemoryStoredToken {
    if (!MemoryStoredToken.instance) {
      MemoryStoredToken.instance = new MemoryStoredToken();
    }
    return MemoryStoredToken.instance;
  }
  public setToken(token: string) {
    this.token = token;
  }
}

/**
 * Creates an authentication token to be passed to the server
 * via auth headers, returns the following format:
 * `pubKey.message.signature` (All in base58).
 * @param action Name of the action to be allowed, needed for authentication purposes.
 * @param wallet Signer.
 * @param exp Expiration time in minutes.
 * @returns {Promise<string>} pubKey.message.signature (All in base58)
 */
export const createAuthToken = async (
  action: string,
  wallet: MessageSigner,
  exp = 5
) => {
  const encodedMessage = new TextEncoder().encode(
    JSON.stringify({
      action,
      exp: DateTime.local().toUTC().plus({ minutes: exp }).toUnixInteger(),
    })
  );
  const signature = await wallet.signMessage(encodedMessage);
  const pk = wallet.publicKey.toBase58();
  const msg = b58.encode(encodedMessage);
  const sig = b58.encode(signature);
  return `${pk}.${msg}.${sig}`;
};

/**
 * Performs a request to the endpoint using
 * authentication via wallet signer.
 */
export const req = async <T, R>(
  contents: { method: Method; url: string; data?: T },
  action: string,
  wallet: MessageSigner,
  exp = 5
) => {
  const { method, url, data } = contents;

  let authToken;
  if (action === "skip") {
    // Try to reuse existing token.
    const memoryToken = MemoryStoredToken.getInstance().token;
    if (memoryToken) {
      const [, msg] = memoryToken.split(".");
      const contents = JSON.parse(
        new TextDecoder().decode(b58.decode(msg))
      ) as { exp: number };
      if (DateTime.local().toUTC().toUnixInteger() > contents.exp) {
        // Token has expired.
        authToken = await createAuthToken(action, wallet, exp);
        MemoryStoredToken.getInstance().setToken(authToken);
      } else {
        authToken = memoryToken;
      }
    } else {
      authToken = await createAuthToken(action, wallet, exp);
      MemoryStoredToken.getInstance().setToken(authToken);
    }
  } else {
    authToken = await createAuthToken(action, wallet, exp);
  }

  const response = await web3Posts.request<R>({
    data,
    method,
    url,
    headers: { Authorization: `Bearer ${authToken}` },
  });

  return response.data;
};
