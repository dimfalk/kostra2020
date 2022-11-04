#' Convert precipitation depth in precipitation yield as a function of duration.
#'
#' @param hn numeric. Precipitation depth in mm.
#' @param d numeric. Duration in minutes.
#'
#' @return units. Precipitation yield in l/(s*ha).
#' @export
#'
#' @examples
#' as_yield(hn = 45.7, d = 60)
as_yield <- function(hn = NULL,
                     d = NULL) {

  # debugging ------------------------------------------------------------------

  # hn <- 45.7
  # d <- 60

  # input validation -----------------------------------------------------------

  checkmate::assert_numeric(hn, len = 1)
  checkmate::assert_numeric(d, len = 1)

  # main -----------------------------------------------------------------------

  (as.numeric(hn) * 10000 / 60 / d) |> round(1) |> units::as_units("l/(s*ha)")
}
