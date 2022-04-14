kostra <- get_stats("49011")

test_that("Getting precipitation heights works.", {

  expect_equal(get_precip(kostra, 5, 1), 5.6)
  expect_equal(get_precip(kostra, 4320, 1), 49.8)

  expect_equal(get_precip(kostra, 5, 100), 14.4)
  expect_equal(get_precip(kostra, 4320, 100), 108.1)
})
