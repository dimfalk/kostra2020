#' Interactive visualisation of tile locations from KOSTRA-DWD-2020 dataset
#'
#' @param x character. Relevant "INDEX_RC" field to be queried.
#' @param file (optional) character. Filename with png extension to be used for data output.
#'
#' @return Object of class `c("leaflet", "htmlwidget")`.
#' @export
#'
#' @import webshot
#'
#' @examples
#' \dontrun{
#' view_spatial()
#'
#' view_spatial("117111")
#' view_spatial("117111", file = "kostra2020_117111.png")
#' }
view_spatial <- function(x = NULL,
                         file = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- "117111"
  # file <- "kostra2020_117111.png"

  # check arguments ------------------------------------------------------------

  checkmate::assert(

    checkmate::test_null(x),
    checkmate::test_character(x, len = 1, min.chars = 1, max.chars = 6)
  )

  if (!is.null(x)) {

    stopifnot("'INDEX_RC' specified does not exist." = idx_exists(x))
  }

  checkmate::assert(

    checkmate::test_null(file),
    checkmate::test_character(file, len = 1, pattern = "png$")
  )

  # pre-processing -------------------------------------------------------------

  sf <- kostra_dwd_2020[[1]] |>
    dplyr::select("INDEX_RC") |>
    sf::st_transform("epsg:4326")

  # main -----------------------------------------------------------------------

  if (!is.null(x)) {

    tile <- dplyr::filter(sf, INDEX_RC == x)

    coords <- sf::st_centroid(tile) |>
      sf::st_coordinates() |>
      suppressWarnings()

    # leaflet::addWMSTiles(baseUrl = "https://sgx.geodatenzentrum.de/wms_topplus_open",
    #                      layers = "web_light_grau",
    #                      attribution = "Federal Agency for Cartography and Geodesy (2024): <a href='https://sgx.geodatenzentrum.de/web_public/gdz/datenquellen/Datenquellen_TopPlusOpen.html'> TopPlusOpen </a>",
    #                      options = leaflet::WMSTileOptions(format = "image/png",
    #                                                        transparent = TRUE))

    m <- leaflet::leaflet() |>
      leaflet::addProviderTiles("CartoDB.Positron") |>
      leaflet::setView(lng = coords[1],
                       lat = coords[2],
                       zoom = 12) |>
      leaflet::addPolygons(data = sf,
                           group = "all tiles",
                           color = "grey",
                           weight = 1,
                           fill = FALSE) |>
      leaflet::addPolygons(data = tile,
                           group = "highlighted tile",
                           color = "red",
                           weight = 3,
                           label = tile[["INDEX_RC"]],
                           labelOptions = leaflet::labelOptions(noHide = TRUE,
                                                                direction = "top",
                                                                textOnly = TRUE,
                                                                style = list("color" = "red",
                                                                             "font-size" = "20px",
                                                                             "font-weight" = "bold"))) |>
      leaflet::addScaleBar(position = "bottomleft",
                           options = leaflet::scaleBarOptions(imperial = FALSE)) |>
      leaflet::addLayersControl(baseGroups = c("CartoDB.Positron"),
                                overlayGroups = c("highlighted tile",
                                                  "all tiles")) |>
      htmlwidgets::onRender("
        function() {
            $('.leaflet-control-layers-overlays').prepend('<label style=\"text-align:center\">KOSTRA-DWD-2020</label>');
        }
    ")

    # eventually dump to disk
    if (!is.null(file)) {

      mapview::mapviewOptions(fgb = FALSE)

      mapview::mapshot(m,
                       file = file,
                       remove_controls = c("zoomControl",
                                           "layersControl"))
    }

  } else {

    m <- leaflet::leaflet() |>
      leaflet::addProviderTiles("CartoDB.Positron") |>
      leaflet::addPolygons(data = sf,
                           group = "KOSTRA-DWD-2020",
                           color = "grey",
                           weight = 1,
                           fillColor = "transparent",
                           label = sf[["INDEX_RC"]],
                           labelOptions = leaflet::labelOptions(direction = "auto",
                                                                style = list("font-size" = "12px",
                                                                             "font-weight" = "normal")),
                           highlightOptions = leaflet::highlightOptions(color = "red",
                                                                        weight = 2,
                                                                        opacity = 1,
                                                                        fillOpacity = 0,
                                                                        bringToFront = TRUE,
                                                                        sendToBack = TRUE)) |>
      leaflet::addScaleBar(position = "bottomleft",
                           options = leaflet::scaleBarOptions(imperial = FALSE)) |>
      leaflet::addLayersControl(baseGroups = c("CartoDB.Positron"),
                                overlayGroups = c("KOSTRA-DWD-2020"))
  }

  # render object
  m
}
