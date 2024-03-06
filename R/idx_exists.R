#' Check whether given "INDEX_RC" is present in KOSTRA-DWD-2020 dataset
#'
#' @param x character. Relevant "INDEX_RC" field to be queried.
#'
#' @return logical.
#' @export
#'
#' @examples
#' idx_exists("117111")
idx_exists <- function(x = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- "117111"

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1, min.chars = 1, max.chars = 6)

  # main -----------------------------------------------------------------------

  # return boolean
  x %in% kostra_dwd_2020[[1]][["INDEX_RC"]]
}
