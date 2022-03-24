
library(sf)
library(magrittr)



#' Check whether defined index is present in KOSTRA-2010R.
#'
#' @param idx A string representing the grid cell index.
#'
#' @return A boolean.
#' @export
#'
#' @examples idx_exists("49011")
idx_exists <- function(idx) {
  
  # get file names
  files <- list.files("../data", 
                      pattern = "*.shp", 
                      full.names = TRUE, 
                      recursive = TRUE)
  
  # read shapefile
  shp <- sf::st_read(files[1], quiet = TRUE)
  
  #
  idx %in% shp$INDEX_RC
}



#' Get index of KOSTRA-2010R grid by means of intersection with given location.
#'
#' @param station Sf object containing a point feature.
#'
#' @return A string containing the the unique representation of the relevant 
#'   "INDEX_RC" field.
#' @export
#'
#' @examples get_idx(p)
get_idx <- function(location) {
  
  # get file names
  files <- list.files("../data", 
                      pattern = "*.shp", 
                      full.names = TRUE, 
                      recursive = TRUE)
  
  # reproject sf point to target crs of the dataset
  location <- sf::st_transform(location, 3034)
  
  # read shapefile
  shp <- sf::st_read(files[1], quiet = TRUE)
  
  # determine index based on topology relation: intersect
  ind <- lengths(st_intersects(shp, location)) > 0
  
  # returns index of relevant grid
  shp$INDEX_RC[ind] %>% as.character()
}
