## code to prepare `vg250_pk` dataset goes here

file <- "vg250_12-31.utm32s.shape.ebenen.zip"

source <- paste0("https://daten.gdz.bkg.bund.de/produkte/vg/vg250_ebenen_1231/aktuell/", file)

download.file(source, file)

unzip(file)

unlink(file)

shp <- list.files(pattern = "VG250_PK.shp", full.names = TRUE, recursive = TRUE)

vg250_pk <- sf::read_sf(shp) |>
  dplyr::select("GEN") |>
  sf::st_transform("epsg:4326")

usethis::use_data(vg250_pk, overwrite = TRUE)

unlink(file |> stringr::str_sub(1, -5), recursive = TRUE)
