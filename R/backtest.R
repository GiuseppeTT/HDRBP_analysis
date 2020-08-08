my_backtest <- function(
    rolling_window,
    strategies,
    estimators,

    log_path,
    log_treshold
) {
    return(backtest(
        rolling_window,
        strategies,
        estimators,

        log_path,
        log_treshold
    ))
}
