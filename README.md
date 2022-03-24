# kostra-dwd-2010R


Getting Started
```
p <- sf::st_sfc(
  sf::st_point(
    c(367773, 5703579)
    ), 
  crs = 25832
  )
```
```
p <- sf::st_sfc(
  sf::st_point(
    c(7.09, 51.46)
    ),
  crs = 4326
  )
```  

`get_idx(p)`

`idx_exists("49011")`
`idx_exists("foobar")`

`build_table("49011")`

`data <- build_table("49011")`

```
#
write.csv2(data, 
           paste0("KOSTRA-DWD-2010R_", attr(data, "index_rc"), ".csv"), 
           row.names = FALSE,
           na = "")
```
```
#
plot(data$D_min, 
     data$HN_100A_,
     xlab="interval [min]",
     ylab="precipitation height [mm]")
```

Reference:
https://www.dwd.de/DE/leistungen/kostra_dwd_rasterwerte/kostra_dwd_rasterwerte.html
https://opendata.dwd.de/climate_environment/CDC/grids_germany/return_periods/precipitation/KOSTRA/KOSTRA_DWD_2010R/gis/
