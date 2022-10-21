## code to prepare `kostra_dwd_2010r` dataset goes here

files <- list.files(pattern = "*.shp", recursive = TRUE)

d <- stringr::str_sub(files, start = 53, end = 56)

for (i in 1:length(d)) {

  ds <- paste0("d", d[i])

  assign(ds, paste0("GIS_KOSTRA-DWD-2010R_", ds, "/StatRR_KOSTRA-DWD-2010R_", ds, ".shp") |> sf::st_read())
}

kostra_dwd_2010r <- list(
  "D0005" = d0005, "D0010" = d0010, "D0015" = d0015, "D0020" = d0020, "D0030" = d0030, "D0045" = d0045,
  "D0060" = d0060, "D0090" = d0090, "D0120" = d0120, "D0180" = d0180, "D0240" = d0240, "D0360" = d0360,
  "D0540" = d0540, "D0720" = d0720, "D1080" = d1080, "D1440" = d1440, "D2880" = d2880, "D4320" = d4320
)

usethis::use_data(kostra_dwd_2010r, overwrite = TRUE)
