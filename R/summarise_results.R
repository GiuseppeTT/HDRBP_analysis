my_summarise_results <- function(
    backtesting_results
) {
    backtesting_results %>%
        summarise_results() %>%
        return()
}
