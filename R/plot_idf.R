#' Visualize intensity-duration-frequency curves per grid cell statistics
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-DWD-2010R,
#'     as provided by `get_stats()`.
#'
#' @return ggplot object.
#' @export
#'
#' @seealso [get_stats()]
#'
#' @examples
#' get_stats("49125") |> plot_idf()
plot_idf <- function(x = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- get_stats("49011")
  # x <- get_stats("49011", as_depth = FALSE)

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  # pre-processing -------------------------------------------------------------

  if (attr(x, "type") == "HN") {

    cnames <- colnames(x)[colnames(x) |> stringr::str_detect("HN_*")]

    lab_y <- "precipitation depth [mm]"

  } else if (attr(x, "type") == "RN") {

    cnames <- colnames(x)[colnames(x) |> stringr::str_detect("RN_*")]

    lab_y <- "precipitation yield [l s-1 ha-1]"
  }

  x_long <- tidyr::pivot_longer(x, cols = tidyr::all_of(cnames))



  par <- stringr::str_extract(lab_y, pattern = "^.*(?= \\[)") |>
    stringr::str_to_sentence()

  lab_title <- paste0(par, " as a function of duration and return period")

  idx <- idx_decompose(attr(x, "id"))

  lab_subtitle <- paste0("INDEX_RC: ", attr(x, "id"), " ",
                         "(row ", idx[1], ", ",
                         "column ", idx[2], ")")

  lab_caption <- paste0("Source: ", attr(x, "source"), ", German Weather Service 2022")

  lab_legend <- attr(x, "returnperiods_a") |> as.character()

  # main -----------------------------------------------------------------------

  # plot tile statistics, colours according to return periods
  ggplot2::ggplot(x_long, ggplot2::aes(x = D_min, y = value, colour = name)) +
    ggplot2::geom_point() +
    ggplot2::geom_line() +
    ggplot2::labs(title = lab_title,
                  subtitle = lab_subtitle,
                  caption = lab_caption,
                  x = "duration [min]",
                  y = lab_y,
                  color = "return periods [a]") +
    ggplot2::scale_color_discrete(labels = lab_legend)
}
