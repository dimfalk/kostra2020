% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_uncertainties.R
\name{get_uncertainties}
\alias{get_uncertainties}
\title{Get cell-specific uncertainty estimates from the KOSTRA-DWD-2020 dataset}
\usage{
get_uncertainties(x = NULL)
}
\arguments{
\item{x}{character. Relevant "INDEX_RC" field to be queried.}
}
\value{
Tibble containing statistical uncertainties \code{[\%]} as a function of
duration and return periods for the KOSTRA-DWD-2020 grid cell specified.
}
\description{
Get cell-specific uncertainty estimates from the KOSTRA-DWD-2020 dataset
}
\examples{
get_uncertainties("117111")
}
\seealso{
\code{\link[=idx_build]{idx_build()}}
}
