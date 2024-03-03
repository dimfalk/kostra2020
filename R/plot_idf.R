#' Visualize intensity-duration-frequency curves per grid cell statistics
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-DWD-2010R,
#'     as provided by `get_stats()`.
#' @param tn (optional) numeric. Return period \code{[a]} to be used for filtering.
#'
#' @return ggplot object.
#' @export
#'
#' @seealso [get_stats()]
#'
#' @examples
#' get_stats("49125") |> plot_idf()
#'
#' get_stats("49125") |> plot_idf(tn = 100)
plot_idf <- function(x = NULL,
                     tn = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- get_stats("49011")
  # x <- get_stats("49011", as_depth = FALSE)

  # tn <- 100

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  allowed_tn <- attr(x, "returnperiods_a")

  checkmate::assert(

    checkmate::test_null(tn),

    checkmate::test_choice(tn, allowed_tn)
  )

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
