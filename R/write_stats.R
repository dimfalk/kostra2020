#' Write cell-specific statistics from KOSTRA-DWD-2020 dataset to disk
#'
#' @param x Tibble containing grid cell statistics from KOSTRA-DWD-2020,
#'     as provided by `get_stats()`.
#' @param file (optional) character. Filename with csv extension to be used for data output.
#'
#' @export
#'
#' @seealso [get_stats()]
#'
#' @examples
#' \dontrun{
#' stats <- get_stats("117111")
#'
#' write_stats(stats)
#' write_stats(stats, file = "kostra2020_hN_117111.csv")
#' }
write_stats <- function(x = NULL,
                        file = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- get_stats("117111")
  # file <- "kostra2020_hN_117111.csv"

  # check arguments ------------------------------------------------------------

  checkmate::assert_tibble(x)

  checkmate::assert(

    checkmate::test_null(file),
    checkmate::test_character(file, len = 1, pattern = "csv$")
  )

  # main -----------------------------------------------------------------------

  # construct default filename if not specified
  if (is.null(file)) {

    file <- paste0("kostra2020_",
                   attr(x, "type"), "_",
                   attr(x, "id"), ".csv")
  }

  # dump to disk
  utils::write.table(x,
                     file,
                     sep = "; ",
                     dec = ",",
                     na = "",
                     row.names = FALSE,
                     quote = FALSE)
}
