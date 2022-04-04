#' Get precipitation height for a specified duration and return period
#'
#' @param tibble A tibble containing grid cell statistics from KOSTRA-2010R.
#' @param d Duration in minutes.
#' @param tn Return period in years.
#'
#' @return A numerical vector including the precipitation height.
#' @export
#'
#' @examples
#' \dontrun{
#' get_precip(kdata, d=60, tn=50)
#' }
get_precip <- function(tibble, d, tn) {

  # debugging ------------------------------------------------------------------

  # tibble <- kdata
  # d <- 60
  # tn <- 50

  # main -----------------------------------------------------------------------

  # get index and return object
  tibble[tibble$D_min == d, which(attr(tibble, "returnperiods_a") == tn) + 2] %>%
    as.numeric()
}


