test_that("Function working as intended.", {

  expect_equal(as_depth(x = 843.3, d = 5) |> as.numeric(), 25.3)

  expect_equal(as_depth(x = 126.9, d = 60) |> as.numeric(), 45.7)

  expect_equal(as_depth(x = 13.9, d = 1440) |> as.numeric(), 120.1)
})
