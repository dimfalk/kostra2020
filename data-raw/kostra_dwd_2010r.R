## code to prepare `kostra_dwd_2010r` dataset goes here

source <- "https://opendata.dwd.de/climate_environment/CDC/grids_germany/return_periods/precipitation/KOSTRA/KOSTRA_DWD_2010R/gis/"

d <- c(5, 10, 15, 20, 30, 45, 60, 90, 120, 180, 240, 360, 540, 720, 1080, 1440, 2880, 4320)

d_pad <- stringr::str_pad(d, width = 4, pad = "0")

files <- paste0("GIS_KOSTRA-DWD-2010R_D", d_pad,".zip")

urls <- paste0(source, files)

for (i in 1:length(files)) {

  download.file(urls[i], files[i])

  unzip(files[i])

  unlink(files[i])
}

files_shp <- list.files(pattern = "*.shp", recursive = TRUE)

kostra_dwd_2010r <- list()

for (i in 1:length(d)) {

  ds <- paste0("D", d_pad[i])

  # temporary fix r-cmd-check on ubuntu-latest due to GDAL 3.0.2?
  assign(ds, files_shp[i] |> sf::read_sf() |> sf::st_set_crs("epsg:3034"))

  kostra_dwd_2010r[[ds]] <- get(ds)
}

usethis::use_data(kostra_dwd_2010r, overwrite = TRUE)

unlink(files |> stringr::str_sub(1, -5), recursive = TRUE)
