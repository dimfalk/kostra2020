#' Construct "INDEX_RC" based on given X and Y information
#'
#' @param col integer. One pick from set {0:78}
#' @param row integer. One pick from set {0:106}
#'
#' @return character. Unique representation of the relevant "INDEX_RC" field.
#' @export
#'
#' @examples
#' idx_build(col = 11, row = 49)
idx_build <- function(col = NULL, row = NULL) {

  # debugging ------------------------------------------------------------------

  # col <- 11
  # row <- 49

  # input validation -----------------------------------------------------------

  checkmate::assert_numeric(col, len = 1, lower = 0, upper = 78)
  checkmate::assert_numeric(row, len = 1, lower = 0, upper = 106)

  # main -----------------------------------------------------------------------

  # line number multiplied by 1000 plus column number
  as.character(row * 1000 + col)
}
