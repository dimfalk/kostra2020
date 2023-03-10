% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/idx_build.R
\name{idx_build}
\alias{idx_build}
\title{Build "INDEX_RC" identifier based on given X and Y information}
\usage{
idx_build(col = NULL, row = NULL)
}
\arguments{
\item{col}{integer. One pick from set {0:299}.}

\item{row}{integer. One pick from set {0:299}.}
}
\value{
character. Unique representation of the relevant "INDEX_RC" field.
}
\description{
Build "INDEX_RC" identifier based on given X and Y information
}
\examples{
idx_build(col = 125, row = 49)
}
