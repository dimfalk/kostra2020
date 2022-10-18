#' Get cell-specific statistics from the KOSTRA-2010R data set
#'
#' @param grid_index A String representing the relevant "INDEX_RC" field.
#'
#' @return A tibble containing statistical precipitation depths as a function of
#'   duration and return periods for the KOSTRA-2010R grid cell specified.
#' @export
#'
#' @examples
#' kostra <- get_stats("49011")
get_stats <- function(grid_index = NULL) {

  # debugging ------------------------------------------------------------------

  # grid_index <- "49011"

  # input validation -----------------------------------------------------------

  checkmate::assert_character(grid_index, len = 1, min.chars = 1, max.chars = 6)

  # pre-processing -------------------------------------------------------------

  # get filenames for interval determination
  files <- list.files(system.file(package = "kostra2010R"),
    pattern = "*.shp",
    full.names = FALSE,
    recursive = TRUE
  )

  # parse intervals from file names
  intervals <- files |>
    stringr::str_sub(start = 60, end = 63) |>
    as.numeric()

  # overwrite filenames using full.names = TRUE for reading purposes
  files <- list.files(system.file(package = "kostra2010R"),
                      pattern = "*.shp",
                      full.names = TRUE,
                      recursive = TRUE
  )

  # read shapefile to extract column names and for index identification
  shp <- sf::st_read(files[1], quiet = TRUE)

  # get return periods from column names for subsetting
  cnames <- colnames(shp)[colnames(shp) |> stringr::str_detect("HN_*")]

  # get return periods from column names as numerical meta data
  rperiod <- cnames |>
    stringr::str_sub(start = 4, end = 6)|>
    as.numeric()

  # determine index based on user input
  ind <- which(shp[["INDEX_RC"]] == grid_index)

  # main -----------------------------------------------------------------------

  # built data.frame
  for (i in 1:length(files)) {

    # read shapefile as sf / data.frame
    shp <- sf::st_read(files[i], quiet = TRUE)

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
  cnames <- cnames |> stringr::str_sub(start = 1, end = -2)
  colnames(df) <- cnames

  # NA values
  df <- replace(df, df == -99.9, NA)

  # append interval duration
  df["D_min"] <- intervals

  # recalculate durations in hours
  df["D_hour"] <- df["D_min"] / 60

  # representation in hours not relevant for durations < 60 min
  df[["D_hour"]][which(df[["D_min"]] < 60)] <- NA

  # recalculate durations in days
  df["D_day"] <- df["D_hour"] / 24

  # representation in days not relevant for durations < 24 hours
  df[["D_day"]][which(df[["D_hour"]] < 24)] <- NA

  # re-arrange columns
  df <- df[c("D_min", "D_hour", "D_day", cnames)]

  # append meta data as attributes
  attr(df, "id") <- grid_index
  attr(df, "period") <- c("01.01.1951", "31.12.2010") |> strptime("%d.%m.%Y", tz = "CET")
  attr(df, "returnperiods_a") <- rperiod
  attr(df, "durations_min") <- intervals
  attr(df, "source") <- "KOSTRA-DWD-2010R"

  # return tibble
  dplyr::tibble(df)
}
