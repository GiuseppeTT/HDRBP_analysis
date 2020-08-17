my_plot_price <- function(
    backtesting_results,
    plot_path,
    base_size = 11,
    ...
) {
    backtesting_results %>%
        plot_price(
            plot_path,
            base_size,
            ...
        )
}

my_plot_drawdown <- function(
    backtesting_results,
    plot_path,
    base_size = 11,
    ...
) {
    backtesting_results %>%
        plot_drawdown(
            plot_path,
            base_size,
            ...
        )
}

my_plot_lorenz <- function(
    backtesting_results,
    variable,
    plot_path,
    base_size = 11,
    ...
) {
    backtesting_results %>%
        plot_lorenz(
            {{variable}},
            plot_path,
            base_size,
            ...
        )
}
