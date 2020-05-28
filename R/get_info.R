#' Get information about the datasets provided by covid19tunisia
#'
#' @return A tibble with information about where the data is pulled from, details about the dataset, what the data types are, etc.
#' @export
#'
#' @examples
#' \donttest{
#' get_info_covid19tunisia()
#' }

get_info_covid19tunisia <- function() {
  latest_data <-
    refresh_covid19tunisia(verbose = FALSE)

  dplyr::tibble(
    data_set_name = "covid19tunisia",
    package_name = "covid19tunisia",
    function_to_get_data = "refresh_covid19tunisia",
    data_details = "Open Source data on distribution of confirmed Covid-19 cases, recovered ones and deaths in Tunisia.
    For more, https://github.com/MounaBelaid/covid19datatunisia",
    data_url = "https://raw.githubusercontent.com/MounaBelaid/covid19datatunisia/master/dist/data.csv",
    license_url = "https://github.com/MounaBelaid/covid19datatunisia/blob/master/LICENSE",
    data_types =
      latest_data %>%
        tidyr::drop_na(data_type) %>%
        dplyr::pull(data_type) %>%
        unique() %>%
        stringr::str_c(collapse = ", "),
    location_types =
      latest_data %>%
        tidyr::drop_na(location_type) %>%
        dplyr::pull(location_type) %>%
        unique() %>%
        stringr::str_c(collapse = ", "),
    spatial_extent = "country",
    has_geospatial_info = FALSE
  )
}
