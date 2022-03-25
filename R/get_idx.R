#' Get index of KOSTRA-2010R grid by means of intersection with given location
#'
#' @param location Sf object containing a point feature.
#'
#' @return A string containing the the unique representation of the relevant
#'   "INDEX_RC" field.
#' @export
#'
#' @examples
#' \dontrun{
#' get_idx(p)
#' }
get_idx <- function(location) {

  # get file names
  files <- list.files("inst/exdata",
    pattern = "*.shp",
    full.names = TRUE,
    recursive = TRUE
  )

  # reproject sf point to target crs of the dataset
  location <- sf::st_transform(location, 3034)

  # read shapefile
  shp <- sf::st_read(files[1], quiet = TRUE)

  # determine index based on topology relation: intersect
  ind <- lengths(sf::st_intersects(shp, location)) > 0

  # returns index of relevant grid
  shp$INDEX_RC[ind] %>% as.character()
}
