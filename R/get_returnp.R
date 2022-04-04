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
#' get_returnp(kdata, hn=69.3, d=1440)
#' }
get_returnp <- function(tibble, hn, d) {

  # debugging ------------------------------------------------------------------

  # tibble <- kdata
  # hn <- 69.3
  # d <- 1440

  # pre-processing -------------------------------------------------------------

  # extract return periods from column names
  cnames <- colnames(tibble)[colnames(tibble) %>% stringr::str_detect("HN_*")]
  rperiod <- cnames %>% stringr::str_sub(start = 4, end = 6) %>% as.numeric()

  # identify relevant row
  row <- tibble[which(tibble[["D_min"]] == d), cnames]

  # calculate and return -------------------------------------------------------

  # get index of closest value
  ind <- which.min(abs(row - hn))
  closest <- row[ind] %>% as.numeric()

  # is the value explicitly mentioned as a class boundary?
  if(closest == hn) {

    rperiod[which(row == closest)]

    # otherwise, is the interval opening to the right or to the left?
  } else if (closest > hn) {

    c(rperiod[which(row == closest)-1], rperiod[which(row == closest)])

  } else {

    c(rperiod[which(row == closest)], rperiod[which(row == closest)+1])
  }
}


