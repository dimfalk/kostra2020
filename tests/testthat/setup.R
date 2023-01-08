## run before tests, but not loaded via `load_all()` and not installed with package

# get_stats("49125") |> saveRDS("kostra_ref.rds") ------------------------------

kostra_ref <- readRDS(test_path("testdata", "kostra_ref.rds"))



# get_uncertainties("49125") |> saveRDS("uncert_ref.rds") ----------------------

uncert_ref <- readRDS(test_path("testdata", "uncert_ref.rds"))



# read_p_stats("rhj-2543.csv") |> saveRDS("stats_ref.rds") ---------------------

stats_ref <- readRDS(test_path("testdata", "stats_ref.rds"))



# calc_designstorm(kostra_ref, d = 60, tn = 20, type = "EulerII") |> saveRDS("xts_ref.rds")

xts_ref <- readRDS(test_path("testdata", "xts_ref.rds"))
