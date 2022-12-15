test_that("Function working as intended.", {

  expect_equal(as_yield(x = 25.3, d = 5), units::as_units(843.3, "l s-1 ha-1"))

  expect_equal(as_yield(x = 45.7, d = 60), units::as_units(126.9, "l s-1 ha-1"))

  expect_equal(as_yield(x = 120.5, d = 1440), units::as_units(13.9, "l s-1 ha-1"))
})
