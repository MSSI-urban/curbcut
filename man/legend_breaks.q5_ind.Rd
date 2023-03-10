% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/legend_breaks.R
\name{legend_breaks.q5_ind}
\alias{legend_breaks.q5_ind}
\title{Compute legend breaks for a single \code{ind} \code{var_left}}
\usage{
\method{legend_breaks}{q5_ind}(vars, df, lang = NULL, ...)
}
\arguments{
\item{vars}{<\verb{named list}> A list object of class \code{q5_ind}. The output of
\code{\link{vars_build}}.}

\item{df}{<\code{character}> The combination of the region under study
and the scale at which the user is on, e.g. \code{CMA_CSD}. The output of
\code{\link{update_df}}.}

\item{lang}{<\code{character}> String indicating the language to translate the
breaks to. Defaults to \code{NULL}, which is no translation.}

\item{...}{Additional arguments passed to methods.}
}
\value{
A vector of legend breaks with pretty labels.
}
\description{
Compute legend breaks for a single \code{ind} \code{var_left}
}
