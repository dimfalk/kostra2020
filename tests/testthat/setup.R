## run before tests, but not loaded via `load_all()` and not installed with package

# get_stats("49011") |> saveRDS("kostra_ref.rds") ------------------------------

kostra_ref <- readRDS(test_path("testdata", "kostra_ref.rds"))



# read_p_stats("rhj-2543.csv") |> saveRDS("stats_ref.rds") ---------------------

stats_ref <- readRDS(test_path("testdata", "stats_ref.rds"))



# calc_pen(kostra_ref) |> saveRDS("pen_ref.rds") -------------------------------

pen_ref <- readRDS(test_path("testdata", "pen_ref.rds"))



# calc_designstorm(kostra_ref, d = 60, tn = 20, type = "EulerII") |> saveRDS("xts_ref.rds")

xts_ref <- readRDS(test_path("testdata", "xts_ref.rds"))
