#' Extrapolation of precipitation heights for Tn > 100 a according to PEN-LAWA
#'
#' @param tibble Cell-based statistics derived from KOSTRA-2010R
#'
#' @return A tibble containing extrapolated precipitation heights as a function
#'   of duration and return periods.
#' @export
#'
#' @examples
#' \dontrun{
#' calc_pen(kostra)
#' }
#' @references Verworn & Draschoff (2006)
#' @references Verworn & Kummer (2008)
calc_pen <- function(tibble) {

  # hN for Tn = 1 a and Tn = 100 a
  hN_lower <- tibble[["HN_001A"]]
  hN_upper <- tibble[["HN_100A"]]

  # log = natural logarithm (ln);
  # base = euler's number e = exp(1)
  u <- 0.9 * hN_lower
  w <- (1.2 * hN_upper - u) / log(100)

  # init tibble
  tib <- tibble[c("D_min", "D_hour")]

  # define return periods to be used for calculation
  rperiod <- c(200, 500, 1000, 2000, 5000, 10000)
  cnames <- paste0("HN_", rperiod, "A")

  # iterate over return periods and calculate statistical values
  for (i in 1:length(rperiod)) {

    tib[cnames[i]] <- (u + w * log(rperiod[i])) %>% round(1)
  }

  # overwrite meta data
  attr(tib, "returnperiods_a") <- rperiod

  # return tibble
  tib
}
