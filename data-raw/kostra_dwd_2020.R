## code to prepare `kostra_dwd_2020` dataset goes here

source <- "https://opendata.dwd.de/climate_environment/CDC/grids_germany/return_periods/precipitation/KOSTRA/KOSTRA_DWD_2020/gis/"

d <- c(5, 10, 15, 20, 30, 45, 60, 90, 120, 180, 240, 360, 540, 720, 1080, 1440, 2880, 4320, 5760, 7200, 8640, 10080)

d_pad <- stringr::str_pad(d, width = 5, pad = "0")

fnames <- paste0("GIS_KOSTRA-DWD-2020_D", d_pad,".zip")

urls <- paste0(source, fnames)

for (i in 1:length(fnames)) {

  utils::download.file(urls[i], fnames[i])

  utils::unzip(fnames[i])

  unlink(fnames[i])
}

files_shp <- list.files(pattern = "shp$", recursive = TRUE)

kostra_dwd_2020 <- list()

for (i in 1:length(d)) {

  ds <- paste0("D", d_pad[i])

  assign(ds, files_shp[i] |> sf::read_sf())

  # filter dataset for `BELEG == 1` and remove attribute
  assign(ds, get(ds)[get(ds)$BELEG == 1, ])
  assign(ds, get(ds) |> dplyr::select(!dplyr::matches("BELEG")))

  # filter dataset for `HN_*`, `UC_*`; exclude `RN_*`
  assign(ds, get(ds) |> dplyr::select(!dplyr::starts_with("RN_")))

  kostra_dwd_2020[[ds]] <- get(ds)
}

usethis::use_data(kostra_dwd_2020, overwrite = TRUE)

stringr::str_sub(fnames, 1, -5) |> unlink(recursive = TRUE)
