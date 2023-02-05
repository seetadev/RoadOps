import { WalletMultiButton } from "@solana/wallet-adapter-react-ui";
import Link from "next/link";

export default function Navbar() {
  return (
    <nav className="flex w-full h-10 gap-4 px-4 pt-4 pb-20 font-sans text-white md:px-20 md:gap-10">
      <Link href="/">
        <a className="text-2xl no-underline hover:text-slate-300">
          Mint
        </a>
      </Link>
      <Link href="/holders">
        <a className="text-2xl no-underline text-grey-darkest hover:text-slate-300 grow">
          Holders only 😎
        </a>
      </Link>
    </nav>
  )
}
