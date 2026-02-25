test_that("Output class is as expected.", {

  params <- get_params("49125")

  expect_s3_class(params, c("tbl_df", "tbl", "data.frame"))
})

test_that("Column names are as expected", {

  params <- get_params("49125")

  expect_equal(colnames(params), c("INDEX_RC",
                                   "XI", "ALPHA", "KAPPA", "THETA", "ETA"))
})

test_that("Column data types are as expected", {

  params <- get_params("49125")

  expect_equal(sapply(params, typeof) |> as.character(),
               c("character", "double", "double", "double", "double", "double"
  ))
})

test_that("Function output and reference object are equal.", {

  params <- get_params("49125")

  expect_equal(params, params_ref)
})
