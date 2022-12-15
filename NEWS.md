# version 0.7.1

## features

- `get_pdepth()` now allows to determine statistical precipitation depths
- `calc_pen()` now allows extrapolation of statistical precipitation based on PEN-LAWA (Verworn & Kummer 2006, Verworn & Draschoff 2008)
- `get_centroid()` now allows determination of coordinates based on municipality names and postal codes
- `calc_designstorm()` now allows generation of modelled rainfall from statistical precipitation
- `get_returnp()` now allows interpolation of return periods with `interpolate = TRUE`


## enhancements

- `get_pdepth()` and `get_returnp()` now return values supplemented by units
- `get_centroid()` now makes use of the VG250_PK dataset instead of VG250_GEM centroids
- `get_centroid()` now prompts a warning when the object returned contains multiple hits
- `get_centroid()` now prompts an error when the object returned contains no hits
- package data has been imported using `sf::read_sf()` instead of `sf::st_read()`
- proper internal unit conversion when using `as_yield()` and `as_depth()`


## bug fixes 

- `get_returnp()` now returns consistent output for tn < 1 and tn > 100
- `calc_designstorm()` now accepts `d = 5` as argument
- `get_returnp()` now also works on tibbles returned by `calc_pen()`
