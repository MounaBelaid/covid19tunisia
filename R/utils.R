#' @importFrom utils download.file

url <- "https://raw.githubusercontent.com/MounaBelaid/covid19datatunisia/master/dist/data.csv"

read_data <- function() {
  suppressWarnings(
    readr::read_csv(
      url,
      col_types =
        readr::cols(
          date = readr::col_date(format = ""),
          location = readr::col_character(),
          location_type = readr::col_character(),
          location_code = readr::col_character(),
          location_code_type = readr::col_character(),
          data_type = readr::col_character(),
          value = readr::col_double()
        )
    )
  )
}
