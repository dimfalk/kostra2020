test_that("Building of 'INDEX_RC' out of X and Y information works.", {

  expect_equal(idx_build(col = 125, row = 49), "49125")

  expect_equal(idx_build(row = 10, col = 47), "10047")
})
