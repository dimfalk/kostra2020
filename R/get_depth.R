#' Get precipitation depth for a specified duration level and return period
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-DWD-2020,
#'     as provided by `get_stats()`.
#' @param d numeric. Precipitation duration level \code{[min]}.
#' @param tn numeric. Return period \code{[a]}.
#' @param uc logical. Consider grid cell uncertainties from
#'     KOSTRA-DWD-2020, as provided by `get_uncertainties()`?
#'
#' @return units. Precipitation depth \code{[mm]}.
#' @export
#'
#' @seealso [get_stats()], [get_uncertainties()]
#'
#' @examples
#' stats <- get_stats("117111")
#'
#' get_depth(stats, d = 60, tn = 50)
#' get_depth(stats, d = 60, tn = 50, uc = TRUE)
get_depth <- function(x = NULL,
                      d = NULL,
                      tn = NULL,
                      uc = FALSE) {

  # debugging ------------------------------------------------------------------

  # x <- get_stats("117111")
  # d <- 60
  # tn <- 50
  # uc <- TRUE

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  allowed_d <- attr(x, "durations_min")
  checkmate::assert_choice(d, allowed_d)

  allowed_tn <- attr(x, "returnperiods_a")
  checkmate::assert_choice(tn, allowed_tn)

  checkmate::assert_logical(uc)

  # main -----------------------------------------------------------------------

  # get index and return object
  ind <- which(attr(x, "returnperiods_a") == tn)

  hn <- x[x[["D_min"]] == d, ind + 3] |> as.numeric()

  if (uc == TRUE) {

    u <- attr(x, "id") |> get_uncertainties()

    p <- u[u[["D_min"]] == d, ind + 3] |> as.numeric() / 100

    hn <- (hn * c(1 - p, 1 + p)) |> round(1)
  }

  units::as_units(hn, "mm")
}
