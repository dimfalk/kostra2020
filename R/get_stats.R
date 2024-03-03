#' Get cell-specific statistics from the KOSTRA-DWD-2020 dataset
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
#' get_stats("49125")
#' get_stats("49125", as_depth = FALSE)
get_stats <- function(x = NULL,
                      as_depth = TRUE) {

  # debugging ------------------------------------------------------------------

  # x <- "49125"
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

      df <- temp

    } else {

      df <- rbind(df, temp)
    }
  }

  # post-processing ------------------------------------------------------------

  # column names
  cnames <- stringr::str_sub(cnames, start = 1, end = -2)
  colnames(df) <- cnames

  # append interval duration
  df["D_min"] <- intervals

  # recalculate duration levels in hours
  df["D_hour"] <- df["D_min"] / 60

  # representation in hours not relevant for duration levels < 60 min
  df[["D_hour"]][which(df[["D_min"]] < 60)] <- NA

  # recalculate durations in days
  df["D_day"] <- df["D_hour"] / 24

  # representation in days not relevant for duration levels < 24 hours
  df[["D_day"]][which(df[["D_hour"]] < 24)] <- NA

  # re-arrange columns
  df <- df[c("D_min", "D_hour", "D_day", cnames)]

  # append meta data as attributes
  attr(df, "id") <- x
  attr(df, "period") <- c("01.01.1951", "31.12.2020") |>
    strptime("%d.%m.%Y", tz = "Etc/GMT-1") |>
    as.POSIXct()
  attr(df, "returnperiods_a") <- rperiod
  attr(df, "durations_min") <- intervals
  attr(df, "type") <- "HN"
  attr(df, "source") <- "KOSTRA-DWD-2020"

  # return depth or yield? -----------------------------------------------------

  if (as_depth == FALSE) {

    colnames(df) <- colnames(df) |> stringr::str_replace_all(pattern = "HN", "RN")

    df[, 4:12] <- (df[, 4:12] * 166.67 / df[["D_min"]]) |> round(1)

    attr(df, "type") <- "RN"
  }

  # return object
  tibble::as_tibble(df)
}
