#' Verwaltungsgebiete 1:250.000, Stand 31.12.2021 (VG250 31.12.)
#'
#' A subset of data from the World Health Organization Global Tuberculosis
#' Report ...
#'
#' @format ## `who`
#' Simple feature collection with 11,123 features and 1 field:
#' \describe{
#'   \item{country}{Country name}
#'   \item{iso2, iso3}{2 & 3 letter ISO country codes}
#'   \item{year}{Year}
#'   ...
#' }
#' @source <https://daten.gdz.bkg.bund.de/produkte/vg/vg250_ebenen_1231/aktuell/vg250_12-31.utm32s.shape.ebenen.zip>

#' @license: Datenlizenz Deutschland - Namensnennung - Version 2.0
#' @copyright: GeoBasis-DE / BKG 2022 (modified)

#' @pre-processing: sf::st_read("VG250_GEM.shp") |> dplyr::select("GEN") |> sf::st_centroid()