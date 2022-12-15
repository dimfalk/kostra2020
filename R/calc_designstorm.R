#' Design storm calculation based on statistical precipitation depths
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-DWD-2010R.
#' @param d numeric. Precipitation duration level \code{[min]}.
#' @param tn numeric. Return period \code{[a]}.
#' @param type character. Precipitation distribution: "EulerI" or "EulerII".
#'
#' @return An xts object.
#' @export
#'
#' @examples
#' kostra <- get_stats("49011")
#'
#' calc_designstorm(kostra, tn = 20, d = 60, type = "EulerII")
calc_designstorm <- function(x = NULL,
                             tn = NULL,
                             d = NULL,
                             type = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- kostra
  # tn <- 20
  # d <- 60
  # type <- "EulerII"

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  allowed_tn <- attr(x, "returnperiods_a")
  checkmate::assert_numeric(tn, len = 1)
  checkmate::assert_choice(tn, allowed_tn)

  allowed_d <- attr(x, "durations_min")
  checkmate::assert_numeric(d, len = 1)
  checkmate::assert_choice(d, allowed_d)

  allowed_type <- c("EulerI", "EulerII")
  checkmate::assert_character(type, len = 1)
  checkmate::assert_choice(type, allowed_type)

  # pre-processing -------------------------------------------------------------

  # locate index of specified duration, generate sequence for further indexing
  d_pos <- which(x["D_min"] == d) |> seq() |> sort(decreasing = TRUE)

  # init a new object using a subset of relevant duration levels
  x_rel <- x[sort(d_pos), ]

  if (d > 5) {

    # recalculate statistic to relative values per duration interval
    x_rel[2:length(d_pos), -1:-3] <- x[2:length(d_pos), -1:-3] - x[1:(length(d_pos) - 1), -1:-3]
  }

  # init new df object using time steps of 5 mins width, equidistant stats
  x_5min <- data.frame(D_min = seq(5, d, 5)) |> tibble::as_tibble()

  n_timesteps <- x_5min[["D_min"]] |> length()

  # merge constructed intervals with relative values from statistics
  x_5min <- merge(x_5min,
                  x_rel,
                  by = "D_min",
                  all = TRUE)

  if (d > 5) {

    # iterator definition, delta_t between intervals divided by resolution
    steps <- (x[["D_min"]][1:d_pos[1]] |> diff() / 5) |>
      sort(decreasing = TRUE)

    # drop steps == 1, since these values can be adopted from original statistic
    steps <- steps[steps > 1]

    # cumulate values to facilitate indexing
    steps_cum <- c(0, steps) |> cumsum()

    # iterate over steps, equidistant recalculation (if necessary)
    # not necessary for the first rows: d = 10, 15, 20 mins
    if (length(steps) != 0) {

      for (i in 1:length(steps)) {

        # interval definition
        recent_step <- c(n_timesteps - steps_cum[i], n_timesteps - steps_cum[i+1])

        # extract, divide and distribute values in corresponding rows
        x_5min[recent_step[1]:(recent_step[2]+1), -1:-3] <- x_rel[d_pos[i], -1:-3] / steps[i]
      }
    }
  }

  # main -----------------------------------------------------------------------

  # generate fictional datetime index
  start <- "2000-01-01 00:00" |>
    strptime(format="%Y-%m-%d %H:%M") |>
    as.POSIXct(tz = "Etc/GMT-1")

  datetimes <- seq(from = start, by = 60 * 5, length.out = n_timesteps)

  # access relative 5 min values
  values <- x_5min[, which(attr(x, "returnperiods_a") == tn) + 3] |> round(2)

  # re-arrange values according to chosen precipitation distribution
  if (type == "EulerI") {

    # do nothing, order is correct by default

  } else if (type == "EulerII") {

    # get position of 0.3 quantile
    breakpoint <- stats::quantile(1:n_timesteps, probs = 0.3) |>
      round(0) |>
      as.numeric()

    # values in increasing order for first positions up to 0.3 quantile
    values[1:breakpoint] <- values[1:breakpoint] |> sort(decreasing = FALSE)
  }

  # create xts object
  xts <- xts::xts(values, order.by = datetimes, tzone = "Etc/GMT-1")

  # post-processing ------------------------------------------------------------

  # get centroid coordinates from KOSTRA-DWD-2010R tiles
  if (attr(x, "source") == "KOSTRA-DWD-2010R") {

    # read shapefile for centroid coordinate estimation
    tiles <- kostra_dwd_2010r[[1]]

    # subset shapefile to relevant tile
    tile <- tiles |> dplyr::filter(INDEX_RC == attr(x, "id"))

    # calculate centroid
    centroid <- tile[["geometry"]] |>
      sf::st_centroid() |>
      sf::st_transform(25832) |>
      sf::st_coordinates()
  }

  # append meta data as attributes
  # TODO: timeseriesIO::xts_init("light")
  if (attr(x, "source") == "KOSTRA-DWD-2010R") {

    attr(xts, "STAT_ID") <- attr(x, "id")
    attr(xts, "STAT_NAME") <- attr(x, "source")
    attr(xts, "X") <- centroid[1]
    attr(xts, "Y") <- centroid[2]

  } else if (attr(x, "source") == "DWA-A 531") {

    attr(xts, "STAT_ID") <- attr(x, "id")
    attr(xts, "STAT_NAME") <- attr(x, "name")
    attr(xts, "X") <- " "
    attr(xts, "Y") <- " "
  }

  attr(xts, "CRS_EPSG") <- "25832"
  attr(xts, "PARAMETER") <- "Niederschlagshoehe"

  attr(xts, "TS_START") <- attr(x, "period")[1]
  attr(xts, "TS_END") <- attr(x, "period")[2]
  attr(xts, "TS_TYPE") <- "simulation"

  attr(xts, "MEAS_UNIT") <- "mm"
  attr(xts, "MEAS_INTERVALTYPE") <- TRUE
  attr(xts, "MEAS_RESOLUTION") <- 5
  attr(xts, "MEAS_BLOCKING") <- "right"
  attr(xts, "MEAS_STATEMENT") <- "sum"

  type_long <- switch(type,

                      "EulerI" = "Euler Typ I",
                      "EulerII" = "Euler Typ II")

  attr(xts, "REMARKS") <- paste0("Modellregen ", type_long, " auf Grundlage von ", attr(x, "source"), "\n",
                                 "Tn = ", tn, " a | D = ", d, " min | hN = ", zoo::coredata(xts) |> sum(), " mm\n",
                                 rep("-", 80) |> paste(collapse = ""), "\n")

  # return object
  xts
}
