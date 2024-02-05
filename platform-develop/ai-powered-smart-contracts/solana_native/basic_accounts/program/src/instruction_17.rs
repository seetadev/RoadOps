use solana_program::account_info::AccountInfo;
use solana_program::entrypoint::ProgramResult;
use solana_program::msg;
use solana_program::pubkey::Pubkey;

use crate::generated::state::{
	Account,
	NonPdaaccountWithOneField,
};

/// Test `close` using Non-PDA account that has one field
///
/// Accounts:
/// 0. `[writable, signer]` fee_payer: [AccountInfo] Auto-generated, default fee payer
/// 1. `[writable]` account: [NonPdaaccountWithOneField] 
pub fn instruction_17(
	program_id: &Pubkey,
	account: &mut Account<NonPdaaccountWithOneField>,
) -> ProgramResult {
	msg!("Account field_1 value {}", account.data.field_1);

    Ok(())
}