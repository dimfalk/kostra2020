test_that("Getting return periods works.", {

  expect_equal(get_returnp(kostra, hn = 72.3, d = 1440) |> as.numeric(), c(30, 50))

  expect_equal(get_returnp(kostra, hn = 42.8, d = 1440) |> as.numeric(), c(2, 2))

  expect_equal(get_returnp(kostra, hn = 30.2, d = 1440) |> as.numeric(), c(0, 1))

  expect_equal(get_returnp(kostra, hn = 86.3, d = 1440) |> as.numeric(), c(100, Inf))
})
