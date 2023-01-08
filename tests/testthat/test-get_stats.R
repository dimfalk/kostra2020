test_that("Output class is as expected.", {

  kostra <- get_stats("49125")

  expect_s3_class(kostra, c("tbl_df", "tbl", "data.frame"))
})

test_that("Column names are as expected", {

  kostra <- get_stats("49125")

  expect_equal(colnames(kostra), c("D_min", "D_hour", "D_day",
                                  "HN_001A", "HN_002A", "HN_003A", "HN_005A",
                                  "HN_010A", "HN_020A", "HN_030A", "HN_050A",
                                  "HN_100A"))
})

test_that("All duration levels are included.", {

  kostra <- get_stats("49125")

  expect_equal(kostra[["D_min"]], c(5, 10, 15, 20, 30, 45,
                                    60, 90, 120, 180, 240, 360, 540, 720, 1080,
                                    1440, 2880, 4320, 5760, 7200, 8640, 10080))
})

test_that("All return periods are appended as attributes.", {

  kostra <- get_stats("49125")

  expect_equal(attr(kostra, "returnperiods_a"), c(1, 2, 3, 5,
                                                  10, 20, 30, 50,
                                                  100))
})

test_that("Type is as expected.", {

  kostra <- get_stats("49125")

  expect_equal(attr(kostra, "type"), "HN")
})

test_that("Function output and reference object are equal.", {

  kostra <- get_stats("49125")

  expect_equal(kostra, kostra_ref)
})
