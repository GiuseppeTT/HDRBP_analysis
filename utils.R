# Source every R file in a directory
source_directory <- function(
    path,
    ...
) {
    path %>%
        fs::dir_ls(type = "file", glob = "*.R", ...) %>%
        walk(source)
}
