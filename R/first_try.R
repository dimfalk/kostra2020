
library(sf)
library(magrittr)

files <- list.files("../data", 
                    pattern = "*.shp", 
                    full.names = TRUE, 
                    recursive = TRUE)

#
dauerstufen <- files %>% stringr::str_sub(start = 61, end = 64) %>% as.numeric()

#
stations <- rgdal::readOGR("C:/Users/falkd/Documents/GitHub/rstack2xts/shp/stations/NStationen_EGLV_2021-11-12.shp")
station <- shapefile_subset(stations, field = "id", selection = 2996)
station <- sf::st_as_sf(station)

#
station <- sf::st_transform(station, 3034)





#' Title
#'
#' @param station 
#'
#' @return
#' @export
#'
#' @examples
determine_index <- function(station) {
  
  # read shapefile
  shp <- sf::st_read(files[1])
  
  # determine index based on topology relation: intersect
  ind <- lengths(st_intersects(shp, station)) > 0
  
  # returns index of relevant grid
  shp$INDEX_RC[ind] %>% as.character()
}



#' Title
#'
#' @param grid_index 
#'
#' @return
#' @export
#'
#' @examples
construct_table <- function(grid_index) {
  
  # read shapefile
  shp <- sf::st_read(files[1])
  
  # determine index based on topology relation: intersect
  ind <- lengths(st_intersects(shp, station)) > 0
  
  for (i in 1:length(files)) {
    
    #
   shp <- sf::st_read(files[i])
    
    
    #
    cnames <- colnames(shp)[colnames(shp) %>% stringr::str_detect("HN_*")]
    
    #
    temp <- shp[ind, cnames] %>% sf::st_drop_geometry() 
    
    #
    temp["D_min"] <- dauerstufen[i]
    
    #
    if (i == 1) {
      
      df <- temp
      
    } else {
      
      df <- rbind(df, temp)
    }
  }
  
  dplyr::tibble(df)
}

x <- construct_table("48009")

write.csv2(x, paste0("KOSTRA-DWD-2010R_", idx, ".csv"), row.names = FALSE)

plot(x$D_min, x$HN_100A_, log = "x")


