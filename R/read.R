my_read_dates <- function(
    input_path
) {
    input_path %>%
        read_vector(header = FALSE, showProgress = FALSE) %>%
        as.Date.character("%Y%m%d") %>%
        as.character() %>%
        return()
}

my_read_matrix <- function(
    input_path,
    dates,
    tickers
) {
    input_path %>%
        read_matrix(
            row_names = dates,
            column_names = tickers,
            header = FALSE,
            na.string = "NaN",
            colClasses = "numeric",
            showProgress = FALSE
        ) %>%
        return()
}
