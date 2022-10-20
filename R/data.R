#' Point representation of municipalities in Germany (VG250 31.12.)
#'
#' A subset of data from the VG250_PK product provided by the Federal Agency for Cartography and Geodesy, Germany
#'
#' @format Simple feature collection of type POINT with 10,994 features and 1 field:
#' \describe{
#'   \item{GEN}{municipality name}
#'   \item{geometry}{centroid coordinates}
#' }
#' @source <https://gdz.bkg.bund.de/index.php/default/digitale-geodaten/verwaltungsgebiete/verwaltungsgebiete-1-250-000-stand-31-12-vg250-31-12.html>
#' @note: License: Data licence Germany – attribution – version 2.0
#' @note: Copyright: GeoBasis-DE / BKG 2022 (modified)
#' @details: vg250_pk <- sf::st_read("VG250_PK.shp") |> dplyr::select("GEN") |> sf::st_transform("epsg:25832")
"vg250_pk"


#' Centroids of zip code areas in Germany
#'
#' A subset/derivate of 5-digit zip code data provided by OpenStreetMap
#'
#' @format Simple feature collection of type POINT with 8,170 features and 1 field:
#' \describe{
#'   \item{plz}{zip codes}
#'   \item{geometry}{centroid coordinates}
#' }
#' @source <https://www.suche-postleitzahl.org/downloads>
#' @note: License: Open Data Commons Open Database License (ODbL)
#' @note: Copyright: OpenStreetMap contributors 2022 (modified)
#' @details: osm_plz <- sf::st_read("plz-5stellig.shp") |> dplyr::select("plz") |> sf::st_centroid() |> sf::st_transform("epsg:25832")
"osm_plz"
