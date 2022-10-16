## CHANGES IN ... 

## v0.6.2

* implementation of additional unit tests in order to increase code coverage
* `calc_designstorm()` now accepts `d = 5` as argument

## v0.6.1

* `get_pdepth()` and `get_returnp()` now return values supplemented by units

## v0.6

* `get_centroid()` now allows determination of coordinates based on municipality names and postal codes

## v0.5

* `calc_designstorm()` now allows generation of modelled rainfall from statistical precipitation

## v0.4

* `calc_pen()` now allows extrapolation of statistical precipitation based on PEN-LAWA (Verworn & Kummer (2006), Verworn & Draschoff (2008))

## v0.3.2

* initial implementation of several unit tests
* minor refactoring of several functions due to relative/absolute paths

## v0.3.1

* initial generation of `NEWS.md` using `bumpr::bumpGitVersion()`
* `get_returnp()` now returns consistent output for tn < 1 and tn > 100

## v0.3

* `get_pdepth()` now allows to determine statistical precipitation depths
