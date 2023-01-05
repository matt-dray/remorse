
<!-- README.md is generated from README.Rmd. Please edit that file -->

# {remorse}

<!-- badges: start -->

[![Project Status: Concept – Minimal or no implementation has been done
yet, or the repository is only intended to be a limited example, demo,
or
proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R-CMD-check](https://github.com/matt-dray/remorse/workflows/R-CMD-check/badge.svg)](https://github.com/matt-dray/remorse/actions)
[![Codecov test
coverage](https://codecov.io/gh/matt-dray/remorse/branch/main/graph/badge.svg)](https://app.codecov.io/gh/matt-dray/remorse?branch=main)
<!-- badges: end -->

Convert from text to [Morse
Code](https://en.wikipedia.org/wiki/Morse_code) (and vice versa) to
sound.

## Installation

You can install {remorse} from GitHub, which also installs
[{sonify}](https://CRAN.R-project.org/package=sonify).

```
if (!require(remotes)) install.packages("remotes")
remotes::install_github("matt-dray/remorse")
library(remorse)
```

## Example

Text to Morse Code:

``` r
text_in <- "hello there"
morse <- txt2morse(text_in)
morse
#> [1] ".... . .-.. .-.. --- - .... . .-. ."
```

And back again:

``` r
text_out <- morse2txt(morse)
text_out
#> [1] "HELLOTHERE"
```

And from Morse to sound:

``` r
morse2sfx(morse)
```

This will play the dits and dahs over your speaker.
