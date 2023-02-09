import { SignatureResult, TransactionInstruction } from "@velas/web3";
import { Address } from "components/common/Address";
import { InstructionCard } from "../InstructionCard";
import { CancelSpotOrder, getSpotMarketFromInstruction } from "./types";

export function CancelSpotOrderDetailsCard(props: {
  ix: TransactionInstruction;
  index: number;
  result: SignatureResult;
  info: CancelSpotOrder;
  innerCards?: JSX.Element[];
  childIndex?: number;
}) {
  const { ix, index, result, info, innerCards, childIndex } = props;
  const mangoAccount = ix.keys[2];
  const spotMarketAccountMeta = ix.keys[4];
  const mangoSpotMarketConfig = getSpotMarketFromInstruction(
    ix,
    spotMarketAccountMeta
  );

  return (
    <InstructionCard
      ix={ix}
      index={index}
      result={result}
      title="Mango: CancelSpotOrder"
      innerCards={innerCards}
      childIndex={childIndex}
    >
      <tr>
        <td>Mango account</td>
        <td>
          <Address pubkey={mangoAccount.pubkey} alignRight link />
        </td>
      </tr>

      {mangoSpotMarketConfig !== undefined && (
        <tr>
          <td>Spot market</td>
          <td className="text-lg-right">{mangoSpotMarketConfig.name}</td>
        </tr>
      )}

      <tr>
        <td>Spot market address</td>
        <td>
          <Address pubkey={spotMarketAccountMeta.pubkey} alignRight link />
        </td>
      </tr>

      <tr>
        <td>Order Id</td>
        <td className="text-lg-right">{info.orderId}</td>
      </tr>
    </InstructionCard>
  );
}
