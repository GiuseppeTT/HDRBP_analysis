my_write_kable <- function(
    data,
    kable_path
) {
    data %>%
        knitr::kable() %>%
        write_lines(kable_path)
}
