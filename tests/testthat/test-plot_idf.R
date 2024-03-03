test_that("Output class is as expected.", {

  gg1 <- get_stats("49125") |> plot_idf()

  expect_s3_class(gg1, c("gg", "ggplot"))

  gg2 <- get_stats("49125", as_depth = FALSE) |> plot_idf()

  expect_s3_class(gg2, c("gg", "ggplot"))
})