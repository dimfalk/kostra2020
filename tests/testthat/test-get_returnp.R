kostra <- get_stats("49011")

test_that("Getting return periods works.", {

  expect_equal(get_returnp(kostra, 72.3, 1440), c(30, 50))

  expect_equal(get_returnp(kostra, 42.8, 1440), c(2, 2))
  expect_equal(get_returnp(kostra, 30.2, 1440), c(0, 1))
  expect_equal(get_returnp(kostra, 86.3, 1440), c(100, Inf))
})
