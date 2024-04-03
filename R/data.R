#' Data: KOSTRA-DWD-2020
#'
#' Statistical precipitation values as a function of duration and return period
#'
#' @format A list of length 22 representing duration levels with simple feature collections of type POLYGON with 15,989 features and 20 fields each:
#' \describe{
#'   \item{INDEX_RC}{numeric. Unique grid cell identifier.}
#'
#'   \item{HN_001A_}{numeric. Design precipitation depth \code{[mm]} for return period Tn = 1 a.}
#'   \item{HN_002A_}{numeric. Design precipitation depth \code{[mm]} for return period Tn = 2 a.}
#'   \item{HN_003A_}{numeric. Design precipitation depth \code{[mm]} for return period Tn = 3 a.}
#'   \item{HN_005A_}{numeric. Design precipitation depth \code{[mm]} for return period Tn = 5 a.}
#'   \item{HN_010A_}{numeric. Design precipitation depth \code{[mm]} for return period Tn = 10 a.}
#'   \item{HN_020A_}{numeric. Design precipitation depth \code{[mm]} for return period Tn = 20 a.}
#'   \item{HN_030A_}{numeric. Design precipitation depth \code{[mm]} for return period Tn = 30 a.}
#'   \item{HN_050A_}{numeric. Design precipitation depth \code{[mm]} for return period Tn = 50 a.}
#'   \item{HN_100A_}{numeric. Design precipitation depth \code{[mm]} for return period Tn = 100 a.}
#'
#'   \item{UC_001A_}{numeric. Estimated uncertainty in design precipitation \code{[\%]} for return period Tn = 1 a.}
#'   \item{UC_002A_}{numeric. Estimated uncertainty in design precipitation \code{[\%]} for return period Tn = 2 a.}
#'   \item{UC_003A_}{numeric. Estimated uncertainty in design precipitation \code{[\%]} for return period Tn = 3 a.}
#'   \item{UC_005A_}{numeric. Estimated uncertainty in design precipitation \code{[\%]} for return period Tn = 5 a.}
#'   \item{UC_010A_}{numeric. Estimated uncertainty in design precipitation \code{[\%]} for return period Tn = 10 a.}
#'   \item{UC_020A_}{numeric. Estimated uncertainty in design precipitation \code{[\%]} for return period Tn = 20 a.}
#'   \item{UC_030A_}{numeric. Estimated uncertainty in design precipitation \code{[\%]} for return period Tn = 30 a.}
#'   \item{UC_050A_}{numeric. Estimated uncertainty in design precipitation \code{[\%]} for return period Tn = 50 a.}
#'   \item{UC_100A_}{numeric. Estimated uncertainty in design precipitation \code{[\%]} for return period Tn = 100 a.}
#'
#'   \item{geometry}{sfc_GEOMETRY. Coordinates.}
#' }
#' @source <https://opendata.dwd.de/climate_environment/CDC/grids_germany/return_periods/precipitation/KOSTRA/KOSTRA_DWD_2020/gis/>
#' @note Last access: 2022-12-15
#' @description <https://www.dwd.de/DE/leistungen/kostra_dwd_rasterwerte/kostra_dwd_rasterwerte.html>
#' @note License: Data licence Germany – attribution – version 2.0
#' @note Copyright: Deutscher Wetterdienst 2022 (format modified)
"kostra_dwd_2020"
