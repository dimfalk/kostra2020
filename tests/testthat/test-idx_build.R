test_that("Building of 'INDEX_RC' out of row and column information works.", {

  expect_equal(idx_build(row = 0, col = 0), "0")

  expect_equal(idx_build(row = 2, col = 1), "2001")

  expect_equal(idx_build(row = 49, col = 125), "49125")

  expect_equal(idx_build(row = 102, col = 5), "102005")

  expect_equal(idx_build(row = 299, col = 299), "299299")
})
