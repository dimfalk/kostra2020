test_that("Building of 'INDEX_RC' out of X and Y information works.", {

  expect_equal(idx_build(col = 125, row = 49), "49125")

  expect_equal(idx_build(col = 1, row = 0), "1")

  expect_equal(idx_build(col = 34, row = 36), "36034")

  expect_equal(idx_build(col = 5, row = 102), "102005")
})
