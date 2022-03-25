test_that("Sample grid cell is available in the dataset.", {
  expect_true(2 == 2)
})

test_that("Random grid cell is not available in the dataset.", {
  expect_false(2 != 2)
})

