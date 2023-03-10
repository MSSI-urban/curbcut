% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zoom_utils.R
\name{zoom_get}
\alias{zoom_get}
\title{Rounds down a zoom level to the nearest half-integer}
\usage{
zoom_get(zoom)
}
\arguments{
\item{zoom}{<\code{numeric}> a numeric value representing the map zoom state}
}
\value{
A numeric value representing the rounded-down zoom level
}
\description{
This function takes a zoom level as input and returns the zoom level rounded
down to the nearest half-integer. For example, a zoom level of 2.3 would be
rounded down to 2, while a zoom level of 3.7 would be rounded down to 3.5.
}
