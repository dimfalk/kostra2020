kostra <- structure(list(D_min = c(5, 10, 15, 20, 30, 45, 60, 90, 120, 180, 240, 360, 540, 720, 1080, 1440, 2880, 4320),
                         D_hour = c(NA, NA, NA, NA, NA, NA, 1, 1.5, 2, 3, 4, 6, 9, 12, 18, 24, 48, 72),
                         D_day = c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 1, 2, 3),
                         HN_001A = c(5.6, 8.6, 10.5, 11.8, 13.5, 14.9, 15.7, 17.4, 18.8, 20.9, 22.5, 25, 27.8, 30, 33.3, 35.9, 44.1, 49.8),
                         HN_002A = c(6.9, 10.6, 13, 14.7, 17.1, 19.4, 21, 22.9, 24.4, 26.7, 28.5, 31.2, 34.2, 36.5, 40.1, 42.8, 52.2, 58.6),
                         HN_003A = c(7.7, 11.7, 14.4, 16.4, 19.2, 22.1, 24.1, 26.2, 27.7, 30.1, 32, 34.8, 37.9, 40.3, 44, 46.8, 57, 63.7),
                         HN_005A = c(8.7, 13.1, 16.2, 18.5, 21.9, 25.4, 28, 30.2, 31.9, 34.4, 36.4, 39.3, 42.6, 45.1, 49, 51.9,62.9, 70.2),
                         HN_010A = c(10, 15.1, 18.6, 21.4, 25.5, 29.9, 33.3, 35.7, 37.5, 40.2, 42.3, 45.5, 49, 51.6, 55.7, 58.8, 71, 79),
                         HN_020A = c(11.3, 17.1, 21.1, 24.3, 29.1, 34.4, 38.7, 41.2, 43.1, 46, 48.3, 51.7, 55.3, 58.2, 62.5, 65.8, 79.1, 87.7),
                         HN_030A = c(12.1, 18.2, 22.5, 25.9, 31.2, 37.1, 41.8, 44.4, 46.4, 49.4, 51.8, 55.3, 59.1, 62, 66.4, 69.8, 83.8, 92.9),
                         HN_050A = c(13.1, 19.6, 24.3, 28.1, 33.9, 40.4, 45.7, 48.5, 50.6, 53.7, 56.1, 59.8, 63.8, 66.8, 71.4, 74.9, 89.8, 99.3),
                         HN_100A = c(14.4, 21.6, 26.8, 30.9, 37.5, 45, 51, 53.9, 56.2, 59.6, 62.1, 66, 70.1, 73.3, 78.1, 81.8, 97.9, 108.1)),
                    class = c("tbl_df", "tbl", "data.frame"),
                    row.names = c(NA, -18L),
                    index_rc = "49011",
                    returnperiods_a = c(1, 2, 3, 5, 10, 20, 30, 50, 100),
                    source = "KOSTRA-DWD-2010R")
d = 60
tn = 20
xts <- calc_modelrain(kostra, d = d, tn = tn, type = "EulerII")

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

  expect_equal(zoo::coredata(xts) %>% sum(), 38.7)
})

test_that("Maximum time series value equals first value from table.", {

  expect_equal(zoo::coredata(xts) %>% max(), 11.3)
})

test_that("Maximum time series value is in correct position.", {

  expect_equal(which(xts == zoo::coredata(xts) %>% max()), 4)
})
