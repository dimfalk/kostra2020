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

  # input validation -----------------------------------------------------------

  checkmate::assert_class(x, "sfc_POINT")

  # main -----------------------------------------------------------------------

  # reproject sf point to target crs of the dataset
  location <- sf::st_transform(x, 3034)

  # get first sf collection
  shp <- kostra_dwd_2010r[[1]]

  # determine index based on topology relation: intersect
  ind <- lengths(sf::st_intersects(shp, location)) > 0

  # returns index of relevant grid
  shp[["INDEX_RC"]][ind] |> as.character()
}
