#' Visualize the spatial distribution of cell-specific statistical precipitation depths
#'
#' @param d numeric. Precipitation duration level \code{[min]}.
#' @param tn numeric. Return period \code{[a]}.
#'
#' @returns ggplot object.
#' @export
#'
#' @seealso [get_stats()]
#'
#' @examples
#' \dontrun{
#' ggplot_spatial(d = 60, tn = 1)
#'
#' ggplot_spatial(d = 1440, tn = 100)
#' }
ggplot_spatial <- function(d = NULL,
                           tn = NULL) {

  # debugging ------------------------------------------------------------------

  # d <- 60

  # tn <- 100

  # check arguments ------------------------------------------------------------

  x <- get_stats("117111")

  allowed_d <- attr(x, "durations_min")
  checkmate::assert_choice(d, allowed_d)

  allowed_tn <- attr(x, "returnperiods_a")
  checkmate::assert_choice(tn, allowed_tn)

  # pre-processing -------------------------------------------------------------

  d_name <- d |> stringr::str_pad(width = 5, side = "left", pad = "0") |> paste0("D", x = _)

  tn_name <- tn |> stringr::str_pad(width = 3, side = "left", pad = "0") |> paste0("HN_", x = _, "A_")

  lab_title <- "Spatial distribution of statistical precipitation depths"

  lab_subtitle <- paste0("D = ", d, " min | Tn = ", tn, " a")

  lab_caption <- paste0("Source: ", attr(x, "source"), ", Deutscher Wetterdienst 2022")

  # main -----------------------------------------------------------------------

  gg <- ggplot2::ggplot() +
    ggplot2::geom_sf(data = kostra_dwd_2020[[d_name]],
                     ggplot2::aes(fill = get(tn_name)), colour = NA) +
    ggplot2::scale_fill_viridis_c(option = "plasma", trans = "sqrt", na.value = "white") +
    ggplot2::labs(title = lab_title,
                  subtitle = lab_subtitle,
                  caption = lab_caption,
                  fill = "Precipitation depth [mm]")

  gg
}
