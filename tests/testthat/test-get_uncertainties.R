test_that("Output class is as expected.", {

  uncert <- get_uncertainties("49125")

  expect_s3_class(uncert, c("tbl_df", "tbl", "data.frame"))
})

test_that("Column names are as expected", {

  uncert <- get_uncertainties("49125")

  expect_equal(colnames(uncert), c("D_min", "D_hour", "D_day",
                                  "UC_001A", "UC_002A", "UC_003A", "UC_005A",
                                  "UC_010A", "UC_020A", "UC_030A", "UC_050A",
                                  "UC_100A"))
})

test_that("All duration levels are included.", {

  uncert <- get_uncertainties("49125")

  expect_equal(uncert[["D_min"]], c(5, 10, 15, 20, 30, 45,
                                    60, 90, 120, 180, 240, 360, 540, 720, 1080,
                                    1440, 2880, 4320, 5760, 7200, 8640, 10080))
})

test_that("All return periods are appended as attributes.", {

  uncert <- get_uncertainties("49125")

  expect_equal(attr(uncert, "returnperiods_a"), c(1, 2, 3, 5,
                                                  10, 20, 30, 50,
                                                  100))
})

test_that("Type is as expected.", {

  uncert <- get_uncertainties("49125")

  expect_equal(attr(uncert, "type"), "UC")
})

test_that("Function output and reference object are equal.", {

  uncert <- get_uncertainties("49125")

  expect_equal(uncert, uncert_ref)
})
