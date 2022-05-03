#' Get return period class for specified precipitation height
#'
#' @param tibble A tibble containing grid cell statistics from KOSTRA-2010R.
#' @param hn Precipitation height in mm.
#' @param d Duration in minutes.
#'
#' @return A numerical vector representing the upper and lower boundaries of the
#'   return period class.
#' @export
#'
#' @examples
#' \dontrun{
#' get_returnp(kostra, hn=69.3, d=1440)
#' }
get_returnp <- function(tibble, hn, d) {

  # debugging ------------------------------------------------------------------

  # tibble <- kostra
  # hn <- 69.3
  # d <- 1440

  # pre-processing -------------------------------------------------------------

  # extract return periods from column names
  cnames <- colnames(tibble)[colnames(tibble) %>% stringr::str_detect("HN_*")]
  rperiod <- cnames %>% stringr::str_sub(start = 4, end = 6) %>% as.numeric()

  # identify relevant row
  row <- tibble[which(tibble[["D_min"]] == d), cnames]

  # main -----------------------------------------------------------------------

  # get index of closest value
  ind <- which.min(abs(row - hn))
  closest <- row[ind] %>% as.numeric()

  # is the value explicitly mentioned as a class boundary?
  if(closest == hn) {

    c(rperiod[which(row == closest)], rperiod[which(row == closest)])

    # is tn < 1?
  } else if (closest > hn & ind == 1) {

    c(0, rperiod[which(row == closest)])

    # is the interval opening to the right or to the left for tn {1:100}?
  } else if (closest > hn & ind != 1) {

    c(rperiod[which(row == closest)-1], rperiod[which(row == closest)])

  }  else if (closest < hn & ind != length(rperiod)) {

    c(rperiod[which(row == closest)], rperiod[which(row == closest)+1])

    # is tn > 100?
  } else if (closest < hn & ind == length(rperiod)) {

    c(rperiod[which(row == closest)], Inf)
  }
}
