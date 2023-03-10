% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/legend_render.R
\name{legend_render.bivar_ldelta_rq3}
\alias{legend_render.bivar_ldelta_rq3}
\title{Render the legend for a \code{bivar_ldelta_rq3} class}
\usage{
\method{legend_render}{bivar_ldelta_rq3}(vars, font_family = "SourceSansPro", lang = NULL, ...)
}
\arguments{
\item{vars}{<\verb{named list}> A list object with a \code{bivar_ldelta_rq3} class. The
necessary objects in the list are \code{var_left} and \code{var_right}, with the first
of length 2 (two years) and the second of length 1 (one year).
2 (two years each) The output of \code{\link{vars_build}}.}

\item{font_family}{<\code{character}> Which font family should be used to render
the legend (breaks, axis titles, ...). Defaults to \code{SourceSansPro}. To use
the default font family og ggplot2, use \code{NULL}.}

\item{lang}{<\code{character}> The language to use for the text labels. Defaults
to NULL for no translation.}

\item{...}{Additional arguments passed to other functions.}
}
\value{
A ggplot object that represents the \code{bivar_ldelta_rq3} legend.
}
\description{
This function generates a plot with a bivariate color legend using the
ggplot2 package. It uses the \code{\link{legend_get_info}} function
to show the relationship between the variations of the first variable with the
value of a static year of the second variable. The legend consists of a grid
of colored squares with text labels indicating the meaning of each square.
}
