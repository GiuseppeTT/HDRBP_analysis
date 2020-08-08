.count_csv_columns <- function(
    path
) {
    path %>%
        count_fields(tokenizer_csv(), n_max = 1) %>%
        return()
}

my_fake_tickers <- function(
    input_path
) {
    input_path %>%
        .count_csv_columns() %>%
        fake_labels(prefix = "T") %>%
        return()
}
