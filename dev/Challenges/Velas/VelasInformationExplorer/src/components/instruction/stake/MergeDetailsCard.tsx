import React from "react";
import {
  SignatureResult,
  StakeProgram,
  ParsedInstruction,
} from "@velas/web3";
import { InstructionCard } from "../InstructionCard";
import { Address } from "components/common/Address";
import { MergeInfo } from "./types";

export function MergeDetailsCard(props: {
  ix: ParsedInstruction;
  index: number;
  result: SignatureResult;
  info: MergeInfo;
  innerCards?: JSX.Element[];
  childIndex?: number;
}) {
  const { ix, index, result, info, innerCards, childIndex } = props;

  return (
    <InstructionCard
      ix={ix}
      index={index}
      result={result}
      title="Stake Merge"
      innerCards={innerCards}
      childIndex={childIndex}
    >
      <tr>
        <td>Program</td>
        <td className="text-lg-right">
          <Address pubkey={StakeProgram.programId} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Stake Source</td>
        <td className="text-lg-right">
          <Address pubkey={info.source} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Stake Destination</td>
        <td className="text-lg-right">
          <Address pubkey={info.destination} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Authority Address</td>
        <td className="text-lg-right">
          <Address pubkey={info.stakeAuthority} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Clock Sysvar</td>
        <td className="text-lg-right">
          <Address pubkey={info.clockSysvar} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Stake History Sysvar</td>
        <td className="text-lg-right">
          <Address pubkey={info.stakeHistorySysvar} alignRight link />
        </td>
      </tr>
    </InstructionCard>
  );
}
