#' Extract row and column information from "INDEX_RC" identifier
#'
#' @param x character. Unique representation of the relevant "INDEX_RC" field.
#'
#' @return integer. Vector of length 2 containing row and column numbers.
#' @export
#'
#' @seealso [idx_build()]
#'
#' @examples
#' idx_decompose(x = "49011")
idx_decompose <- function(x = NULL) {

  # debugging ------------------------------------------------------------------

  # x = "49011"

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1)

  checkmate::assert_numeric(as.numeric(x))

  # main -----------------------------------------------------------------------

  x <- as.numeric(x)

  c(x %/% 1000, x %% 1000)
}
