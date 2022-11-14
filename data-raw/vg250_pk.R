## code to prepare `vg250_pk` dataset goes here

vg250_pk <- sf::read_sf("VG250_PK.shp") |>
  dplyr::select("GEN") |>
  sf::st_transform("epsg:4326")

usethis::use_data(vg250_pk, overwrite = TRUE)
