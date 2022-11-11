## run before tests, but not loaded via `load_all()` and not installed with package

d <- 60



# get_stats("49011") |> saveRDS() ----------------------------------------------

kostra <- get_stats("49011")

kostra_ref <- readRDS(test_path("testdata", "kostra_ref.rds"))



# read_p_stats("rhj-2543.csv") |> saveRDS() ------------------------------------

stats_ref <- readRDS(test_path("testdata", "stats_ref.rds"))



# calc_pen(kostra_ref) |> saveRDS() --------------------------------------------

pen1 <- calc_pen(kostra_ref)

pen2 <- calc_pen(stats_ref)

pen_ref <- readRDS(test_path("testdata", "pen_ref.rds"))



# calc_designstorm(kostra_ref, d = d, tn = 20, type = "EulerII") |> saveRDS() --

xts1 <- calc_designstorm(kostra_ref, d = d, tn = 20, type = "EulerII")

xts2 <- calc_designstorm(stats_ref, d = d, tn = 20, type = "EulerII")

xts_ref <- readRDS(test_path("testdata", "xts_ref.rds"))
