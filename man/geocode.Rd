% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geocode.R
\name{geocode}
\alias{geocode}
\title{Geocode an address using the Geogratis API}
\usage{
geocode(address)
}
\arguments{
\item{address}{<\code{character}> A character string specifying the address to geocode.}
}
\value{
A named vector containing the latitude and longitude values of the
geocoded address.
}
\description{
This function takes an address as input and returns the corresponding
geographic coordinates (latitude and longitude) using the
\href{https://geogratis.gc.ca/}{Geogratis API}.
The address is converted to raw bytes and used as a query to the Geogratis
API to obtain the geographic coordinates. The result is returned as a named
vector containing the latitude and longitude values.
}
