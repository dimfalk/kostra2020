test_that("Output class is as expected.", {

  kostra_hn <- get_stats("49125")

  expect_s3_class(kostra_hn, c("tbl_df", "tbl", "data.frame"))
})

test_that("Column names are as expected.", {

  cnames <- c("D_min", "D_hour", "D_day",
              "HN_001A", "HN_002A", "HN_003A", "HN_005A",
              "HN_010A", "HN_020A", "HN_030A", "HN_050A",
              "HN_100A")

  kostra_hn <- get_stats("49125")

  expect_equal(colnames(kostra_hn), cnames)



  cnames <- c("D_min", "D_hour", "D_day",
              "RN_001A", "RN_002A", "RN_003A", "RN_005A",
              "RN_010A", "RN_020A", "RN_030A", "RN_050A",
              "RN_100A")

  kostra_rn <- get_stats("49125", as_depth = FALSE)

  expect_equal(colnames(kostra_rn), cnames)
})

test_that("All duration levels are included.", {

  durations <- c(5, 10, 15, 20, 30, 45, 60, 90, 120, 180, 240, 360, 540, 720,
                 1080, 1440, 2880, 4320, 5760, 7200, 8640, 10080)

  kostra_hn <- get_stats("49125")

  expect_equal(kostra_hn[["D_min"]], durations)
})

test_that("All return periods are appended as attributes.", {

  rperiods <- c(1, 2, 3, 5, 10, 20, 30, 50, 100)

  kostra_hn <- get_stats("49125")

  expect_equal(attr(kostra_hn, "returnperiods_a"), rperiods)
})

test_that("Types are as expected.", {

  kostra_hn <- get_stats("49125")

  expect_equal(attr(kostra_hn, "type"), "HN")



  kostra_rn <- get_stats("49125", as_depth = FALSE)

  expect_equal(attr(kostra_rn, "type"), "RN")
})

test_that("Function output and reference object are equal.", {

  kostra_hn <- get_stats("49125")

  expect_equal(kostra_hn, kostra_ref)
})
