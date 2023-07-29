.onAttach <- function(libname, pkgname) {

  pkg <- "kostra2020"

  utils::packageVersion(pkg) |> packageStartupMessage()
}
