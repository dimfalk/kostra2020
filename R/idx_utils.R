#' Check whether "INDEX_RC" provided is present in KOSTRA-2010R data set
#'
#' @param idx A string representing the grid cell index.
#'
#' @return A boolean.
#' @export
#'
#' @examples
#' \dontrun{
#' idx_exists("49011")
#' }
idx_exists <- function(idx = NULL) {

  # input validation -----------------------------------------------------------

  checkmate::assert_character(idx, len = 1, min.chars = 1, max.chars = 6)

  # main -----------------------------------------------------------------------

  # get file names
  files <- list.files(system.file(package = "kostra2010R"),
    pattern = "*.shp",
    full.names = TRUE,
    recursive = TRUE
  )

  # read shapefile as sf
  shp <- sf::st_read(files[1], quiet = TRUE)

  # return boolean
  idx %in% shp[["INDEX_RC"]]
}



#' Construct "INDEX_RC" based on given X and Y information
#'
#' @param col Integer {1:79}
#' @param row Integer {1:107}
#'
#' @return A string containing the unique representation of the relevant
#'   "INDEX_RC" field.
#' @export
#'
#' @examples
#' \dontrun{
#' idx_build(11, 49)
#' }
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



#' Get index of KOSTRA-2010R cell by means of intersection with given location
#'
#' @param location Sf object containing a point feature.
#'
#' @return A string containing the unique representation of the relevant
#'   "INDEX_RC" field.
#' @export
#'
#' @examples
#' \dontrun{
#' idx_get(p)
#' }
idx_get <- function(location = NULL) {

  # input validation -----------------------------------------------------------

  checkmate::assert_class(location, "sfc_POINT")

  # main -----------------------------------------------------------------------

  # get file names
  files <- list.files(system.file(package = "kostra2010R"),
                      pattern = "*.shp",
                      full.names = TRUE,
                      recursive = TRUE
  )

  # reproject sf point to target crs of the data set
  location <- sf::st_transform(location, 3034)

  # read shapefile
  shp <- sf::st_read(files[1], quiet = TRUE)

  # determine index based on topology relation: intersect
  ind <- lengths(sf::st_intersects(shp, location)) > 0

  # returns index of relevant grid
  shp[["INDEX_RC"]][ind] %>% as.character()
}
