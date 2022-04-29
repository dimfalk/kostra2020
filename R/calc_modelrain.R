
#' Calculate model rainfall from statistical precipitation
#'
#' @param tibble containing statistics
#' @param d duration in minutes
#' @param tn return periods in years
#' @param type EulerI | EulerII
#'
#' @return xts
#' @export
#'
#' @examples \dontrun{
#' xts <- calc_modelrain(kostra, d = 60, tn = 100, type = "EulerII")
#' }
#' @references EulerI + EulerII
calc_modelrain <- function(tibble, d, tn, type = "EulerII") {

  kostra_rel <- tibble[1, c(1, 3:11)]

  kostra_rel[2:18, 2:10] <- tibble[2:18, 3:11] - tibble[1:17, 3:11]

  kostra_rel["D_min"] <- tibble["D_min"]

  kostra_5min <- data.frame(D_min = seq(5, d, 5)) %>% tibble::as_tibble()

  n_timesteps <- kostra_5min[["D_min"]] %>% length()

  d_pos <- c(1:which(tibble["D_min"] == d)) %>% sort(decreasing = TRUE)

  kostra_5min <- merge(kostra_5min, kostra_rel[1:d_pos[1], c(1, 2:10)], by = "D_min", all = TRUE)

  steps <- (tibble[["D_min"]][1:d_pos[1]] %>% diff() / 5) %>% sort(decreasing = TRUE)

  steps <- steps[steps > 1]

  steps_cum <- c(0, steps) %>% cumsum()

  for (i in 1:length(steps)) {

    recent_step <- c(n_timesteps - steps_cum[i], n_timesteps - steps_cum[i+1])

    kostra_5min[recent_step[1]:(recent_step[2]+1), 2:10] <- kostra_rel[d_pos[i], 2:10] / steps[i]
  }

  start <- "2000-01-01 00:00" %>% strptime(format="%Y-%m-%d %H:%M") %>% as.POSIXct()

  datetimes <- seq(from = start, by = 60 * 5, length.out = n_timesteps)

  values <- kostra_5min[, which(attr(tibble, "returnperiods_a") == tn)] %>% round(2)

  if (type == "EulerI") {

    # do nothing, order is correct by dedault

  } else  if (type == "EulerII") {

    breakpoint <- stats::quantile(1:n_timesteps, probs = 0.3) %>% round(0) %>% as.numeric()

    values[1:breakpoint] <- values[1:breakpoint] %>% sort(decreasing = FALSE)
  }

  xts <- xts::xts(values, order.by = datetimes)

  attr(xts, "STAT_ID") <- "MODEL"

  xts
}

# plot(xts, type="h")

