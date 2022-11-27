#' Get index of relevant KOSTRA-2010R cell based on user-defined geometry
#'
#' @param x Object of type `sfc_POINT`, as provided by `get_centroid()`.
#'
#' @return character. Unique representation of the relevant "INDEX_RC" field.
#' @export
#'
#' @examples
#' p <- get_centroid(c(367773, 5703579))
#' get_idx(p)
get_idx <- function(x = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- c(367773, 5703579)

  # check arguments ------------------------------------------------------------

  checkmate::assert_class(x, "sfc_POINT")

  # main -----------------------------------------------------------------------

  # reproject sf point to target crs of the dataset
  location <- sf::st_transform(x, "epsg:3034")

  # temporary fix r-cmd-check on ubuntu-latest due to GDAL 3.0.2?
  sf::st_crs(location) <- "epsg:3034"
  sf::st_crs(shp) <- "epsg:3034"

  # get first sf collection
  shp <- kostra_dwd_2010r[[1]]

  # returns index of relevant grid
  shp[location, ][["INDEX_RC"]] |> as.character()
}
