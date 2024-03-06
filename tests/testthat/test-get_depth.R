test_that("Getting precipitation depths for DWD-KOSTRA-2020 works.", {

  expect_equal(get_depth(kostra_ref, d = 5, tn = 1),
               units::as_units(6.0, "mm"))

  expect_equal(get_depth(kostra_ref, d = 10080, tn = 1),
               units::as_units(55.0, "mm"))

  expect_equal(get_depth(kostra_ref, d = 5, tn = 100),
               units::as_units(16.9, "mm"))

  expect_equal(get_depth(kostra_ref, d = 10080, tn = 100),
               units::as_units(154.2, "mm"))
})

test_that("Getting precipitation depths (considering uncertainties) for DWD-KOSTRA-2020 works.", {

  expect_equal(get_depth(kostra_ref, d = 5, tn = 1, uc = TRUE),
               units::as_units(c(5, 7), "mm"))

  expect_equal(get_depth(kostra_ref, d = 10080, tn = 1, uc = TRUE),
               units::as_units(c(38.5, 71.5), "mm"))

  expect_equal(get_depth(kostra_ref, d = 5, tn = 100, uc = TRUE),
               units::as_units(c(13.2, 20.6), "mm"))

  expect_equal(get_depth(kostra_ref, d = 10080, tn = 100, uc = TRUE),
               units::as_units(c(112.6, 195.8), "mm"))
})

test_that("Getting precipitation depths for stats from DWA-A 531 works.", {

  expect_equal(get_depth(stats_ref, d = 5, tn = 1),
               units::as_units(6.1, "mm"))

  expect_equal(get_depth(stats_ref, d = 4320, tn = 1),
               units::as_units(47.4, "mm"))

  expect_equal(get_depth(stats_ref, d = 5, tn = 100),
               units::as_units(14.2, "mm"))

  expect_equal(get_depth(stats_ref, d = 4320, tn = 100),
               units::as_units(102.2, "mm"))
})
