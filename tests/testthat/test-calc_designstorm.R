test_that("Construction of xts object works.", {

  expect_true(inherits(xts, c("xts", "zoo")))
})

test_that("Resolution of time series is according to specifications.", {

  expect_equal(xts::periodicity(xts)[["frequency"]], 5)
})

test_that("Length of time series is according to specifications.", {

  expect_equal(length(xts), d / 5)
})

test_that("Sum of time series values equals statistical value from table.", {

  expect_equal(zoo::coredata(xts) |> sum(), 38.7)
})

test_that("Maximum time series value equals first value from table.", {

  expect_equal(zoo::coredata(xts) |> max(), 11.3)
})

test_that("Maximum time series value is in correct position.", {

  expect_equal(which(xts == zoo::coredata(xts) %>% max()), 4)
})
