#' Get return period class for specified precipitation height
#'
#' @param data A tibble containing grid cell statistics from KOSTRA-2010R.
#' @param hn Precipitation height in mm.
#' @param d Duration in minutes.
#'
#' @return A numerical vector representing the upper and lower boundaries of the
#'   return period class.
#' @export
#'
#' @examples
#' \dontrun{
#' get_returnp(kostra, hn = 69.3, d = 1440)
#' }
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

  allowed_d <- c(5, 10, 15, 20, 30, 45, 60, 90, 120, 180, 240, 360, 540, 720,
                 1080, 1440, 2880, 4320)
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

    c(rperiod[which(row == closest)], rperiod[which(row == closest)])

    # is tn < 1?
  } else if (closest > hn && ind == 1) {

    c(0, rperiod[which(row == closest)])

    # is the interval opening to the right or to the left for tn {1:100}?
  } else if (closest > hn && ind != 1) {

    c(rperiod[which(row == closest)-1], rperiod[which(row == closest)])

  }  else if (closest < hn && ind != length(rperiod)) {

    c(rperiod[which(row == closest)], rperiod[which(row == closest)+1])

    # is tn > 100?
  } else if (closest < hn && ind == length(rperiod)) {

    c(rperiod[which(row == closest)], Inf)
  }
}
