test_that("Getting precipitation heights works.", {

  expect_equal(get_precip(kostra, d = 5, tn = 1), 5.6)
  expect_equal(get_precip(kostra, d = 4320, tn = 1), 49.8)

  expect_equal(get_precip(kostra, d = 5, tn = 100), 14.4)
  expect_equal(get_precip(kostra, d = 4320, tn = 100), 108.1)
})
