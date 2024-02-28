test_that("Output class is as expected.", {

  expect_s3_class(get_centroid(c(367773, 5703579), crs = "epsg:25832"), c("sfc_POINT", "sfc"))
})

test_that("Function working as intended.", {

  p <- get_centroid(c(6.19, 50.46), crs = "epsg:4326") |> sf::st_coordinates() |> as.numeric()
  expect_equal(p, c(6.19, 50.46))

  p <- get_centroid(c(367773, 5703579), crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric()
  expect_equal(p, c(367773, 5703579))

  # testthat::skip_if_offline()

  p <- get_centroid("40477") |> sf::st_coordinates() |> as.numeric() |> round(1)
  expect_equal(p, c(6.8, 51.2))

  p <- get_centroid("Freiburg im Breisgau") |> sf::st_coordinates() |> as.numeric() |> round(1)
  expect_equal(p, c(7.8, 48.0))

  p <- get_centroid("Kronprinzenstr. 24, 45128 Essen") |> sf::st_coordinates() |> as.numeric() |> round(1)
  expect_equal(p, c(7.0, 51.4))
})

test_that("Fallbacks working as intended.", {

  # testthat::skip_if_offline()

  expect_error(get_centroid("This won't return any results."))

  expect_warning(get_centroid(c(20, 80), crs = "epsg:4326"))
})
