#' Centroids of administrative areas on municipality level in Germany (VG250 31.12.)
#'
#' A subset/derivate of data from the VG250_GEM product provided by the Federal Agency for Cartography and Geodesy, Germany
#'
#' @format Simple feature collection with 11,123 features and 1 field:
#' \describe{
#'   \item{GEN}{municipality name}
#'   \item{geometry}{centroid coordinates}
#' }
#' @source <https://gdz.bkg.bund.de/index.php/default/digitale-geodaten/verwaltungsgebiete/verwaltungsgebiete-1-250-000-stand-31-12-vg250-31-12.html>
#' @note: License: Datenlizenz Deutschland - Namensnennung - Version 2.0
#' @note: Copyright: GeoBasis-DE / BKG 2022 (modified)
#' @details: sf::st_read("VG250_GEM.shp") |> dplyr::select("GEN") |> sf::st_centroid() |> sf::st_transform("epsg:25832")
"vg250_gem_centroids"


#' Centroids of zip code areas in Germany
#'
#' A subset/derivate of 5-digit zip code data provided by OpenStreetMap
#'
#' @format Simple feature collection with 8,170 features and 1 field:
#' \describe{
#'   \item{plz}{zip codes}
#'   \item{geometry}{centroid coordinates}
#' }
#' @source <https://www.suche-postleitzahl.org/downloads>
#' @note: License: Open Data Commons Open Database License (ODbL)
#' @note: Copyright: OpenStreetMap contributors 2022 (modified)
#' @details: sf::st_read("plz-5stellig.shp") |> dplyr::select("plz") |> sf::st_centroid() |> sf::st_transform("epsg:25832")
"osm_plz"
