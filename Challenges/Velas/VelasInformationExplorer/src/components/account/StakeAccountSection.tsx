import React from "react";
import { TableCardBody } from "components/common/TableCardBody";
import { SolBalance } from "utils";
import { displayTimestampUtc } from "utils/date";
import { Account, useFetchAccountInfo } from "providers/accounts";
import { Address } from "components/common/Address";
import {
  StakeAccountInfo,
  StakeMeta,
  StakeAccountType,
} from "validators/accounts/stake";
import BN from "bn.js";
import { StakeActivationData } from "@velas/web3";

const MAX_EPOCH = new BN(2).pow(new BN(64)).sub(new BN(1));

export function StakeAccountSection({
  account,
  stakeAccount,
  activation,
  stakeAccountType,
}: {
  account: Account;
  stakeAccount: StakeAccountInfo;
  stakeAccountType: StakeAccountType;
  activation?: StakeActivationData;
}) {
  const hideDelegation =
    stakeAccountType !== "delegated" ||
    isFullyInactivated(stakeAccount, activation);
  return (
    <>
      <LockupCard stakeAccount={stakeAccount} />
      <OverviewCard
        account={account}
        stakeAccount={stakeAccount}
        stakeAccountType={stakeAccountType}
        activation={activation}
        hideDelegation={hideDelegation}
      />
      {!hideDelegation && (
        <DelegationCard
          stakeAccount={stakeAccount}
          activation={activation}
          stakeAccountType={stakeAccountType}
        />
      )}
      <AuthoritiesCard meta={stakeAccount.meta} />
    </>
  );
}

function LockupCard({ stakeAccount }: { stakeAccount: StakeAccountInfo }) {
  const unixTimestamp = 1000 * (stakeAccount.meta?.lockup.unixTimestamp || 0);
  if (Date.now() < unixTimestamp) {
    const prettyTimestamp = displayTimestampUtc(unixTimestamp);
    return (
      <div className="alert alert-warning text-center">
        <strong>Account is locked!</strong> Lockup expires on {prettyTimestamp}
      </div>
    );
  } else {
    return null;
  }
}

const TYPE_NAMES = {
  uninitialized: "Uninitialized",
  initialized: "Initialized",
  delegated: "Delegated",
  rewardsPool: "RewardsPool",
};

function displayStatus(
  stakeAccountType: StakeAccountType,
  activation?: StakeActivationData
) {
  let status = TYPE_NAMES[stakeAccountType];
  let activationState = "";
  if (stakeAccountType !== "delegated") {
    status = "Not delegated";
  } else {
    activationState = activation ? `(${activation.state})` : "";
  }

  return [status, activationState].join(" ");
}

function OverviewCard({
  account,
  stakeAccount,
  stakeAccountType,
  activation,
  hideDelegation,
}: {
  account: Account;
  stakeAccount: StakeAccountInfo;
  stakeAccountType: StakeAccountType;
  activation?: StakeActivationData;
  hideDelegation: boolean;
}) {
  const refresh = useFetchAccountInfo();
  return (
    <div className="card">
      <div className="card-header">
        <h3 className="card-header-title mb-0 d-flex align-items-center">
          Stake Account
        </h3>
        <button
          className="btn btn-white btn-sm"
          onClick={() => refresh(account.pubkey)}
        >
          <span className="fe fe-refresh-cw mr-2"></span>
          Refresh
        </button>
      </div>

      <TableCardBody>
        <tr>
          <td>Address</td>
          <td className="text-lg-right">
            <Address pubkey={account.pubkey} alignRight raw />
          </td>
        </tr>
        <tr>
          <td>Balance (VLX)</td>
          <td className="text-lg-right text-uppercase">
            <SolBalance lamports={account.lamports || 0} />
          </td>
        </tr>
        <tr>
          <td>Rent Reserve (VLX)</td>
          <td className="text-lg-right">
            <SolBalance lamports={stakeAccount.meta.rentExemptReserve} />
          </td>
        </tr>
        {hideDelegation && (
          <tr>
            <td>Status</td>
            <td className="text-lg-right">
              {isFullyInactivated(stakeAccount, activation)
                ? "Not delegated"
                : displayStatus(stakeAccountType, activation)}
            </td>
          </tr>
        )}
      </TableCardBody>
    </div>
  );
}

