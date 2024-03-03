#' Convert precipitation yield in precipitation depth as a function of duration
#'
#' @param x numeric. Precipitation yield \code{[l s-1 ha-1]}.
#' @param d numeric. Precipitation duration level \code{[min]}.
#'
#' @return units. Precipitation depth \code{[mm]}.
#' @export
#'
#' @seealso [as_yield()]
#'
#' @examples
#' as_depth(126.94, d = 60)
as_depth <- function(x = NULL,
                     d = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- 126.94
  # d <- 60

  # check arguments ------------------------------------------------------------

  checkmate::assert_numeric(x, min.len = 1, max.len = 2)
  checkmate::assert_numeric(d, len = 1)

  # conversion to units --------------------------------------------------------

  if (!inherits(x, "units")) x <- units::as_units(x, "l s-1 ha-1")

  if (!inherits(d, "units")) d <- units::as_units(d, "min")

  # main -----------------------------------------------------------------------

  units(x) <- "mm s-1"
  units(d) <- "s"

  hn <- x * d

  hn |> round(1)
}
