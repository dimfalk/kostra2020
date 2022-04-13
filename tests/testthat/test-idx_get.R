test_that("Extraction of 'INDEX_RC' based on WGS84 coordinates works.", {

  p2 <- sf::st_sfc(
    sf::st_point(
      c(6.09, 50.46)
    ),
    crs = 4326
  )

  expect_equal(idx_get(p2), "61002")
})

test_that("Extraction of 'INDEX_RC' based on ETRS89/UTM32N coordinates works.", {

  p1 <- sf::st_sfc(
    sf::st_point(
      c(367773, 5703579)
    ),
    crs = 25832
  )

  expect_equal(idx_get(p1), "49011")
})
