#' Visualize intensity-duration-frequency curves per cell-specific statistics from KOSTRA-DWD-2020 dataset
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-DWD-2020,
#'     as provided by `get_stats()`.
#' @param tn (optional) numeric. Return period \code{[a]} to be used for filtering.
#' @param log10 logical. Transform x axis to log10 scale?
#'
#' @return ggplot object.
#' @export
#'
#' @seealso [get_stats()]
#'
#' @examples
#' get_stats("117111") |> ggplot_idf()
#'
#' get_stats("117111") |> ggplot_idf(tn = 100)
#'
#' get_stats("117111") |> ggplot_idf(log10 = TRUE)
ggplot_idf <- function(x = NULL,
                       tn = NULL,
                       log10 = FALSE) {

  # debugging ------------------------------------------------------------------

  # x <- get_stats("117111")
  # x <- get_stats("117111", as_depth = FALSE)

  # tn <- 100

  # log10 <- TRUE

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  allowed_tn <- attr(x, "returnperiods_a")

  checkmate::assert(

    checkmate::test_null(tn),

    checkmate::test_choice(tn, allowed_tn)
  )

  checkmate::assert_logical(log10, len = 1)

  # pre-processing -------------------------------------------------------------

  # optionally filter for tn
  if(!is.null(tn)) {

    x <- dplyr::select(x,
                       D_min,
                       dplyr::contains(as.character(tn) |> stringr::str_pad(width = 3,
                                                                            side = "left",
                                                                            pad = "0")))

    attr(x, "returnperiods_a") <- tn
  }

  # labels
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

  lab_caption <- paste0("Source: ", attr(x, "source"), ", Deutscher Wetterdienst 2022")

  lab_legend <- attr(x, "returnperiods_a") |> as.character()



  # y-axis ticks
  val_max <- x_long[["value"]] |> max() |> round(-1)

  if(val_max < 200) {

    y_ticks <- seq(from = 0, to = val_max, by = 10)

  } else {

    y_ticks <- seq(from = 0, to = val_max, by = 20)
  }

  # main -----------------------------------------------------------------------

  # plot tile statistics, colours according to return periods
  gg <- ggplot2::ggplot(x_long, ggplot2::aes(x = D_min, y = value, colour = name)) +
    ggplot2::geom_point() +
    ggplot2::geom_line() +
    ggplot2::labs(title = lab_title,
                  subtitle = lab_subtitle,
                  caption = lab_caption,
                  x = "duration [min]",
                  y = lab_y,
                  color = "return periods [a]") +
    ggplot2::scale_y_continuous(breaks = y_ticks,
                                labels = y_ticks) +
    ggplot2::scale_color_discrete(labels = lab_legend)

  if (log10 == TRUE) {

    gg <- gg + ggplot2::scale_x_continuous(trans = "log10",
                                           breaks = attr(x, "durations_min"),
                                           labels = attr(x, "durations_min"),
                                           guide = ggplot2::guide_axis(angle = 90))
  }

  # return object
  gg
}
