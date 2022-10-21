test_that("Output class is as expected.", {

  expect_true(inherits(get_centroid(x = c(367773, 5703579)), c("sfc_POINT", "sfc")))
})

test_that("Function working as intended.", {

  expect_equal(get_centroid(x = c(367773, 5703579)) |> sf::st_coordinates() |> as.numeric(), c(367773, 5703579))

  expect_equal(get_centroid(x = "Aachen") |> sf::st_coordinates() |> as.numeric() |> round(2), c(6.08, 50.77))

  expect_equal(get_centroid(x = "52070") |> sf::st_coordinates() |> as.numeric() |> round(2), c(6.10, 50.79))
})

test_that("Fallbacks working as intended.", {

  expect_error(get_centroid(x = "Freiburg"))

  expect_error(get_centroid(x = "Aix La Chapelle"))

  expect_warning(get_centroid(x = "Neuenkirchen"))

  expect_error(get_centroid(x = "99999"))

  expect_error(get_centroid(x = "02114568201"))
})
