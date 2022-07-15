kostra <- get_stats("49011")

pen <- calc_pen(kostra)

d <- 60
xts <- calc_designstorm(kostra, d = d, tn = 20, type = "EulerII")
