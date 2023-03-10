% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{widget_id_verif}
\alias{widget_id_verif}
\title{Verify widget ID validity}
\usage{
widget_id_verif(widget_id)
}
\arguments{
\item{widget_id}{<\code{character}>  the widget ID to be verified.}
}
\value{
The original widget ID if it passes all verification criteria.
}
\description{
This function checks the validity of a given widget ID by verifying if it
meets the following criteria:
\itemize{
\item The widget ID cannot be an empty string
\item The widget ID does not contain more than one underscore.
\item The widget ID is no longer than 3 characters.
\item The widget ID does not interfere with known codes and short codes.
}
}
