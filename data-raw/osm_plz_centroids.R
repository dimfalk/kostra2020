## code to prepare `osm_plz_centroids` dataset goes here

osm_plz_centroids <- sf::read_sf("plz-5stellig.shp") |>
  dplyr::select("plz") |>
  sf::st_centroid() |>
  sf::st_transform("epsg:4326")

usethis::use_data(osm_plz_centroids, overwrite = TRUE)
