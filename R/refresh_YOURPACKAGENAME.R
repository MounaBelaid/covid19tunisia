#' SNAPPY TITLE ABOUT THIS FUNCTION
#'
#' @description Updates the WHAT IS THIS DATASET
#'
#' @details LONGER DESCRIPTION OF WHAT IS GOING ON HERE, THE DATA, IT'S LICENSE, ETC.
#'
#' @source WHERE DID YOU GET IT
#' @source \href{https://github.com/Covid19R/documentation}{covid19R documentation}
#'
#' @return A tibble object
#' * date - The date in YYYY-MM-DD form
#' * location - The name of the location as provided by the data source. XXXXX
#' * location_type - The type of location using the covid19R controlled vocabulary. SAY MORE ABOUT THIS
#' * location_code - A standardized location code using a national or international standard. ADD MORE
#' * location_code_type The type of standardized location code being used according to the covid19R controlled vocabulary. Here we use `XXXX`
#' * data_type - the type of data in that given row using the covid19R controlled vocabulary. Includes WHAT DATA TYPES ARE HERE?
#' * value - number of cases of each data type
#' @export refresh_YOURPACKAGENAME
#'
#' @examples
#' \dontrun{
#' # update the data
#' YOURPACKAGENAME_dat <- refresh_YOURPACKAGENAME()
#' }
#'
refresh_YOURPACKAGENAME <- function() {
  
  #where is the data coming from
  url <- ""

  # load the data
  
  # clean the data if needed
  
  # reshape to data standard
  
  # return the data
}