function DelegationCard({
  stakeAccount,
  stakeAccountType,
  activation,
}: {
  stakeAccount: StakeAccountInfo;
  stakeAccountType: StakeAccountType;
  activation?: StakeActivationData;
}) {
  let voterPubkey, activationEpoch, deactivationEpoch;
  const delegation = stakeAccount?.stake?.delegation;
  if (delegation) {
    voterPubkey = delegation.voter;
    activationEpoch = delegation.activationEpoch.eq(MAX_EPOCH)
      ? "-"
      : delegation.activationEpoch.toString();
    deactivationEpoch = delegation.deactivationEpoch.eq(MAX_EPOCH)
      ? "-"
      : delegation.deactivationEpoch.toString();
  }
  const { stake } = stakeAccount;
  return (
    <div className="card">
      <div className="card-header">
        <h3 className="card-header-title mb-0 d-flex align-items-center">
          Stake Delegation
        </h3>
      </div>
      <TableCardBody>
        <tr>
          <td>Status</td>
          <td className="text-lg-right">
            {displayStatus(stakeAccountType, activation)}
          </td>
        </tr>

        {stake && (
          <>
            <tr>
              <td>Delegated Stake (VLX)</td>
              <td className="text-lg-right">
                <SolBalance lamports={stake.delegation.stake} />
              </td>
            </tr>

            {activation && (
              <>
                <tr>
                  <td>Active Stake (VLX)</td>
                  <td className="text-lg-right">
                    <SolBalance lamports={activation.active} />
                  </td>
                </tr>

                <tr>
                  <td>Inactive Stake (VLX)</td>
                  <td className="text-lg-right">
                    <SolBalance lamports={activation.inactive} />
                  </td>
                </tr>
              </>
            )}

            {voterPubkey && (
              <tr>
                <td>Delegated Vote Address</td>
                <td className="text-lg-right">
                  <Address pubkey={voterPubkey} alignRight link />
                </td>
              </tr>
            )}

            <tr>
              <td>Activation Epoch</td>
              <td className="text-lg-right">{activationEpoch}</td>
            </tr>

            <tr>
              <td>Deactivation Epoch</td>
              <td className="text-lg-right">{deactivationEpoch}</td>
            </tr>
          </>
        )}
      </TableCardBody>
    </div>
  );
}

function AuthoritiesCard({ meta }: { meta: StakeMeta }) {
  const hasLockup = meta.lockup.unixTimestamp > 0;
  return (
    <div className="card">
      <div className="card-header">
        <h3 className="card-header-title mb-0 d-flex align-items-center">
          Authorities
        </h3>
      </div>
      <TableCardBody>
        <tr>
          <td>Stake Authority Address</td>
          <td className="text-lg-right">
            <Address pubkey={meta.authorized.staker} alignRight link />
          </td>
        </tr>

        <tr>
          <td>Withdraw Authority Address</td>
          <td className="text-lg-right">
            <Address pubkey={meta.authorized.withdrawer} alignRight link />
          </td>
        </tr>

        {hasLockup && (
          <tr>
            <td>Lockup Authority Address</td>
            <td className="text-lg-right">
              <Address pubkey={meta.lockup.custodian} alignRight link />
            </td>
          </tr>
        )}
      </TableCardBody>
    </div>
  );
}

function isFullyInactivated(
  stakeAccount: StakeAccountInfo,
  activation?: StakeActivationData
): boolean {
  const { stake } = stakeAccount;

  if (!stake || !activation) {
    return false;
  }

  return stake.delegation.stake.toString() === activation.inactive.toString();
}
