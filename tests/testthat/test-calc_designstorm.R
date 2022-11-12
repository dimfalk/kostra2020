test_that("Output class is as expected.", {

  xts1 <- calc_designstorm(kostra_ref, d = 60, tn = 20, type = "EulerII")

  xts2 <- calc_designstorm(stats_ref, d = 60, tn = 20, type = "EulerII")

  expect_s3_class(xts1, c("xts", "zoo"))

  expect_s3_class(xts2, c("xts", "zoo"))
})

test_that("Resolution of time series is according to specifications.", {

  xts1 <- calc_designstorm(kostra_ref, d = 60, tn = 20, type = "EulerII")

  expect_equal(xts::periodicity(xts1)[["frequency"]], 5)
})

test_that("Length of time series is according to specifications.", {

  xts1 <- calc_designstorm(kostra_ref, d = 60, tn = 20, type = "EulerII")

  expect_length(xts1, 12)
})

test_that("Sum of time series values equals statistical depth from table.", {

  xts1 <- calc_designstorm(kostra_ref, d = 60, tn = 20, type = "EulerII")

  expect_equal(zoo::coredata(xts1) |> sum(), 38.7)
})

test_that("Maximum time series value equals first value from table.", {

  xts1 <- calc_designstorm(kostra_ref, d = 60, tn = 20, type = "EulerII")

  expect_equal(zoo::coredata(xts1) |> max(), 11.3)
})

test_that("Maximum time series value is in correct position.", {

  xts1 <- calc_designstorm(kostra_ref, d = 60, tn = 20, type = "EulerII")

  expect_equal(which(xts1 == zoo::coredata(xts1) |>  max()), 4)
})

test_that("Function output and reference object are equal.", {

  xts1 <- calc_designstorm(kostra_ref, d = 60, tn = 20, type = "EulerII")

  expect_equal(xts1, xts_ref)
})
