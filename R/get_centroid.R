#' Construct an geometry set object of type POINT based on user input
#'
#' @param x Vector of length 2 containing numeric representing coordinates,
#'   or string of length 1 representing the name of a municipality,
#'   or string of nchar 5 representing a postal zip code.
#' @param epsg (optional) Coordinate reference system definition.
#'
#' @return Object of type `sfc_POINT`.
#' @export
#'
#' @examples
#' p1 <- get_centroid(x = c(367773, 5703579))
#' p2 <- get_centroid(x = c(6.09, 50.46), epsg = 4326)
#' p3 <- get_centroid(x = "Aachen")
#' p4 <- get_centroid(x = "52070")
get_centroid <- function(x,
                         epsg = 25832) {

  # debugging ------------------------------------------------------------------

  # x <- c(6.89, 51.34, 7.13, 51.53)
  # x <- c(353034.1, 5689295.3, 370288.6, 5710875.9)
  # x <- "Essen"
  # x <- "45145"
  # epsg <- 4326

  # input validation -----------------------------------------------------------

  checkmate::assert(

    checkmate::testNumeric(x, len = 2, any.missing = FALSE),
    checkmate::testCharacter(x, len = 1),
  )

  checkmate::assert_numeric(epsg, len = 1)

  # main -----------------------------------------------------------------------

  # vector of length 2 containing numeric representing coordinates -------------
  if (inherits(x, "numeric") && length(x) == 2) {

    sf <- sf::st_point(x) |> sf::st_sfc(crs = epsg)

    # string of length 1 representing the name of a municipality -----------------
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

    # string of length 5 representing a postal zip code --------------------------
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