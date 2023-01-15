test_that("Output class is as expected.", {

  expect_s3_class(get_centroid(x = c(367773, 5703579), epsg = 25832), c("sfc_POINT", "sfc"))
})

test_that("Function working as intended.", {

  p <- get_centroid(x = c(6.19, 50.46), epsg = 4326) |> sf::st_coordinates() |> as.numeric()
  expect_equal(p, c(6.19, 50.46))

  p <- get_centroid(x = c(367773, 5703579), epsg = 25832) |> sf::st_coordinates() |> as.numeric()
  expect_equal(p, c(367773, 5703579))

  testthat::skip_if_offline()

  p <- get_centroid(x = "52070") |> sf::st_coordinates() |> as.numeric() |> round(1)
  expect_equal(p, c(6.1, 50.8))

  p <- get_centroid(x = "Freiburg im Breisgau") |> sf::st_coordinates() |> as.numeric() |> round(1)
  expect_equal(p, c(7.8, 48.0))

  p <- get_centroid(x = "Kronprinzenstr. 24, 45128 Essen") |> sf::st_coordinates() |> as.numeric() |> round(1)
  expect_equal(p, c(7.0, 51.4))
})

test_that("Fallbacks working as intended.", {

  testthat::skip_if_offline()

  expect_error(get_centroid(x = "This won't return any results."))

  expect_warning(get_centroid(x = c(20, 80), epsg = 4326))
})
