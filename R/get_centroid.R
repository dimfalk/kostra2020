#' Construct a geometry set object of type sfc_POINT based on user input
#'
#' @param x Vector of length 2 containing numeric representing coordinates, \cr
#'   or character of length 1 representing the name of a municipality, \cr
#'   a postal zip code or a full address to be geocoded via Nominatim API.
#' @param epsg (optional) numeric. Coordinate reference system identifier.
#'
#' @return Object of type `sfc_POINT`.
#' @export
#'
#' @examples
#' get_centroid(x = c(6.19, 50.46), epsg = 4326)
#' get_centroid(x = c(367773, 5703579), epsg = 25832)
#'
#' get_centroid(x = "52070")
#' get_centroid(x = "Freiburg im Breisgau")
#' get_centroid(x = "Kronprinzenstr. 24, 45128 Essen")
get_centroid <- function(x = NULL,
                         epsg = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- c(6.19, 50.46)
  # x <- c(367773, 5703579)
  # epsg <- 4326

  # x <- "52070"
  # x <- "Freiburg im Breisgau"
  # x <- "Kronprinzenstr. 24, 45128 Essen"

  # check arguments ------------------------------------------------------------

  checkmate::assert(

    checkmate::testNumeric(x, len = 2, any.missing = FALSE),
    checkmate::testCharacter(x, len = 1)
  )

  if (inherits(x, "numeric")) {

    checkmate::assert_numeric(epsg, len = 1)

  } else {

    checkmate::assert_null(epsg)
  }

  # main -----------------------------------------------------------------------

  # vector of length 2 containing numeric representing coordinates -------------
  if (inherits(x, "numeric") && length(x) == 2) {

    sf <- sf::st_point(x) |> sf::st_sfc(crs = epsg)

    # string of length 1 representing input for Nominatim query ----------------
  } else if (inherits(x, "character") && length(x) == 1) {

    r <- tibble::tibble(addr = x) |>
      tidygeocoder::geocode(.tbl = _, address = addr, method = "osm", quiet = TRUE, progress_bar = FALSE)

    if (is.na(r[["lat"]]) || is.na(r[["long"]])) {

      "Geocoding of `x` using Nominatim API failed. Please check the examples provided in `?get_centroid`." |> stop()
    }

    sf <- sf::st_as_sf(r, coords = c("long", "lat"), crs = 4326) |>
      sf::st_geometry()
  }

  # does the user input overlap with KOSTRA-DWD-2020 spatially?
  hits <- sf::st_intersects(kostra_dwd_2020[[1]],
                            sf::st_transform(sf, "epsg:3035"),
                            sparse = FALSE) |> sum()

  if (hits == 0) {

    "Caution: Geocoded `x` does not intersect spatially with KOSTRA-DWD-2020 tiles." |> warning()

  }

  # return object
  sf
}
