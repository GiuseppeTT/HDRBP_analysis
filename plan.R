data_plan <- drake_plan(
    trading_dates = my_read_dates(
        file_in(!!config$data$trading_dates)
    ),
    monthly_trading_dates = my_read_dates(
        file_in(!!config$data$monthly_trading_dates)
    ),
    stock_tickers = my_fake_tickers(
        file_in(!!config$data$stock_returns)
    ),

    stock_returns = my_read_matrix(
        file_in(!!config$data$stock_returns),
        trading_dates,
        stock_tickers
    ),
    stock_volumes = my_read_matrix(
        file_in(!!config$data$stock_volumes),
        trading_dates,
        stock_tickers
    ),
    stock_close_prices = my_read_matrix(
        file_in(!!config$data$stock_close_prices),
        trading_dates,
        stock_tickers
    ),
    stock_monthly_capitalizations = my_read_matrix(
        file_in(!!config$data$stock_monthly_capitalizations),
        monthly_trading_dates,
        stock_tickers
    ),

    stock_dollar_volumes = my_calculate_dollar_volumes(
        stock_volumes,
        stock_close_prices
    ),
)

backtest_plan <- drake_plan(
    rolling_window = my_define_rolling_window(
        trading_dates,
        stock_tickers,

        config$rolling_window$break_type,
        config$rolling_window$estimation_break_size,
        config$rolling_window$holding_break_size,

        stock_returns,
        stock_monthly_capitalizations,

        stock_dollar_volumes,
        config$rolling_window$cut_off_rank,

        config$rolling_window$log$path,
        config$rolling_window$log$threshold
    ),

    backtesting_results = my_backtest(
        rolling_window,
        as_factor(config$backtest$strategies),
        as_factor(config$backtest$estimators),

        config$backtest$log$path,
        config$backtest$log$threshold
    )
)

main_plan <- bind_plans(
    data_plan,
    backtest_plan,
)
