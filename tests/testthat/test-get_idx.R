test_that("Extraction of 'INDEX_RC' based on WGS84 coordinates works.", {

  p1 <- sf::st_sfc(
    sf::st_point(
      c(6.104606, 50.768626)
    ),
    crs = 4326
  )

  expect_equal(get_idx(p1), "143089")
})

test_that("Extraction of 'INDEX_RC' based on ETRS89/UTM32N coordinates works.", {

  p2 <- sf::st_sfc(
    sf::st_point(
      c(295840, 5628093)
    ),
    crs = 25832
  )

  expect_equal(get_idx(p2), "143089")
})

test_that("Extraction of 'INDEX_RC' based on DHDN/GK3 coordinates works.", {

  p3 <- sf::st_sfc(
    sf::st_point(
      c(2507425, 5625914)
    ),
    crs = 31466
  )

  expect_equal(get_idx(p3), "143089")
})
