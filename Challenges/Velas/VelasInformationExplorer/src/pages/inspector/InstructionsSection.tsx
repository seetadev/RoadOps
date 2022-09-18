import React from "react";
import bs58 from "bs58";
import { CompiledInstruction, Message } from "@velas/web3";
import { TableCardBody } from "components/common/TableCardBody";
import { AddressWithContext, programValidator } from "./AddressWithContext";
import { useCluster } from "providers/cluster";
import { programLabel } from "utils/tx";

export function InstructionsSection({ message }: { message: Message }) {
  return (
    <>
      {message.instructions.map((ix, index) => {
        return <InstructionCard key={index} {...{ message, ix, index }} />;
      })}
    </>
  );
}

function InstructionCard({
  message,
  ix,
  index,
}: {
  message: Message;
  ix: CompiledInstruction;
  index: number;
}) {
  const [expanded, setExpanded] = React.useState(false);
  const { cluster } = useCluster();
  const programId = message.accountKeys[ix.programIdIndex];
  const programName = programLabel(programId.toBase58(), cluster) || "Unknown";

  let data: string = "No data";
  if (ix.data) {
    data = "";

    const chunks = [];
    const hexString = bs58.decode(ix.data).toString("hex");
    for (let i = 0; i < hexString.length; i += 2) {
      chunks.push(hexString.slice(i, i + 2));
    }

    data = chunks.join(" ");
  }

  return (
    <div className="card" id={`instruction-index-${index + 1}`} key={index}>
      <div className={`card-header${!expanded ? " border-bottom-none" : ""}`}>
        <h3 className="card-header-title mb-0 d-flex align-items-center">
          <span className={`badge badge-soft-info mr-2`}>#{index + 1}</span>
          {programName} Instruction
        </h3>

        <button
          className={`btn btn-sm d-flex ${
            expanded ? "btn-black active" : "btn-white"
          }`}
          onClick={() => setExpanded((e) => !e)}
        >
          {expanded ? "Collapse" : "Expand"}
        </button>
      </div>
      {expanded && (
        <TableCardBody>
          <tr>
            <td>Program</td>
            <td className="text-lg-right">
              <AddressWithContext
                pubkey={message.accountKeys[ix.programIdIndex]}
                validator={programValidator}
              />
            </td>
          </tr>
          {ix.accounts.map((accountIndex, index) => {
            return (
              <tr key={index}>
                <td>
                  <div className="d-flex align-items-start flex-column">
                    Account #{index + 1}
                    <span className="mt-1">
                      {accountIndex < message.header.numRequiredSignatures && (
                        <span className="badge badge-soft-info mr-2">
                          Signer
                        </span>
                      )}
                      {message.isAccountWritable(accountIndex) && (
                        <span className="badge badge-soft-danger mr-2">
                          Writable
                        </span>
                      )}
                    </span>
                  </div>
                </td>
                <td className="text-lg-right">
                  <AddressWithContext
                    pubkey={message.accountKeys[accountIndex]}
                  />
                </td>
              </tr>
            );
          })}
          <tr>
            <td>
              Instruction Data <span className="text-muted">(Hex)</span>
            </td>
            <td className="text-lg-right">
              <pre className="d-inline-block text-left mb-0 data-wrap">
                {data}
              </pre>
            </td>
          </tr>
        </TableCardBody>
      )}
    </div>
  );
}
