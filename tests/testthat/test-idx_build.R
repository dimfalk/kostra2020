test_that("Building of 'INDEX_RC' out of X and Y information works.", {

  expect_equal(idx_build(col = 0, row = 0), "0")

  expect_equal(idx_build(col = 1, row = 2), "2001")

  expect_equal(idx_build(col = 125, row = 49), "49125")

  expect_equal(idx_build(col = 5, row = 102), "102005")

  expect_equal(idx_build(col = 299, row = 299), "299299")
})
