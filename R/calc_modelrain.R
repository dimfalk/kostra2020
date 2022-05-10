
#' Calculate model rainfall from statistical precipitation
#'
#' @param data A tibble containing grid cell statistics from KOSTRA-2010R.
#' @param d Duration in minutes.
#' @param tn Return periods in years.
#' @param type EulerI | EulerII.
#'
#' @return An xts object.
#' @export
#'
#' @examples
#' \dontrun{
#' xts <- calc_modelrain(kostra, d = 60, tn = 20, type = "EulerII")
#' }
calc_modelrain <- function(data, d, tn, type = "EulerII") {

  # debugging ------------------------------------------------------------------

  # data <- kostra
  # d <- 60
  # tn <- 100
  # type <- "EulerII"

  # input validation -----------------------------------------------------------

  if (missing(d)) {

    stop("Duration has not been passed as an argument to the function.")

  } else {

    if (!inherits(d, "numeric")) {

      stop("Duration level has to be of type numeric, e.g `d = 60`.")

    } else {

      set <- c(5, 10, 15, 20, 30, 45, 60, 90, 120, 180, 240, 360, 540, 720, 1080, 1440, 2880, 4320)

      if (!(d %in% set)) {

        stop("Duration level specified is not allowed. Please pick a value from the following: \n",
             paste0(set, collapse = " "))
      }
    }
  }

  # pre-processing -------------------------------------------------------------

  # locate index of specified duration, generate sequence for further indexing
  d_pos <- which(data["D_min"] == d) %>% seq() %>% sort(decreasing = TRUE)

  # init a new object using a subset of relevant durations
  kostra_rel <- data[sort(d_pos), ]

  # recalculate statistic, relative values per duration interval
  kostra_rel[2:length(d_pos), -1:-3] <- data[2:length(d_pos), -1:-3] - data[1:(length(d_pos) - 1), -1:-3]

  # init new object using time steps of 5 mins width, equidistant statistic
  kostra_5min <- data.frame(D_min = seq(5, d, 5)) %>% tibble::as_tibble()

  n_timesteps <- kostra_5min[["D_min"]] %>% length()

  # merge equidistant statistic with relative values
  kostra_5min <- merge(kostra_5min,
                       kostra_rel,
                       by = "D_min",
                       all = TRUE)

  # iterator definition, delta_t between intervals divided by resolution
  steps <- (data[["D_min"]][1:d_pos[1]] %>% diff() / 5) %>%
    sort(decreasing = TRUE)

  # drop steps == 1, since these values can be adopted from original statistic
  steps <- steps[steps > 1]

  # cumulative view to facilitate indexing
  steps_cum <- c(0, steps) %>% cumsum()

  # iterate over steps, equidistant recalculation
  for (i in 1:length(steps)) {

    # interval definition
    recent_step <- c(n_timesteps - steps_cum[i], n_timesteps - steps_cum[i+1])

    # extract, divide and distribute values in corresponding rows
    kostra_5min[recent_step[1]:(recent_step[2]+1), -1:-3] <- kostra_rel[d_pos[i], -1:-3] / steps[i]
  }

  # get filenames for centroid calculation
  files <- list.files(system.file(package = "kostra2010R"),
                      pattern = "*.shp",
                      full.names = TRUE,
                      recursive = TRUE
  )

  # read shapefile to extract column names and for index identification
  tile <- sf::st_read(files[1], quiet = TRUE)

  # subset shapefile to relevant tile
  tile <- tile[tile[["INDEX_RC"]] == attr(data, "index_rc"), ]

  # calculate centroids
  centroid <- sf::st_centroid(tile[["geometry"]]) %>% sf::st_transform(25832) %>% sf::st_coordinates()

  # main -----------------------------------------------------------------------

  # generate fictional datetime index
  start <- "2000-01-01 00:00" %>%
    strptime(format="%Y-%m-%d %H:%M") %>%
    as.POSIXct()

  datetimes <- seq(from = start, by = 60 * 5, length.out = n_timesteps)

  # access relative 5min values
  values <- kostra_5min[, which(attr(data, "returnperiods_a") == tn) + 3] %>% round(2)


  if (type == "EulerI") {

    # do nothing, order is correct by default

  } else  if (type == "EulerII") {

    # get position of 0.3 quantile
    breakpoint <- stats::quantile(1:n_timesteps, probs = 0.3) %>% round(0) %>% as.numeric()

    # values in increasing order for first positions up to 0.3 quantile
    values[1:breakpoint] <- values[1:breakpoint] %>% sort(decreasing = FALSE)
  }

  # create xts object
  xts <- xts::xts(values, order.by = datetimes)

  # append meta data as attributes
  attr(xts, "STAT_ID") <- attr(data, "index_rc")
  attr(xts, "STAT_NAME") <- attr(data, "source")

  attr(xts, "X") <- centroid[1]
  attr(xts, "Y") <- centroid[2]
  attr(xts, "CRS_EPSG") <- "25832"

  attr(xts, "PARAMETER") <- "Niederschlagshöhe"

  attr(xts, "TS_START") <- datetimes %>% min()
  attr(xts, "TS_END") <- datetimes %>% max()
  attr(xts, "TS_TYPE") <- "simulation"

  attr(xts, "MEAS_UNIT") <- "mm"
  attr(xts, "MEAS_INTERVALTYPE") <- TRUE
  attr(xts, "MEAS_RESOLUTION") <- 5
  attr(xts, "MEAS_BLOCKING") <- "right"
  attr(xts, "MEAS_STATEMENT") <- "sum"

  attr(xts, "REMARKS") <- paste0("Modelled rainfall of type ", type, " with D = ", d, " mins and Tn = ", tn, " a, hN = ", zoo::coredata(xts) %>% sum(), " mm")

  # return object
  xts
}
