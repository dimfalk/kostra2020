#' Convert precipitation yield in precipitation depth as a function of duration.
#'
#' @param rn numeric. Precipitation yield in l/(s*ha).
#' @param d numeric. Duration in minutes.
#'
#' @return units. Precipitation depth in mm.
#' @export
#'
#' @examples
#' as_depth(rn = 126.94, d = 60)
as_depth <- function(rn = NULL,
                     d = NULL) {

  # debugging ------------------------------------------------------------------

  # rn <- 126.94
  # d <- 60

  # input validation -----------------------------------------------------------

  checkmate::assert_numeric(rn, len = 1)
  checkmate::assert_numeric(d, len = 1)

  # main -----------------------------------------------------------------------

  (as.numeric(rn) / 10000 * 60 * d) |> round(1) |> units::as_units("mm")
}
