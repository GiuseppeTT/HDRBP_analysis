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

results_plan <- drake_plan(
    price_plot = my_plot_price(
        backtesting_results,
        file_out(!!config$result$price_plot),
        width = config$figure$width,
        height = config$figure$height
    ),
    drawdown_plot = my_plot_drawdown(
        backtesting_results,
        file_out(!!config$result$drawdown_plot),
        width = config$figure$width,
        height = config$figure$height
    ),
    weight_lorenz_plot = my_plot_lorenz(
        backtesting_results,
        rebalance_weights,
        file_out(!!config$result$weight_lorenz_plot),
        width = config$figure$width,
        height = config$figure$height
    ),
    risk_lorenz_plot = my_plot_lorenz(
        backtesting_results,
        rebalance_risk_contributions,
        file_out(!!config$result$risk_lorenz_plot),
        width = config$figure$width,
        height = config$figure$height
    ),

    summary_results = my_summarise_results(
        backtesting_results
    ),
    summary_results_table = my_write_kable(
        summary_results,
        file_out(!!config$result$summary)
    )
)

main_plan <- bind_plans(
    data_plan,
    backtest_plan,
    results_plan
)
