#' Get precipitation depth for a specified duration and return period
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-2010R.
#' @param d numeric. Duration in minutes.
#' @param tn numeric. Return period in years.
#'
#' @return units. Precipitation depth in mm.
#' @export
#'
#' @examples
#' kostra <- get_stats("49011")
#'
#' get_pdepth(kostra, d = 60, tn = 50)
get_pdepth <- function(x = NULL,
                       d = NULL,
                       tn = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- get_stats("49011")
  # d <- 60
  # tn <- 50

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  allowed_d <- attr(x, "durations_min")
  checkmate::assert_numeric(d, len = 1)
  checkmate::assert_choice(d, allowed_d)

  allowed_tn <- attr(x, "returnperiods_a")
  checkmate::assert_numeric(tn, len = 1)
  checkmate::assert_choice(tn, allowed_tn)

  # main -----------------------------------------------------------------------

  # get index and return object
  ind <- which(attr(x, "returnperiods_a") == tn)

  x[x[["D_min"]] == d, ind + 3] |> as.numeric() |> units::as_units("mm")
}
