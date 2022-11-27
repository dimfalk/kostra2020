test_that("Getting return periods for DWD-KOSTRA-2010R works.", {

  expect_equal(get_returnp(kostra_ref, hn = 30.2, d = 1440) |> as.numeric(), c(0, 1))

  expect_equal(get_returnp(kostra_ref, hn = 42.8, d = 1440) |> as.numeric(), c(2, 2))

  expect_equal(get_returnp(kostra_ref, hn = 72.3, d = 1440) |> as.numeric(), c(30, 50))

  expect_equal(get_returnp(kostra_ref, hn = 86.3, d = 1440) |> as.numeric(), c(100, Inf))
})

test_that("Getting interpolated return periods for DWD-KOSTRA-2010R works.", {

  expect_error(get_returnp(kostra_ref, hn = 30.2, d = 1440, interpolate = TRUE))

  expect_equal(get_returnp(kostra_ref, hn = 42.8, d = 1440, interpolate = TRUE) |> as.numeric(), 2)

  expect_equal(get_returnp(kostra_ref, hn = 72.3, d = 1440, interpolate = TRUE) |> as.numeric(), 39.9)

  expect_error(get_returnp(kostra_ref, hn = 86.3, d = 1440, interpolate = TRUE))
})

test_that("Getting return periods for PEN works.", {

  expect_equal(get_returnp(pen_ref, hn = 68.2, d = 60) |> as.numeric(), c(0, 200))

  expect_equal(get_returnp(pen_ref, hn = 77.7, d = 60) |> as.numeric(), c(500, 500))

  expect_equal(get_returnp(pen_ref, hn = 80, d = 60) |> as.numeric(), c(500, 1000))

  expect_equal(get_returnp(pen_ref, hn = 110, d = 60) |> as.numeric(), c(10000, Inf))
})

test_that("Getting return periods for stats from DWA-A 531 works.", {

  expect_equal(get_returnp(stats_ref, hn = 30.2, d = 1440) |> as.numeric(), c(0, 1))

  expect_equal(get_returnp(stats_ref, hn = 40.7, d = 1440) |> as.numeric(), c(2, 2))

  expect_equal(get_returnp(stats_ref, hn = 72.3, d = 1440) |> as.numeric(), c(33, 50))

  expect_equal(get_returnp(stats_ref, hn = 86.3, d = 1440) |> as.numeric(), c(100, Inf))
})
