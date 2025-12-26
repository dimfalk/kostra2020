# version 1.5.4

## features

- `kostra_dwd_2010r` replaced by `kostra_dwd_2020`
- `get_uncertainties()` now allows to get cell-specific uncertainty estimates
- `get_depth()` now allows to consider uncertainties with `uc = TRUE`
- `get_stats()` now optionally return precipitation yield values with `as_depth = FALSE`
- `write_stats()` now wraps `write.table()` to facilitate dumping stats to disk
- `plot_idf` now allows to visualize intensity-duration-frequency curves per tile
- `view_spatial` now allows to interactively explore tile locations, with optional output to disk


## enhancements

- `get_centroid()` now makes use of the Nominatim API via `tidygeocoder::geocode()` for forward geocoding instead of using datasets shipped with the package


## bug fixes 

- `as_yield()` and `as_depth()` now accept `x` with a length of 2


# version 0.7.3

## features

- `get_pdepth()` now allows to determine statistical precipitation depths
- `get_centroid()` now allows determination of coordinates based on municipality names and postal codes
- `get_returnp()` now allows interpolation of return periods with `interpolate = TRUE`


## enhancements

- `get_pdepth()` and `get_returnp()` now return values supplemented by units
- `get_centroid()` now makes use of the VG250_PK dataset instead of VG250_GEM centroids
- `get_centroid()` now prompts a warning when the object returned contains multiple hits
- `get_centroid()` now prompts an error when the object returned contains no hits
- package data has been imported using `sf::read_sf()` instead of `sf::st_read()`
- proper internal unit conversion when using `as_yield()` and `as_depth()`
- `kostra_dwd_2010r` dataset now has actual `NA` values instead of `-99.9` placeholders
- general cleaning and harmonization of roxygen2 function documentation


## bug fixes 

- `get_returnp()` now returns consistent output for tn < 1 and tn > 100
