#' Get cell-specific parameters from KOSTRA-DWD-2020 dataset
#'
#' @param x character. Relevant "INDEX_RC" field to be queried.
#'
#' @return Tibble containing estimated GEV parameters for the KOSTRA-DWD-2020
#'     grid cell specified.
#' @export
#'
#' @seealso [idx_build()]
#'
#' @examples
#' get_params("117111")
get_params <- function(x = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- "117111"

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1, min.chars = 1, max.chars = 6)

  stopifnot("'INDEX_RC' specified does not exist." = idx_exists(x))

  # main -----------------------------------------------------------------------

  res <- kostra_dwd_2020_params |> dplyr::filter(INDEX_RC == x)

  res
}
