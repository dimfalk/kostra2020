#' Get return period for specified precipitation depth
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-2010R.
#' @param hn numeric. Precipitation depth in mm.
#' @param d numeric. Duration in minutes.
#' @param interpolate logical. Return period as discrete value instead of an interval?
#'
#' @return units. Vector of length 2 representing the upper and lower boundaries
#'   of the return period class in years. Vector of length 1 with `interpolate = TRUE`.
#' @export
#'
#' @examples
#' kostra <- get_stats("49011")
#'
#' get_returnp(kostra, hn = 69.3, d = 1440)
#' get_returnp(kostra, hn = 69.3, d = 1440, interpolate = TRUE)
get_returnp <- function(x = NULL,
                        hn = NULL,
                        d = NULL,
                        interpolate = FALSE) {

  # debugging ------------------------------------------------------------------

  # x <- get_stats("49011")
  # hn <- 30.2
  # hn <- 42.8
  # hn <- 72.3
  # hn <- 86.3
  # d <- 1440
  # interpolate = TRUE

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  checkmate::assert_numeric(hn, len = 1, lower = 0)

  allowed_d <- attr(x, "durations_min")
  checkmate::assert_numeric(d, len = 1)
  checkmate::assert_choice(d, allowed_d)

  checkmate::assert_logical(interpolate)

  # pre-processing -------------------------------------------------------------

  # extract return periods from column names
  cnames <- colnames(x)[colnames(x) |> stringr::str_detect("HN_*")]
  rperiod <- cnames |> stringr::str_extract("[0-9]{1,5}") |> as.numeric()

  # identify relevant row
  row <- x[which(x[["D_min"]] == d), cnames]

  # main -----------------------------------------------------------------------

  # get index of closest value
  ind <- abs(row - hn) |> which.min()
  closest <- row[ind] |> as.numeric()

  # is the value explicitly mentioned as a class boundary?
  if(closest == hn) {

    p <- c(rperiod[which(row == closest)], rperiod[which(row == closest)])

    # is tn < 1?
  } else if (closest > hn && ind == 1) {

    p <- c(0, rperiod[which(row == closest)])

    # is the interval opening to the right or to the left for tn {1:100}?
  } else if (closest > hn && ind != 1) {

    p <- c(rperiod[which(row == closest)-1], rperiod[which(row == closest)])

  }  else if (closest < hn && ind != length(rperiod)) {

    p <- c(rperiod[which(row == closest)], rperiod[which(row == closest)+1])

    # is tn > 100?
  } else if (closest < hn && ind == length(rperiod)) {

    p <- c(rperiod[which(row == closest)], Inf)
  }

  if (interpolate == TRUE) {

    if (p[1] == 0) {

      "Extrapolation of tn < 1 a is not allowed." |> stop()

    } else if (p[2] == Inf) {

      "Extrapolation of tn > 100 a is not allowed." |> stop()

    } else if (p[1] == p[2]) {

      tn_array <- p + c(-0.01, 0.01)

      hn_array <- row[, which(rperiod == p[1]):which(rperiod == p[2])] |> as.numeric() + c(-0.01, 0.01)

    } else {

      tn_array <- p

      hn_array <- row[, which(rperiod == p[1]):which(rperiod == p[2])] |> as.numeric()
    }

    guess <- stats::approx(tn_array, hn_array, n = 100, method = "linear")

    p <- guess$x[abs(guess$y - hn) |> which.min()] |> round(1)
  }

  # return object
  units::as_units(p, "a")
}
