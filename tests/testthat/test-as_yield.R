test_that("Function working as intended.", {

  expect_equal(as_yield(hn = 25.3, d = 5) |> as.numeric(), 843.3)

  expect_equal(as_yield(hn = 45.7, d = 60) |> as.numeric(), 126.9)

  expect_equal(as_yield(hn = 120.5, d = 1440) |> as.numeric(), 13.9)
})
