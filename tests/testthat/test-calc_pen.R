test_that("Output class is as expected.", {

  expect_true(inherits(pen1, "data.frame"))

  expect_true(inherits(pen2, "data.frame"))
})

test_that("Column names are as expected", {

  expect_equal(colnames(pen1), c("D_min", "D_hour", "D_day",
                                "HN_200A", "HN_500A", "HN_1000A",
                                "HN_2000A", "HN_5000A", "HN_10000A"))
})

test_that("All duration levels are included.", {

  expect_equal(pen1[["D_min"]], c(5, 10, 15, 20, 30, 45,
                                 60, 90, 120, 180, 240, 360, 540, 720, 1080,
                                 1440, 2880, 4320))
})

test_that("All return periods are appended as attributes.", {

  expect_equal(attr(pen1, "returnperiods_a"), c(200, 500, 1000,
                                               2000, 5000, 10000))
})

test_that("Function output and reference object are equal.", {

  expect_equal(pen1, pen_ref)
})
