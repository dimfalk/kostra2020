#' Get precipitation height for a specified duration and return period
#'
#' @param data A tibble containing grid cell statistics from KOSTRA-2010R.
#' @param d Duration in minutes.
#' @param tn Return period in years.
#'
#' @return A numerical vector including the precipitation height.
#' @export
#'
#' @examples
#' \dontrun{
#' get_precip(kostra, d = 60, tn = 50)
#' }
get_precip <- function(data, d, tn) {

  # debugging ------------------------------------------------------------------

  # data <- kostra
  # d <- 60
  # tn <- 50

  # main -----------------------------------------------------------------------

  # get index and return object
  ind <- which(attr(data, "returnperiods_a") == tn)

  data[data[["D_min"]] == d, ind + 3] %>% as.numeric()
}
