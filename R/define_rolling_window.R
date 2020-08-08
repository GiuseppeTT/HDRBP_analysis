my_define_rolling_window <- function(
    trading_dates,
    stock_tickers,

    break_type,
    estimation_break_size,
    holding_break_size,

    stock_returns,
    stock_monthly_capitalizations,

    stock_dollar_volumes,
    cut_off_rank,

    log_file,
    log_treshold
) {
    return(define_rolling_window(
        trading_dates,
        stock_tickers,

        break_type,
        estimation_break_size,
        holding_break_size,

        stock_returns,
        stock_monthly_capitalizations,

        stock_dollar_volumes,
        cut_off_rank,

        log_file,
        log_treshold
    ))
}
