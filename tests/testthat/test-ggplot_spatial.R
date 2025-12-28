test_that("Output class is as expected.", {

  gg1 <- ggplot_spatial(d = 60, tn = 1)

  expect_s3_class(gg1, c("gg", "ggplot"))

  gg2 <- ggplot_spatial(d = 1440, tn = 100)

  expect_s3_class(gg2, c("gg", "ggplot"))
})
