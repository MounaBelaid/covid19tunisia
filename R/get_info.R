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
  
  tibble::tribble(
    ~data_set_name, ~package_name, ~function_to_get_data,
    ~data_details, ~data_url, ~license_url,
    ~data_types, ~location_types,
    ~spatial_extent, ~has_geospatial_info,

    "covid19tunisia",
    "covid19tunisia",
    "refresh_covid19tunisia",
    "Open Source data on distribution of confirmed Covid-19 cases, recovered ones and deaths in Tunisia.
For more, https://github.com/MounaBelaid/covid19datatunisia.",
    "https://raw.githubusercontent.com/MounaBelaid/covid19datatunisia/master/dist/data.csv",
    "https://github.com/MounaBelaid/covid19datatunisia/blob/master/LICENSE",
     latest_data %>%
       tidyr::drop_na(data_type) %>%
       dplyr::pull(data_type) %>%
       unique() %>%
       stringr::str_c(collapse = ", "), #COMMA SEPARATED STRING OF DATA TYPES
     latest_data %>%
       tidyr::drop_na(location_type) %>%
       dplyr::pull(location_type) %>%
       unique() %>%
       stringr::str_c(collapse = ", "), #COMMA SEPARATED STRING OF LOCATION TYPES
    "country", #HOW LARGE IS THE AREA COVERED BY THE WHOLE DATASET? COUNTRY? CONTINENT? WORLD? OTHER?
    FALSE #IS THERE GEOSPATIAL INFORMATION, E.G. LAT/LONG? TRUE/FALSE
  )
}
