# version 0.6.3

## features

- `get_pdepth()` now allows to determine statistical precipitation depths
- `calc_pen()` now allows extrapolation of statistical precipitation based on PEN-LAWA (Verworn & Kummer 2006, Verworn & Draschoff 2008)
- `get_centroid()` now allows determination of coordinates based on municipality names and postal codes
- `calc_designstorm()` now allows generation of modelled rainfall from statistical precipitation


## enhancements

- `get_pdepth()` and `get_returnp()` now return values supplemented by units
- `get_centroid()` now makes use of the VG250_PK dataset instead of VG250_GEM centroids
- `get_centroid()` now prompts a warning when the object returned contains multiple hits
- `get_centroid()` now prompts an error when the object returned contains no hits


## bug fixes 

- `get_returnp()` now returns consistent output for tn < 1 and tn > 100
- `calc_designstorm()` now accepts `d = 5` as argument
