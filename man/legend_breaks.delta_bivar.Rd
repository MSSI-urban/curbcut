% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/legend_breaks.R
\name{legend_breaks.delta_bivar}
\alias{legend_breaks.delta_bivar}
\title{Compute legend breaks for a comparison of the variable of two variables in
two years}
\usage{
\method{legend_breaks}{delta_bivar}(vars, data, ...)
}
\arguments{
\item{vars}{<\verb{named list}> A list object of class \code{delta_bivar}.}

\item{data}{<\code{data.frame}> Must contains the \code{var_left}, \code{var_left_q3},
\code{var_right} and \code{var_right_q3} columns, which are used to extract the \code{q3}
breaks (variation) for the variables in time.}

\item{...}{Additional arguments passed to methods.}
}
\value{
A vector of legend breaks with pretty labels.
}
\description{
The \code{delta_bivar} class is used when we compare two variations together.
}
