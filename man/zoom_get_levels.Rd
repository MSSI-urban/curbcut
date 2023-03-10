% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zoom_utils.R
\name{zoom_get_levels}
\alias{zoom_get_levels}
\title{Get map zoom levels for a given module and region}
\usage{
zoom_get_levels(id, region, suffix_zoom_levels = "")
}
\arguments{
\item{id}{<\code{character}> The id of the module to retrieve the zoom levels for,
e.g. \code{canale}.}

\item{region}{<\code{character}> The region to retrieve the zoom levels for,
usually one of the output of \code{\link{zoom_get_levels}}.}

\item{suffix_zoom_levels}{<\code{character}> A suffix to the zoom level to determine
if there are additional or fewer levels beyond or under the desired level. If
the levels should stop at \code{CT}, then \verb{_max_CT} would be a valid \code{suffi_zoom_levels}.
The zoom level needs to live as a \code{map_zoom_levels_x} in the global environment,
e.g. \code{map_zoom_levels_city_max_CT}.}
}
\value{
A list containing the zoom levels for the specified region and the
region itself.
}
\description{
This function retrieves the map zoom levels for a given module and region.
It retrieves the list of possible regions for the module and lets the
user provide a suffix to the zoom level to determine if there are
additional or fewer levels beyond or under the desired level. If the specified region
is not part of the available regions for the module, the function selects the
first region in the list of possible regions as they are ordered in priority.
}
