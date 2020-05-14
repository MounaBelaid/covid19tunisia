#' Get information about the datasets provided by YOURPACKAGENAME
#'
#' @description Returns information about the datasets in this package for covid19R harvesting
#'
#' @return a tibble of information about the datasets in this package
#' @export get_info_YOURPACKAGENAME
#'
#' @examples
#' \dontrun{
#'
#' # get the dataset info from this package
#' get_info_YOURPACKAGENAME()
#' }
#'
get_info_YOURPACKAGENAME <- function() {

  tibble::tribble(
    ~data_set_name, ~package_name, ~function_to_get_data,
    ~data_details, ~data_url, ~license_url,
    ~data_types, ~location_types,
    ~spatial_extent, ~has_geospatial_info,

    "DATASET_NAME",
    "YOURPACKAGENAME",
    "refresh_YOURPACKAGENAME_*",
    "DESCRIPTION OF THE DATA",
    "URL THIS DATASET COMES FROM",
    "URL OF THE LICENSE",
    "DATA_TYPE_1,DATA_TYPE_2,...", #COMMA SEPARATED STRING OF DATA TYPES
    "LOCATION_TYPE_1,LOCATION_TYPE_2", #COMMA SEPARATED STRING OF LOCATION TYPES
    "EXTENT", #HOW LARGE IS THE AREA COVERED BY THE WHOLE DATASET? COUNTRY? CONTINENT? WORLD? OTHER?
    FALSE #IS THERE GEOSPATIAL INFORMATION, E.G. LAT/LONG? TRUE/FALSE
  )
}
