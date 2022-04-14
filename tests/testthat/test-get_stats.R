kostra <- get_stats("49011")

test_that("General table building from shapefile works.", {

  expect_true(inherits(kostra, "data.frame"))
})

test_that("Column names are as expected", {

  expect_equal(colnames(kostra), c("D_min", "D_hour",
                                  "HN_001A", "HN_002A", "HN_003A", "HN_005A",
                                  "HN_010A", "HN_020A", "HN_030A", "HN_050A",
                                  "HN_100A"))
})

test_that("All duration levels are included.", {

  expect_equal(kostra[["D_min"]], c(5, 10, 15, 20, 30, 45, 60, 90, 120, 180, 240,
                                   360, 540, 720, 1080, 1440, 2880, 4320))
})

test_that("All return periods are appended as attributes.", {

  expect_equal(attr(kostra, "returnperiods_a"), c(1, 2, 3, 5,
                                                  10, 20, 30, 50,
                                                  100))
})






