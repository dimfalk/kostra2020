## run before tests, but not loaded via `load_all()` and not installed with package

# get_stats("49125") |> saveRDS("kostra_ref.rds") ------------------------------

kostra_ref <- readRDS(test_path("testdata", "kostra_ref.rds"))



# get_uncertainties("49125") |> saveRDS("uncert_ref.rds") ----------------------

uncert_ref <- readRDS(test_path("testdata", "uncert_ref.rds"))



# get_params("49125") |> saveRDS("params_ref.rds") ----------------------

params_ref <- readRDS(test_path("testdata", "params_ref.rds"))
