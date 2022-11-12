test_that("Getting precipitation depths works.", {

  expect_equal(get_pdepth(kostra_ref, d = 5, tn = 1) |> as.numeric(), 5.6)

  expect_equal(get_pdepth(kostra_ref, d = 4320, tn = 1) |> as.numeric(), 49.8)

  expect_equal(get_pdepth(kostra_ref, d = 5, tn = 100) |> as.numeric(), 14.4)

  expect_equal(get_pdepth(kostra_ref, d = 4320, tn = 100) |> as.numeric(), 108.1)
})
