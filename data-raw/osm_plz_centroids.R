## code to prepare `osm_plz_centroids` dataset goes here

file <- "plz-5stellig.shp.zip"

source <- paste0("https://downloads.suche-postleitzahl.org/v2/public/", file)

download.file(source, file)

unzip(file, exdir = file |> stringr::str_sub(1, -9))

unlink(file)

shp <- list.files(pattern = "plz-5stellig.shp", full.names = TRUE, recursive = TRUE)

osm_plz_centroids <- sf::read_sf(shp) |>
  dplyr::select("plz") |>
  sf::st_centroid() |>
  sf::st_transform("epsg:4326")

usethis::use_data(osm_plz_centroids, overwrite = TRUE)

unlink(file |> stringr::str_sub(1, -9), recursive = TRUE)
