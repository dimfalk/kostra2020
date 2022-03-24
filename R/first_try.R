
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



#' Get interval/frequency statistics for the KOSTRA-2010R grid specified.
#'
#' @param grid_index A String representing the relevant "INDEX_RC" field.
#'
#' @return A tibble containing precipitation height interval/frequency 
#'   statistics for a defined KOSTRA-2010R grid.
#' @export
#'
#' @examples build_table("49011")
build_table <- function(grid_index) {
  
  # get file names
  files <- list.files("../data", 
                      pattern = "*.shp", 
                      full.names = TRUE, 
                      recursive = TRUE)
  
  #
  intervals <- files %>% stringr::str_sub(start = 61, end = 64) %>% as.numeric()
  
  # read shapefile
  shp <- sf::st_read(files[1], quiet = TRUE)
  
  # get recurrence intervals from column names
  cnames <- colnames(shp)[colnames(shp) %>% stringr::str_detect("HN_*")] 
  
  freq <- cnames %>% stringr::str_sub(start = 4, end = 6) %>% as.numeric()
  
  # determine index based on user input
  ind <- which(shp$INDEX_RC == grid_index)
  
  # built data.frame  
  for (i in 1:length(files)) {
    
    # read shapefile
    shp <- sf::st_read(files[i], quiet = TRUE)
    
    # subset original data.frame
    temp <- shp[ind, cnames] %>% sf::st_drop_geometry() 
    
    #
    temp["D_min"] <- intervals[i]
    temp["D_hour"] <- temp[["D_min"]] / 60
    
    temp$D_hour[temp$D_min < 60] <- NA
    
    # arrange columns
    temp <- temp[c("D_min", "D_hour", cnames)]
    
    #
    if (i == 1) {
      
      df <- temp
      
    } else {
      
      df <- rbind(df, temp)
    }
  }
  
  # append index as attribute
  attr(df, "index_rc") <- grid_index
  
  # return tibble
  dplyr::tibble(df)
}
