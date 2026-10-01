#' Get cell-specific statistics from KOSTRA-DWD-2020 dataset
#'
#' @param x character. Relevant "INDEX_RC" field to be queried.
#' @param as_depth logical. Returns precipitation depths when `TRUE` and precipitation
#'     yields when `FALSE`.
#'
#' @return Tibble containing statistical precipitation depths/yields as a function of
#'     duration and return period for the KOSTRA-DWD-2020 grid cell specified.
#' @export
#'
#' @seealso [idx_build()]
#'
#' @examples
#' get_stats("117111")
#' get_stats("117111", as_depth = FALSE)
get_stats <- function(x = NULL,
                      as_depth = TRUE) {

  # debugging ------------------------------------------------------------------

  # x <- "117111"
  # as_depth <- FALSE

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1, min.chars = 1, max.chars = 6)

  stopifnot("'INDEX_RC' specified does not exist." = idx_exists(x))

  checkmate::assert_logical(as_depth)

  # pre-processing -------------------------------------------------------------

  # parse intervals from file names
  intervals <- names(kostra_dwd_2020) |>
    stringr::str_sub(start = 2, end = 6) |>
    as.numeric()

  # read sf object to extract column names and for index identification
  shp <- kostra_dwd_2020[[1]]

  # get return periods from column names for subsetting
  cnames <- colnames(shp)[colnames(shp) |> stringr::str_detect("HN_*")]

  # get return periods from column names as numerical meta data
  rperiod <- cnames |>
    stringr::str_sub(start = 4, end = 6) |>
    as.numeric()

  # determine index based on user input
  ind <- which(shp[["INDEX_RC"]] == x)

  # main -----------------------------------------------------------------------

  # build data frame
  for (i in 1:length(intervals)) {

    # read shapefile as sf / data frame
    shp <- kostra_dwd_2020[[i]]

    # subset original data.frame based on index, relevant columns
    temp <- shp[ind, cnames] |> sf::st_drop_geometry()

    # init data.frame, otherwise rbind
    if (i == 1) {

      res <- temp

    } else {

      res <- rbind(res, temp)
    }
  }

  # post-processing ------------------------------------------------------------

  # column names
  cnames <- stringr::str_sub(cnames, start = 1, end = -2)
  colnames(res) <- cnames

  # append interval duration
  res["D_MIN"] <- intervals

  # re-arrange columns
  res <- res[c("D_MIN", cnames)]

  # append meta data as attributes
  attr(res, "id") <- x
  attr(res, "name") <- NA
  attr(res, "period") <- c("01.01.1951", "31.12.2020") |>
    strptime("%d.%m.%Y", tz = "Etc/GMT-1") |>
    as.POSIXct()
  attr(res, "returnperiods_a") <- rperiod
  attr(res, "durations_min") <- intervals
  attr(res, "type") <- "HN"
  attr(res, "source") <- "KOSTRA-DWD-2020"

  # return depth or yield? -----------------------------------------------------

  if (as_depth == FALSE) {

    colnames(res) <- colnames(res) |> stringr::str_replace_all(pattern = "HN", "RN")

    res[, 4:10] <- (res[, 4:10] * 166.67 / res[["D_MIN"]]) |> round(1)

    attr(res, "type") <- "RN"
  }

  # return object
  tibble::as_tibble(res)
}
