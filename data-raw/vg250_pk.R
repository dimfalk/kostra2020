## code to prepare `vg250_pk` dataset goes here

vg250_pk <- sf::st_read("VG250_PK.shp") |>
  dplyr::select("GEN") |>
  sf::st_transform("epsg:25832")

usethis::use_data(vg250_pk, overwrite = TRUE)
