
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
  attr(xts, "STAT_NAME") <- "MODEL"
  attr(xts, "TS_TYPE") <- "simulation"
  attr(xts, "REMARKS") <- paste0("D = ", d, " mins; Tn = ", tn, " a; Type = ", type)

  # return object
  xts
}
