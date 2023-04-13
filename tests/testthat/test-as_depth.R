test_that("Function working as intended with units.", {

  expect_equal(as_depth(843.3, d = 5), units::as_units(25.3, "mm"))

  expect_equal(as_depth(126.9, d = 60), units::as_units(45.7, "mm"))

  expect_equal(as_depth(13.9, d = 1440), units::as_units(120.1, "mm"))
})

test_that("Function working as intended with units.", {

  expect_equal(as_depth(units::as_units(843.3, "l s-1 ha-1"), d = units::as_units(5, "min")), units::as_units(25.3, "mm"))

  expect_equal(as_depth(units::as_units(126.9, "l s-1 ha-1"), d = units::as_units(60, "min")), units::as_units(45.7, "mm"))

  expect_equal(as_depth(units::as_units(13.9, "l s-1 ha-1"), d = units::as_units(1440, "min")), units::as_units(120.1, "mm"))
})
