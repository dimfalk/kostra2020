#' Get return period class for specified precipitation depth
#'
#' @param data A tibble containing grid cell statistics from KOSTRA-2010R.
#' @param hn Precipitation depth in mm.
#' @param d Duration in minutes.
#'
#' @return A numerical vector representing the upper and lower boundaries of the
#'   return period class in years.
#' @export
#'
#' @examples
#' kostra <- get_stats("49011")
#' get_returnp(kostra, hn = 69.3, d = 1440)
get_returnp <- function(data = NULL,
                        hn = NULL,
                        d = NULL) {

  # debugging ------------------------------------------------------------------

  # data <- kostra
  # hn <- 69.3
  # d <- 1440

  # input validation -----------------------------------------------------------

  checkmate::assert_tibble(data)

  checkmate::assert_numeric(hn, len = 1, lower = 0)

  allowed_d <- attr(data, "durations_min")
  checkmate::assert_numeric(d, len = 1)
  checkmate::assert_choice(d, allowed_d)

  # pre-processing -------------------------------------------------------------

  # extract return periods from column names
  cnames <- colnames(data)[colnames(data) |> stringr::str_detect("HN_*")]
  rperiod <- cnames |> stringr::str_sub(start = 4, end = 6) |> as.numeric()

  # identify relevant row
  row <- data[which(data[["D_min"]] == d), cnames]

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

  # return object
  units::as_units(p, "a")
}
