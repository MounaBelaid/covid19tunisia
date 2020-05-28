#' Refresh data
#'
#' @param verbose Should messages about what's going on be displayed?
#'
#' @return A tibble of the most up to date per-day data on cases of COVID-19 in Tunisia, ordered by date descending.
#' @export
#'
#' @examples
#' \donttest{
#' refresh_covid19tunisia()
#' }
refresh_covid19tunisia <- function() {
  
  #where is the data coming from
  if (verbose) 
    url <- "https://raw.githubusercontent.com/MounaBelaid/covid19datatunisia/master/dist/data.csv"
  
  
  # load the data
    data <- read_csv(url)
  # return the data
    data
}
