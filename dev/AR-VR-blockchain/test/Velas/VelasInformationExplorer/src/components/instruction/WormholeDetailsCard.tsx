import React from "react";
import { TransactionInstruction, SignatureResult } from "@velas/web3";
import { InstructionCard } from "./InstructionCard";
import { useCluster } from "providers/cluster";
import { reportError } from "utils/sentry";
import { parsWormholeInstructionTitle } from "./wormhole/types";

export function WormholeDetailsCard({
  ix,
  index,
  result,
  signature,
  innerCards,
  childIndex,
}: {
  ix: TransactionInstruction;
  index: number;
  result: SignatureResult;
  signature: string;
  innerCards?: JSX.Element[];
  childIndex?: number;
}) {
  const { url } = useCluster();

  let title;
  try {
    title = parsWormholeInstructionTitle(ix);
  } catch (error) {
    reportError(error, {
      url: url,
      signature: signature,
    });
  }

  return (
    <InstructionCard
      ix={ix}
      index={index}
      result={result}
      title={`Wormhole: ${title || "Unknown"}`}
      innerCards={innerCards}
      childIndex={childIndex}
      defaultRaw
    />
  );
}
