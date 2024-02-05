#![allow(unused)]
use crate::*;
use anchor_lang::prelude::*;

pub fn instruction10(ctx: Context<Instruction10>, input_1: u8) -> Result<()> {
    ctx.accounts.account.field_1 = input_1;
    Ok(())
}
