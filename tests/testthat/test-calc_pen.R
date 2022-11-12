test_that("Output class is as expected.", {

  pen1 <- calc_pen(kostra_ref)

  pen2 <- calc_pen(stats_ref)

  expect_s3_class(pen1, c("tbl_df", "tbl", "data.frame"))

  expect_s3_class(pen2, c("tbl_df", "tbl", "data.frame"))
})

test_that("Column names are as expected", {

  pen1 <- calc_pen(kostra_ref)

  expect_equal(colnames(pen1), c("D_min", "D_hour", "D_day",
                                "HN_200A", "HN_500A", "HN_1000A",
                                "HN_2000A", "HN_5000A", "HN_10000A"))
})

test_that("All duration levels are included.", {

  pen1 <- calc_pen(kostra_ref)

  expect_equal(pen1[["D_min"]], c(5, 10, 15, 20, 30, 45,
                                 60, 90, 120, 180, 240, 360, 540, 720, 1080,
                                 1440, 2880, 4320))
})

test_that("All return periods are appended as attributes.", {

  pen1 <- calc_pen(kostra_ref)

  expect_equal(attr(pen1, "returnperiods_a"), c(200, 500, 1000,
                                               2000, 5000, 10000))
})

test_that("Function output and reference object are equal.", {

  pen1 <- calc_pen(kostra_ref)

  expect_equal(pen1, pen_ref)
})
