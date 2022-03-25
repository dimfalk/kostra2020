test_that("Random test.", {
  expect_equal(2 * 2, 2 + 2)
})

test_that("Sample grid cell is available in the dataset.", {
  expect_true(idx_exists("49011"))
})

test_that("Random grid cell is not available in the dataset.", {
  expect_false(idx_exists("foobar"))
})

test_that("String provided has a length of 5 characters..", {
  expect_equal(nchar("49011"), 5)
})

