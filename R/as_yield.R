#' Convert precipitation depth in precipitation yield as a function of duration
#'
#' @param x numeric. Precipitation depth \code{[mm]}.
#' @param d numeric. Precipitation duration level \code{[min]}.
#'
#' @return units. Precipitation yield \code{[l s-1 ha-1]}.
#' @export
#'
#' @seealso \link{as_depth}
#'
#' @examples
#' as_yield(x = 45.7, d = 60)
as_yield <- function(x = NULL,
                     d = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- 45.7
  # d <- 60

  # check arguments ------------------------------------------------------------

  checkmate::assert_numeric(x, len = 1)
  checkmate::assert_numeric(d, len = 1)

  # conversion to units --------------------------------------------------------

  if (inherits(x, "units")) NULL else x <- units::as_units(x, "mm")

  if (inherits(d, "units")) NULL else d <- units::as_units(d, "min")

  # main -----------------------------------------------------------------------

  units(d) <- "s"

  rh <- x / d

  units(rh) <- "l s-1 ha-1"

  rh |> round(1)
}
