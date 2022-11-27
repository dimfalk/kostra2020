test_that("Getting precipitation depths for DWD-KOSTRA-2010R works.", {

  expect_equal(get_pdepth(kostra_ref, d = 5, tn = 1) |> as.numeric(), 5.6)

  expect_equal(get_pdepth(kostra_ref, d = 4320, tn = 1) |> as.numeric(), 49.8)

  expect_equal(get_pdepth(kostra_ref, d = 5, tn = 100) |> as.numeric(), 14.4)

  expect_equal(get_pdepth(kostra_ref, d = 4320, tn = 100) |> as.numeric(), 108.1)
})

test_that("Getting precipitation depths for stats from DWA-A 531 works.", {

  expect_equal(get_pdepth(stats_ref, d = 5, tn = 1) |> as.numeric(), 6.1)

  expect_equal(get_pdepth(stats_ref, d = 4320, tn = 1) |> as.numeric(), 47.4)

  expect_equal(get_pdepth(stats_ref, d = 5, tn = 100) |> as.numeric(), 14.2)

  expect_equal(get_pdepth(stats_ref, d = 4320, tn = 100) |> as.numeric(), 102.2)
})

test_that("Getting precipitation depths for PEN works.", {

  expect_equal(get_pdepth(pen_ref, d = 5, tn = 200) |> as.numeric(), 19.1)

  expect_equal(get_pdepth(pen_ref, d = 4320, tn = 200) |> as.numeric(), 142.5)

  expect_equal(get_pdepth(pen_ref, d = 5, tn = 10000) |> as.numeric(), 29.5)

  expect_equal(get_pdepth(pen_ref, d = 4320, tn = 10000) |> as.numeric(), 214.6)
})
