#' Construct "INDEX_RC" based on given X and Y information
#'
#' @param col Integer {1:79}
#' @param row Integer {1:107}
#'
#' @return A string containing the the unique representation of the relevant
#'   "INDEX_RC" field.
#' @export
#'
#' @examples
#' \dontrun{
#' build_idx(11, 49)
#' }
build_idx <- function(col, row) {

  # line number multiplied by 1000 plus column number
  as.character(row * 1000 + col)
}
