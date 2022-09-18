import { coerce, instance, string } from "superstruct";
import { PublicKey } from "@velas/web3";

export const PublicKeyFromString = coerce(
  instance(PublicKey),
  string(),
  (value) => new PublicKey(value)
);
