test_that("Sample grid cell is available in the dataset.", {

  expect_true(idx_exists("49125"))
})

test_that("Random grid cell is not available in the dataset.", {

  expect_false(idx_exists("foobar"))
})
