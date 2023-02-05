declare namespace PlaywrightTest {
  interface Matchers<R> {
    toBeWithinRange(a: number, b: number): R;
  }
}

declare type Wallet = {
  address?: string,
  seed: string,
  encryptedSeed?: string,
}
