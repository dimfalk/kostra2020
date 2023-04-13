test_that("Function working as intended with numeric.", {

  expect_equal(as_yield(25.3, d = 5), units::as_units(843.3, "l s-1 ha-1"))

  expect_equal(as_yield(45.7, d = 60), units::as_units(126.9, "l s-1 ha-1"))

  expect_equal(as_yield(120.5, d = 1440), units::as_units(13.9, "l s-1 ha-1"))
})

test_that("Function working as intended with units", {

  expect_equal(as_yield(units::as_units(25.3, "mm"), d = units::as_units(5, "min")), units::as_units(843.3, "l s-1 ha-1"))

  expect_equal(as_yield(units::as_units(45.7, "mm"), d = units::as_units(60, "min")), units::as_units(126.9, "l s-1 ha-1"))

  expect_equal(as_yield(units::as_units(120.5, "mm"), d = units::as_units(1440, "min")), units::as_units(13.9, "l s-1 ha-1"))
})
