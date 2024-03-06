#' Get relevant "INDEX_RC" based on user-defined geometry
#'
#' @param x Object of type `sfc_POINT`, as provided by `get_centroid()`.
#'
#' @return character. Unique representation of the relevant "INDEX_RC" field.
#' @export
#'
#' @seealso [get_centroid()]
#'
#' @examples
#' p <- get_centroid(c(406658, 5761320), crs = "epsg:25832")
#'
#' get_idx(p)
get_idx <- function(x = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- get_centroid(c(406658, 5761320), crs = "epsg:25832")

  # check arguments ------------------------------------------------------------

  checkmate::assert_class(x, "sfc_POINT")

  # main -----------------------------------------------------------------------

  # reproject sf object to target crs of the dataset
  location <- sf::st_transform(x, "epsg:3035")

  # get first sf collection
  shp <- kostra_dwd_2020[[1]]

  # temporarily fixing R CMD check on ubuntu-latest due to GDAL 3.0.2?
  sf::st_crs(location) <- "epsg:3035"
  sf::st_crs(shp) <- "epsg:3035"

  # returns index of relevant grid
  shp[location, ][["INDEX_RC"]] |> as.character()
}
