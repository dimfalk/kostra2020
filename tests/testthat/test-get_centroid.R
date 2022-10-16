test_that("Function working as intended.", {

  expect_equal(get_centroid(input = c(367773, 5703579)) |> sf::st_coordinates() |> as.numeric(), c(367773, 5703579))

  expect_equal(get_centroid(input = c(6.09, 50.46), crs = 4326) |> sf::st_coordinates() |> as.numeric(), c(6.09, 50.46))

  # expect_equal(get_centroid(input = "Aachen") |> sf::st_coordinates() |> as.numeric() |> round(0), c(296160, 5627069))

  # expect_equal(get_centroid(input = "52070") |> sf::st_coordinates() |> as.numeric() |> round(0), c(295359, 5630920))
})
