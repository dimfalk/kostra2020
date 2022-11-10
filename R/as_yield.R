#' Convert precipitation depth in precipitation yield as a function of duration.
#'
#' @param x numeric. Precipitation depth in mm.
#' @param d numeric. Duration in minutes.
#'
#' @return units. Precipitation yield in l/(s*ha).
#' @export
#'
#' @examples
#' as_yield(45.7, d = 60)
as_yield <- function(x = NULL,
                     d = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- 45.7
  # d <- 60

  # input validation -----------------------------------------------------------

  checkmate::assert_numeric(x, len = 1)
  checkmate::assert_numeric(d, len = 1)

  # main -----------------------------------------------------------------------

  (as.numeric(x) * 10000 / 60 / d) |> round(1) |> units::as_units("l/(s*ha)")
}
