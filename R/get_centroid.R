#' Construct a geometry set object of type sfc_POINT based on user input
#'
#' @param x Vector of length 2 containing numeric representing coordinates, \cr
#'   or character of length 1 representing the name of a municipality, \cr
#'   or character of nchar 5 representing a postal zip code.
#' @param epsg numeric. Coordinate reference system identifier.
#'
#' @return Object of type `sfc_POINT`.
#' @export
#'
#' @examples
#' get_centroid(c(367773, 5703579))
#' get_centroid(c(6.09, 50.46), epsg = 4326)
#' get_centroid("Aachen")
#' get_centroid("52070")
get_centroid <- function(x = NULL,
                         epsg = 25832) {

  # debugging ------------------------------------------------------------------

  # x <- c(6.09, 50.46)
  # x <- c(367773, 5703579)
  # x <- "Aachen"
  # x <- "52070"
  # epsg <- 4326

  # check arguments ------------------------------------------------------------

  checkmate::assert(

    checkmate::testNumeric(x, len = 2, any.missing = FALSE),
    checkmate::testCharacter(x, len = 1)
  )

  checkmate::assert_numeric(epsg, len = 1)

  # main -----------------------------------------------------------------------

  # vector of length 2 containing numeric representing coordinates -------------
  if (inherits(x, "numeric") && length(x) == 2) {

    sf <- sf::st_point(x) |> sf::st_sfc(crs = epsg)

    # string of length 1 representing the name of a municipality ---------------
  } else if (inherits(x, "character") && length(x) == 1 && as.numeric(x) |> suppressWarnings() |> is.na()) {

    sf <- vg250_pk |> dplyr::filter(GEN == x) |> sf::st_geometry()

    # number of objects present
    n <- length(sf)

    # capture typos and non-existent names in the dataset
    if (n == 0) {

      # partial matching successful?
      pmatch <- vg250_pk[["GEN"]][grep(x, vg250_pk[["GEN"]])]

      if (length(pmatch) == 0) {

        "The name provided is not included in the dataset. Please try another." |> stop()

      } else {

        paste("The name provided is not included in the dataset. Did you mean one of the following entries?",
              stringr::str_c(pmatch, collapse = ", "), sep ="\n  ") |> stop()
      }

      # warn user in case the name provided was not unique with multiple results
    } else if (n > 1) {

      paste("The name provided returned multiple non-unique results.",
            "Consider to visually inspect the returned object using e.g. `mapview::mapview(p)`.",
            "Hint: Subsetting can be accomplished using brackets `p[1]`.", sep ="\n  ") |> warning()

    }

    # string of length 5 representing a postal zip code ------------------------
  } else if (inherits(x, "character") && length(x) == 1 && nchar(x) == 5 && !is.na(as.numeric(x)) |> suppressWarnings()) {

    sf <- osm_plz_centroids |> dplyr::filter(plz == x) |> sf::st_geometry()

    # number of objects present
    n <- length(sf)

    # capture typos and non-existent codes in the dataset
    if (n == 0) {

      "The postal code provided is not included in the dataset. Please try another." |> stop()
    }

  } else {

    "Your input could not be attributed properly. Please check the examples provided: `?get_centroid`." |> stop()
  }

  # return object
  sf
}
