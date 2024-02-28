test_that("Sample grid cell is available in the dataset.", {

  expect_true(idx_exists("48122"))

  expect_true(idx_exists("49125"))

  expect_true(idx_exists("224148"))
})

test_that("Random grid cell is not available in the dataset.", {

  expect_false(idx_exists("0"))

  expect_false(idx_exists("40477"))
})
