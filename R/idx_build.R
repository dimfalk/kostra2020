#' Build "INDEX_RC" identifier based on given X and Y information
#'
#' @param col integer. One pick from set {0:299}.
#' @param row integer. One pick from set {0:299}.
#'
#' @return character. Unique representation of the relevant "INDEX_RC" field.
#' @export
#'
#' @examples
#' idx_build(col = 125, row = 49)
idx_build <- function(col = NULL,
                      row = NULL) {

  # debugging ------------------------------------------------------------------

  # col <- 125
  # row <- 49

  # check arguments ------------------------------------------------------------

  checkmate::assert_numeric(col, len = 1, lower = 0, upper = 299)
  checkmate::assert_numeric(row, len = 1, lower = 0, upper = 299)

  # main -----------------------------------------------------------------------

  # line number multiplied by 1000 plus column number
  as.character(row * 1000 + col)
}
