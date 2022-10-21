#' Check whether "INDEX_RC" provided is present in KOSTRA-2010R data set
#'
#' @param idx A string representing the grid cell index.
#'
#' @return A boolean.
#' @export
#'
#' @examples
#' idx_exists("49011")
idx_exists <- function(idx = NULL) {

  # input validation -----------------------------------------------------------

  checkmate::assert_character(idx, len = 1, min.chars = 1, max.chars = 6)

  # main -----------------------------------------------------------------------

  # return boolean
  idx %in% kostra_dwd_2010r[[1]][["INDEX_RC"]]
}



#' Construct "INDEX_RC" based on given X and Y information
#'
#' @param col Integer {1:79}
#' @param row Integer {1:107}
#'
#' @return A string containing the unique representation of the relevant
#'   "INDEX_RC" field.
#' @export
#'
#' @examples
#' idx_build(11, 49)
idx_build <- function(col = NULL, row = NULL) {

  # debugging ------------------------------------------------------------------

  # col <- 11
  # row <- 49

  # input validation -----------------------------------------------------------

  checkmate::assert_numeric(col, len = 1, lower = 0, upper = 78)
  checkmate::assert_numeric(row, len = 1, lower = 0, upper = 106)

  # main -----------------------------------------------------------------------

  # line number multiplied by 1000 plus column number
  as.character(row * 1000 + col)
}


#' Construct an geometry set object of type POINT based on user input
#'
#' @param x Vector of length 2 containing numeric representing coordinates,
#'   or string of length 1 representing the name of a municipality,
#'   or string of nchar 5 representing a postal zip code.
#' @param epsg (optional) Coordinate reference system definition.
#'
#' @return An object of type `sfc_POINT`.
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



#' Get index of KOSTRA-2010R cell by means of intersection with given location
#'
#' @param location An object of type `sfc_POINT`.
#'
#' @return A string containing the unique representation of the relevant
#'   "INDEX_RC" field.
#' @export
#'
#' @examples
#' p <- get_centroid(x = c(367773, 5703579))
#' get_idx(p)
get_idx <- function(location = NULL) {

  # input validation -----------------------------------------------------------

  checkmate::assert_class(location, "sfc_POINT")

  # main -----------------------------------------------------------------------

  # reproject sf point to target crs of the data set
  location <- sf::st_transform(location, 3034)

  # get first sf collection
  shp <- kostra_dwd_2010r[[1]]

  # determine index based on topology relation: intersect
  ind <- lengths(sf::st_intersects(shp, location)) > 0

  # returns index of relevant grid
  shp[["INDEX_RC"]][ind] |> as.character()
}



#' Convert precipitation depth in precipitation yield as a function of duration.
#'
#' @param hn Precipitation depth in mm.
#' @param d Duration in minutes.
#'
#' @return Precipitation yield in l/(s*ha).
#' @export
#'
#' @examples
#' as_yield(hn = 45.7, d = 60)
as_yield <- function(hn = NULL,
                     d = NULL) {

  # debugging ------------------------------------------------------------------

  # hn <- 45.7
  # d <- 60

  # input validation -----------------------------------------------------------

  checkmate::assert_numeric(hn, len = 1)
  checkmate::assert_numeric(d, len = 1)

  # main -----------------------------------------------------------------------

  (as.numeric(hn) * 10000 / 60 / d) |> round(1) |> units::as_units("l/(s*ha)")
}



#' Convert precipitation yield in precipitation depth as a function of duration.
#'
#' @param rn Precipitation yield in l/(s*ha).
#' @param d Duration in minutes.
#'
#' @return Precipitation depth in mm.
#' @export
#'
#' @examples
#' as_depth(rn = 126.94, d = 60)
as_depth <- function(rn = NULL,
                     d = NULL) {

  # debugging ------------------------------------------------------------------

  # rn <- 126.94
  # d <- 60

  # input validation -----------------------------------------------------------

  checkmate::assert_numeric(rn, len = 1)
  checkmate::assert_numeric(d, len = 1)

  # main -----------------------------------------------------------------------

  (as.numeric(rn) / 10000 * 60 * d) |> round(1) |> units::as_units("mm")
}



# quiets concerns of R CMD check
utils::globalVariables(c("vg250_pk", "GEN",
                         "osm_plz_centroids", "plz",
                         "kostra_dwd_2010r", "INDEX_RC"))
