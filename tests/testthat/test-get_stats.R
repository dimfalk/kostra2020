test_that("Output class is as expected.", {

  expect_s3_class(kostra, c("tbl_df", "tbl", "data.frame"))
})

test_that("Column names are as expected", {

  expect_equal(colnames(kostra), c("D_min", "D_hour", "D_day",
                                  "HN_001A", "HN_002A", "HN_003A", "HN_005A",
                                  "HN_010A", "HN_020A", "HN_030A", "HN_050A",
                                  "HN_100A"))
})

test_that("All duration levels are included.", {

  expect_equal(kostra[["D_min"]], c(5, 10, 15, 20, 30, 45,
                                    60, 90, 120, 180, 240, 360, 540, 720, 1080,
                                    1440, 2880, 4320))
})

test_that("All return periods are appended as attributes.", {

  expect_equal(attr(kostra, "returnperiods_a"), c(1, 2, 3, 5,
                                                  10, 20, 30, 50,
                                                  100))
})

test_that("Function output and reference object are equal.", {

  expect_equal(kostra, kostra_ref)
})
