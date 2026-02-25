## code to prepare `kostra_dwd_2020_params` dataset goes here

source <- "https://opendata.dwd.de/climate_environment/CDC/grids_germany/return_periods/precipitation/KOSTRA/KOSTRA_DWD_2020/tab/"

fname_zip <- "Parameter_KOSTRA-DWD-2020.csv.zip"

url <- paste0(source, fname_zip)

utils::download.file(url, fname_zip)

utils::unzip(fname_zip)

unlink(fname_zip)

fname_csv <- stringr::str_remove(fname_zip, pattern = "\\.zip")

kostra_dwd_2020_params <- readr::read_delim(fname_csv,
                                            delim = ";",
                                            escape_double = FALSE,
                                            locale = readr::locale(decimal_mark = ","),
                                            trim_ws = TRUE,
                                            na = "-99,9")

# drop rows with NA only, rename cols, remove leading zeros from index
kostra_dwd_2020_params <- kostra_dwd_2020_params |>
  dplyr::filter(!dplyr::if_any(dplyr::all_of(2:6), is.na)) |>
  dplyr::rename("XI" = "LOCAL_XI",
                "ALPHA" = "SCALE_ALPHA",
                "KAPPA" = "SHAPE_KAPPA",
                "THETA" = "KOUT_1_THETA",
                "ETA" = "KOUT_2_ETA") |>
  dplyr::mutate("INDEX_RC" = stringr::str_remove(INDEX_RC, pattern = "^0+"))

usethis::use_data(kostra_dwd_2020_params, overwrite = TRUE)

unlink(fname_csv)
