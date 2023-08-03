use anchor_lang::prelude::*;

declare_id!("6rCK1Tq1bbTwz9eKjV7QFxq7J6rw4HrSTNKQUUQALxhs");

#[program]
pub mod pythaplex {
    use super::*;

    pub fn create(ctx: Context<Create>, authority: Pubkey) -> ProgramResult {
        // setup trading account 
        let trading_account = &mut ctx.accounts.trading_account;
        msg!(
            "remaining_accounts length: {}",
            ctx.remaining_accounts.len()
        );
        let pyth_price_acc = &ctx.remaining_accounts[0];
        trading_account.authority = authority;
        trading_account.pyth_price_pubkey = *pyth_price_acc.key;
        trading_account.closed = true;
        let pyth_price_data = &pyth_price_acc.try_borrow_data()?;
        let pyth_price_data = pyth_client::cast::<pyth_client::Price>(pyth_price_data);
        trading_account.latest_price = pyth_price_data.agg.price;
        msg!("price: {}", trading_account.latest_price);
        trading_account.roi = 0;
        Ok(())
    }

    pub fn open(ctx: Context<Open>) -> ProgramResult {
        let trading_account = &mut ctx.accounts.trading_account;
        let pyth_price_acc = &ctx.remaining_accounts[0];
        msg!("check position: {}",
            match trading_account.closed {
                true => "closed", false => "opened"}
        );
        require!(
            trading_account.closed,
            ErrCode::PositionOpened
        );
        msg!("check oracle: \n{} \n{}",
            trading_account.pyth_price_pubkey,
            *pyth_price_acc.key
        );
        require!(
            trading_account.pyth_price_pubkey == *pyth_price_acc.key,
            ErrCode::DifferentOracle
        );
        trading_account.closed = false;
        let pyth_price_data = &pyth_price_acc.try_borrow_data()?;
        let pyth_price_data = pyth_client::cast::<pyth_client::Price>(pyth_price_data);
        trading_account.latest_price = pyth_price_data.agg.price;
        msg!("long at {}", trading_account.latest_price);
        Ok(())
    }

    pub fn close(ctx: Context<Close>) -> ProgramResult {
        let trading_account = &mut ctx.accounts.trading_account;
        let pyth_price_acc = &ctx.remaining_accounts[0];
        msg!("check position: {}",
            match trading_account.closed {
                true => "closed", false => "opened"}
        );
        require!(
            !trading_account.closed,
            ErrCode::PositionClosed
        );
        msg!("check oracle: \n{} \n{}",
            trading_account.pyth_price_pubkey,
            *pyth_price_acc.key
        );
        require!(
            trading_account.pyth_price_pubkey == *pyth_price_acc.key,
            ErrCode::DifferentOracle
        );
        let pyth_price_data = &pyth_price_acc.try_borrow_data()?;
        let pyth_price_data = pyth_client::cast::<pyth_client::Price>(pyth_price_data);
        trading_account.roi =
            (pyth_price_data.agg.price - trading_account.latest_price)
            * 1000 / trading_account.latest_price;
        msg!("roi: {}", trading_account.roi);
        trading_account.closed = true;
        Ok(())
    }
}

// Create trading account
#[derive(Accounts)]
pub struct Create<'info> {
    #[account(init, payer = user, space = 40+40+1+8+8)]
    pub trading_account: Account<'info, TradingAccount>,
    #[account(mut)]
    pub user: Signer<'info>,
    pub system_program: Program<'info, System>,
}

// Open position
#[derive(Accounts)]
pub struct Open<'info> {
    #[account(mut, has_one = authority)]
    pub trading_account: Account<'info, TradingAccount>,
    pub authority: Signer<'info>,
}

// Close position
#[derive(Accounts)]
pub struct Close<'info> {
    #[account(mut, has_one = authority)]
    pub trading_account: Account<'info, TradingAccount>,
    pub authority: Signer<'info>,
}

// Trading account to store trading info
#[account]
pub struct TradingAccount {
    pub authority: Pubkey,
    pub pyth_price_pubkey: Pubkey,
    pub closed: bool,
    pub latest_price: i64,
    pub roi: i64,
}

// Custom error
#[error]
pub enum ErrCode {
    #[msg("using different oracle")]
    DifferentOracle,
    #[msg("position already closed")]
    PositionClosed,
    #[msg("position already opened")]
    PositionOpened,
}