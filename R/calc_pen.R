#' Extrapolation of precipitation depths for Tn > 100 a according to PEN-LAWA
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-2010R.
#'
#' @return Tibble containing extrapolated precipitation depths as a function of
#'   duration and return periods.
#' @export
#'
#' @examples
#' kostra <- get_stats("49011")
#' pen <- calc_pen(kostra)
#'
#' @references Verworn & Kummer (2006): Praxisrelevante Extremwerte des Niederschlages (PEN).
#' @references Verworn & Draschoff (2008): PEN-Erweiterung.
calc_pen <- function(x = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- get_stats("49011")

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  # main -----------------------------------------------------------------------

  # hN for Tn = 1 a and Tn = 100 a
  hN_lower <- x[["HN_001A"]]
  hN_upper <- x[["HN_100A"]]

  # factors (-10 %, +20 %) to adjust for KOSTRA-related uncertainty taken from Malitz & Ertel (2015)
  if (attr(x, "source") == "KOSTRA-DWD-2010R") {

    u <- 0.9 * hN_lower
    w <- (1.2 * hN_upper - u) / log(100)

  } else if (attr(x, "source") == "DWA-A 531") {

    u <- hN_lower
    w <- (hN_upper - u) / log(100)
  }

  # init tibble
  tib <- x[c("D_min", "D_hour", "D_day")]

  # define return periods to be used for calculation
  rperiod <- c(200, 500, 1000, 2000, 5000, 10000)
  cnames <- paste0("HN_", rperiod, "A")

  # iterate over return periods and calculate statistical values
  for (i in 1:length(rperiod)) {

    tib[cnames[i]] <- (u + w * log(rperiod[i])) |> round(1)
  }

  # overwrite meta data
  attr(tib, "returnperiods_a") <- rperiod

  # return tibble
  tib
}
