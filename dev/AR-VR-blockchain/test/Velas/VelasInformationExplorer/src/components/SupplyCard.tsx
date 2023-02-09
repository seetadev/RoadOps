import React from "react";
import { useSupply, useFetchSupply, Status } from "providers/supply";
import { LoadingCard } from "./common/LoadingCard";
import { ErrorCard } from "./common/ErrorCard";
import { SolBalance } from "utils";
import { TableCardBody } from "./common/TableCardBody";

export function SupplyCard() {
  const supply = useSupply();
  const fetchSupply = useFetchSupply();

  // Fetch supply on load
  React.useEffect(() => {
    if (supply === Status.Idle) fetchSupply();
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  if (supply === Status.Disconnected) {
    return <ErrorCard text="Not connected to the cluster" />;
  }

  if (supply === Status.Idle || supply === Status.Connecting)
    return <LoadingCard />;

  if (typeof supply === "string") {
    return <ErrorCard text={supply} retry={fetchSupply} />;
  }

  return (
    <div className="card">
      {renderHeader()}

      <TableCardBody>
        <tr>
          <td className="w-100">Total Supply (VLX)</td>
          <td className="text-lg-right">
            <SolBalance lamports={supply.total} maximumFractionDigits={0} />
          </td>
        </tr>

        <tr>
          <td className="w-100">Circulating Supply (VLX)</td>
          <td className="text-lg-right">
            <SolBalance
              lamports={supply.circulating}
              maximumFractionDigits={0}
            />
          </td>
        </tr>

        <tr>
          <td className="w-100">Non-Circulating Supply (VLX)</td>
          <td className="text-lg-right">
            <SolBalance
              lamports={supply.nonCirculating}
              maximumFractionDigits={0}
            />
          </td>
        </tr>
      </TableCardBody>
    </div>
  );
}

const renderHeader = () => {
  return (
    <div className="card-header">
      <div className="row align-items-center">
        <div className="col">
          <h4 className="card-header-title">Supply Overview</h4>
        </div>
      </div>
    </div>
  );
};
