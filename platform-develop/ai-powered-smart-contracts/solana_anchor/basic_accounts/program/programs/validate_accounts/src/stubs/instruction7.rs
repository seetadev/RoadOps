#![allow(unused)]
use crate::*;
use anchor_lang::prelude::*;

pub fn instruction7(ctx: Context<Instruction7>) -> Result<()> {
    ctx.accounts.account.field_1 += 1;
    Ok(())
}
