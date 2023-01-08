#' Get precipitation depth for a specified duration level and return period
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-DWD-2020,
#'     as provided by `get_stats()`.
#' @param d numeric. Precipitation duration level \code{[min]}.
#' @param tn numeric. Return period \code{[a]}.
#' @param uncertain (optional) logical. Consider grid cell uncertainties from
#'     KOSTRA-DWD-2020, as provided by `get_uncertainties()`?
#'
#' @return units. Precipitation depth \code{[mm]}.
#' @export
#'
#' @seealso \link{get_stats}, \link{get_uncertainties}
#'
#' @examples
#' kostra <- get_stats("49125")
#'
#' get_depth(kostra, d = 60, tn = 50)
#' get_depth(kostra, d = 60, tn = 50, uncertain = TRUE)
get_depth <- function(x = NULL,
                      d = NULL,
                      tn = NULL,
                      uncertain = FALSE) {

  # debugging ------------------------------------------------------------------

  # x <- get_stats("49125")
  # d <- 60
  # tn <- 50
  # uncertain <- TRUE

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  allowed_d <- attr(x, "durations_min")
  checkmate::assert_numeric(d, len = 1)
  checkmate::assert_choice(d, allowed_d)

  allowed_tn <- attr(x, "returnperiods_a")
  checkmate::assert_numeric(tn, len = 1)
  checkmate::assert_choice(tn, allowed_tn)

  checkmate::assert_logical(uncertain)

  # main -----------------------------------------------------------------------

  # get index and return object
  ind <- which(attr(x, "returnperiods_a") == tn)

  hn <- x[x[["D_min"]] == d, ind + 3] |> as.numeric()

  if (uncertain == TRUE) {

    u <- get_uncertainties(attr(x, "id"))

    p <- u[u[["D_min"]] == d, ind + 3] |> as.numeric() / 100

    hn <- c(hn * (1 - p), hn * (1 + p)) |> round(1)
  }

  units::as_units(hn, "mm")
}
