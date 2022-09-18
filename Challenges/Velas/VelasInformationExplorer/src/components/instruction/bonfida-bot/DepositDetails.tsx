import React from "react";
import { SignatureResult, TransactionInstruction } from "@velas/web3";
import { InstructionCard } from "../InstructionCard";
import { Address } from "components/common/Address";
import { Deposit } from "./types";

export function DepositDetailsCard(props: {
  ix: TransactionInstruction;
  index: number;
  result: SignatureResult;
  info: Deposit;
  innerCards?: JSX.Element[];
  childIndex?: number;
}) {
  const { ix, index, result, info, innerCards, childIndex } = props;

  return (
    <InstructionCard
      ix={ix}
      index={index}
      result={result}
      title="Bonfida Bot: Deposit"
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
        <td>Signal Provider Fee Address</td>
        <td className="text-lg-right">
          <Address pubkey={info.sigProviderFeeReceiverKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Insurance Funds</td>
        <td className="text-lg-right">
          <Address pubkey={info.bonfidaFeeReceiverKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Buy and Burn</td>
        <td className="text-lg-right">
          <Address pubkey={info.bonfidaBuyAndBurnKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Bot Token Mint</td>
        <td className="text-lg-right">
          <Address pubkey={info.mintKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Bot Address</td>
        <td className="text-lg-right">
          <Address pubkey={info.poolKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Target Pool Token Address</td>
        <td className="text-lg-right">
          <Address pubkey={info.targetPoolTokenKey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Pool Seed</td>
        <td className="text-lg-right">{info.poolSeed}</td>
      </tr>

      <tr>
        <td>Pool Token Amount</td>
        <td className="text-lg-right">{info.poolTokenAmount.toString()}</td>
      </tr>
    </InstructionCard>
  );
}
