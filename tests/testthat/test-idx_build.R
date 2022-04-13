test_that("Building of 'INDEX_RC' out of X and Y information works.", {

  expect_equal(idx_build(col=11, row=49), "49011")
  expect_equal(idx_build(row=10, col=47), "10047")
})
