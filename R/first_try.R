
library(sf)
library(magrittr)

files <- list.files("C:/Users/falk.dimitri/Documents/GitHub/KOSTRA-DWD-2010R/data", 
                    pattern = "*.shp", 
                    full.names = TRUE, 
                    recursive = TRUE)

shp1 <- sf::st_read(files[1])

# sf::st_crs(shp1)

plot(shp1$geometry)

#
stations <- rgdal::readOGR("C:/Users/falk.dimitri/Documents/GitHub/rstack2xts/shp/stations/NStationen_EGLV_2021-11-12.shp")
station <- shapefile_subset(stations, field = "id", selection = 2996)
station <- sf::st_as_sf(station)

station <- sf::st_transform(station, 3034)


sf::st_contains(station, shp1)

t <- sf::st_intersects(station, shp1)

shp1 %>% dplyr::select(t)