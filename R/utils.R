#' @importFrom utils download.file

url <- "https://raw.githubusercontent.com/MounaBelaid/covid19datatunisia/master/dist/data.csv"

read_data <- function() {
  suppressWarnings(
    readr::read_csv(
      url,
      col_types =
        readr::cols(
          date = col_date(format = ""),
          location = col_character(),
          location_type = col_character(),
          location_code = col_character(),
          location_code_type = col_character(),
          data_type = col_character(),
          value = col_double()
        )
    )
  )
}
