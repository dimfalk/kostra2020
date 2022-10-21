test_that("Output class is as expected.", {

  expect_true(inherits(get_centroid(x = c(367773, 5703579)), c("sfc_POINT", "sfc")))
})

test_that("Function working as intended.", {

  expect_equal(get_centroid(x = c(367773, 5703579)) |> sf::st_coordinates() |> as.numeric(), c(367773, 5703579))

  expect_equal(get_centroid(x = "Aachen") |> sf::st_coordinates() |> as.numeric() |> round(0), c(294465, 5628692))

  expect_equal(get_centroid(x = "52070") |> sf::st_coordinates() |> as.numeric() |> round(0), c(295359, 5630920))
})

test_that("Fallbacks working as intended.", {

  expect_error(get_centroid(x = "Freiburg"))

  expect_error(get_centroid(x = "Aix La Chapelle"))

  expect_warning(get_centroid(x = "Neuenkirchen"))

  expect_error(get_centroid(x = "99999"))

  expect_error(get_centroid(x = "02114568201"))
})

