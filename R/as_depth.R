#' Convert precipitation yield in precipitation depth as a function of duration.
#'
#' @param x numeric. Precipitation yield in l/(s*ha).
#' @param d numeric. Duration in minutes.
#'
#' @return units. Precipitation depth in mm.
#' @export
#'
#' @examples
#' as_depth(126.94, d = 60)
as_depth <- function(x = NULL,
                     d = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- 126.94
  # d <- 60

  # input validation -----------------------------------------------------------

  checkmate::assert_numeric(x, len = 1)
  checkmate::assert_numeric(d, len = 1)

  # main -----------------------------------------------------------------------

  (as.numeric(x) / 10000 * 60 * d) |> round(1) |> units::as_units("mm")
}
