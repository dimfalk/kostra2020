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
idx_exists <- function(idx) {

  # get file names
  files <- list.files("inst/exdata",
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
idx_build <- function(col, row) {

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
idx_get <- function(location) {

  # get file names
  files <- list.files("inst/exdata",
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
  shp$INDEX_RC[ind] %>% as.character()
}
