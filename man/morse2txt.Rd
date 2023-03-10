% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/translate.R
\name{morse2txt}
\alias{morse2txt}
\title{Convert Morse Code to a String}
\usage{
morse2txt(string)
}
\arguments{
\item{string}{Character. A Morse Code string. See details.}
}
\value{
A character string.
}
\description{
Provide a string of Morse Code and it'll be converted to the corresponding
text.
}
\details{
Only certain characters can be converted to and from Morse Code.
See the inbuilt \code{\link{morse_lookup}} dataset. The input will be
composed of dits (or dots, '.'), dahs (or dashes, '-'), dividers around
the dits and dahs that represent a single character ('/') and word
dividers (' ', a space). Ideally it will have been produced using
\code{\link{txt2morse}}.
}
\examples{
txt2morse("hello there!") |> morse2txt()
}
