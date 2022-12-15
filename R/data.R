#' KOSTRA-DWD-2010R
#'
#' Statistical precipitation values as a function of duration and return period
#'
#' @format A list of length 18 with simple feature collections of type POLYGON with 8,453 features and 10 field each:
#' \describe{
#'   \item{INDEX_RC}{grid index}
#'   \item{HN_001A_}{design precipitation for return period 1 a}
#'   \item{HN_002A_}{design precipitation for return period 2 a}
#'   \item{HN_003A_}{design precipitation for return period 3 a}
#'   \item{HN_005A_}{design precipitation for return period 5 a}
#'   \item{HN_010A_}{design precipitation for return period 10 a}
#'   \item{HN_020A_}{design precipitation for return period 20 a}
#'   \item{HN_030A_}{design precipitation for return period 30 a}
#'   \item{HN_050A_}{design precipitation for return period 50 a}
#'   \item{HN_100A_}{design precipitation for return period 100 a}
#'   \item{geometry}{polygon coordinates}
#' }
#' @source <https://opendata.dwd.de/climate_environment/CDC/grids_germany/return_periods/precipitation/KOSTRA/KOSTRA_DWD_2010R/gis/>
#' @note Last access: 2022-10-20
#' @description <https://www.dwd.de/DE/leistungen/kostra_dwd_rasterwerte/kostra_dwd_rasterwerte.html>
#' @note License: Data licence Germany – attribution – version 2.0
#' @note Copyright: Deutscher Wetterdienst 2022 (format modified)
"kostra_dwd_2010r"



#' Point representation of municipalities in Germany (VG250 31.12.2021)
#'
#' A subset of data from the VG250_PK product provided by the Federal Agency for Cartography and Geodesy, Germany
#'
#' @format Simple feature collection of type POINT with 10,994 features and 1 field:
#' \describe{
#'   \item{GEN}{municipality name}
#'   \item{geometry}{centroid coordinates}
#' }
#' @source <https://daten.gdz.bkg.bund.de/produkte/vg/vg250_ebenen_1231/aktuell/vg250_12-31.utm32s.shape.ebenen.zip>
#' @note Last access: 2022-10-20
#' @description <https://gdz.bkg.bund.de/index.php/default/digitale-geodaten/verwaltungsgebiete/verwaltungsgebiete-1-250-000-stand-31-12-vg250-31-12.html>
#' @note License: Data licence Germany – attribution – version 2.0
#' @note Copyright: GeoBasis-DE / BKG 2022 (modified)
"vg250_pk"



#' Centroids of zip code areas in Germany
#'
#' A subset/derivative of 5-digit zip code data provided by OpenStreetMap
#'
#' @format Simple feature collection of type POINT with 8,170 features and 1 field:
#' \describe{
#'   \item{plz}{zip codes}
#'   \item{geometry}{centroid coordinates}
#' }
#' @source <https://downloads.suche-postleitzahl.org/v2/public/plz-5stellig.shp.zip>
#' @note Last access: 2022-10-20
#' @description <https://www.suche-postleitzahl.org/downloads>
#' @note License: Open Data Commons Open Database License (ODbL)
#' @note Copyright: OpenStreetMap contributors 2022 (modified)
"osm_plz_centroids"
