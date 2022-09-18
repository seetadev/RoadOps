import React from "react";
import { SignatureResult, TransactionInstruction } from "@velas/web3";
import { InstructionCard } from "../InstructionCard";
import { Address } from "components/common/Address";
import { SettleFunds } from "./types";

export function SettleFundsDetailsCard(props: {
  ix: TransactionInstruction;
  index: number;
  result: SignatureResult;
  info: SettleFunds;
  innerCards?: JSX.Element[];
  childIndex?: number;
}) {
  const { ix, index, result, info, innerCards, childIndex } = props;
  return (
    <InstructionCard
      ix={ix}
      index={index}
      result={result}
      title="Bonfida Bot: Settle Funds"
      innerCards={innerCards}
      childIndex={childIndex}
    >
      <tr>
        <td>Program</td>
        <td className="text-lg-right">
          <Address pubkey={info.programId} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Market</td>
        <td className="text-lg-right">
          <Address pubkey={info.market} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Open Orders</td>
        <td className="text-lg-right">
          <Address pubkey={info.openOrdersKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Bot Address</td>
        <td className="text-lg-right">
          <Address pubkey={info.poolKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Bot Token Mint</td>
        <td className="text-lg-right">
          <Address pubkey={info.poolMintKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Coin Vault</td>
        <td className="text-lg-right">
          <Address pubkey={info.coinVaultKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Pc Vault</td>
        <td className="text-lg-right">
          <Address pubkey={info.pcVaultKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Bot's Coin Address</td>
        <td className="text-lg-right">
          <Address pubkey={info.coinPoolAssetKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Bot's Pc Address</td>
        <td className="text-lg-right">
          <Address pubkey={info.pcPoolAssetKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Vault Signer</td>
        <td className="text-lg-right">
          <Address pubkey={info.vaultSignerKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Serum Program ID</td>
        <td className="text-lg-right">
          <Address pubkey={info.dexProgramKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Pool Seed</td>
        <td className="text-lg-right">{info.poolSeed}</td>
      </tr>
    </InstructionCard>
  );
}
