use solana_program::account_info::AccountInfo;
use solana_program::entrypoint::ProgramResult;
use solana_program::pubkey::Pubkey;

use crate::generated::state::{
	AccountPDA,
};

/// Reference `validate_accounts.instruction19`, where caller doesn't have inputs
///
/// Accounts:
/// 0. `[writable, signer]` fee_payer: [AccountInfo] Auto-generated, default fee payer
/// 1. `[writable]` account: [PdaaccountWithOneStaticAndDynamicSeedAndOneField] 
/// 2. `[]` validate_accounts_v_0_0_0: [AccountInfo] Auto-generated, ValidateAccountsProgram v0.0.0
///
/// Data:
/// - account_seed_dynamic: [u8] Auto-generated, from input account of type [PdaaccountWithOneStaticAndDynamicSeedAndOneField] set the seed named dynamic, required by the type
pub fn instruction_19(
	program_id: &Pubkey,
	for_instruction_19: &[&AccountInfo],
	account: &AccountPDA<validate_accounts::src::state::PdaaccountWithOneStaticAndDynamicSeedAndOneField>,
	account_seed_dynamic: u8,
) -> ProgramResult {
    // Implement your business logic here...

	validate_accounts::src::cpi::instruction_19(
		for_instruction_19,
		account_seed_dynamic,
	)?;

    Ok(())
}