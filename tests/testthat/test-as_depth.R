test_that("Function working as intended.", {

  expect_equal(as_depth(x = 843.3, d = 5), units::as_units(25.3, "mm"))

  expect_equal(as_depth(x = 126.9, d = 60), units::as_units(45.7, "mm"))

  expect_equal(as_depth(x = 13.9, d = 1440), units::as_units(120.1, "mm"))
})
