#' Get precipitation depth for a specified duration and return period
#'
#' @param data A tibble containing grid cell statistics from KOSTRA-2010R.
#' @param d Duration in minutes.
#' @param tn Return period in years.
#'
#' @return Precipitation depth.
#' @export
#'
#' @examples
#' \dontrun{
#' get_pdepth(kostra, d = 60, tn = 50)
#' }
get_pdepth <- function(data = NULL,
                       d = NULL,
                       tn = NULL) {

  # debugging ------------------------------------------------------------------

  # data <- kostra
  # d <- 60
  # tn <- 50

  # input validation -----------------------------------------------------------

  checkmate::assert_tibble(data)

  allowed_d <- attr(data, "durations_min")
  checkmate::assert_numeric(d, len = 1)
  checkmate::assert_choice(d, allowed_d)

  allowed_tn <- attr(data, "returnperiods_a")
  checkmate::assert_numeric(tn, len = 1)
  checkmate::assert_choice(tn, allowed_tn)

  # main -----------------------------------------------------------------------

  # get index and return object
  ind <- which(attr(data, "returnperiods_a") == tn)

  data[data[["D_min"]] == d, ind + 3] |> as.numeric() |> units::as_units("mm")
}
