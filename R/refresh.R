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
refresh_covid19tunisia <- function(verbose = TRUE) {
  
  #where is the data coming from
  if (verbose) message(glue::glue("Downloading raw data from {url}."))

  read_data()

}
