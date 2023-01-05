
#' Convert a String to Morse Code
#'
#' Provide a string of text and it'll be converted to the corresponding Morse
#' Code.
#'
#' @param string Character.
#'
#' @details Only certain characters can be converted to and from Morse Code.
#'     See the inbuilt \code{\link{lookup}} dataset.
#'
#' @return A character string.
#'
#' @export
#'
#' @examples txt2morse("hello there")
txt2morse <- function(string) {

  if (
    length(string) != 1 ||
    !is.character(string) ||
    is.na(string) ||
    nchar(string) == 0
  ) {
    stop("String must be a character vector of length 1", call. = FALSE)
  }

  st_split <- strsplit(toupper(string), "")[[1]]
  chars <- st_split[which(st_split %in% names(lookup))]
  paste0(lookup[chars], collapse = " ")

}

#' Convert Morse Code to a String
#'
#' Provide a string of Morse Code and it'll be converted to the corresponding
#' text.
#'
#' @param string Character. Some text. See details.
#'
#' @details Only certain characters can be converted to and from Morse Code.
#'     See the inbuilt \code{\link{lookup}} dataset.
#'
#' @return A character string.
#'
#' @export
#'
#' @examples txt2morse("hello there") |> morse2txt()
morse2txt <- function(string) {

  if (
    length(string) != 1 ||
    !is.character(string) ||
    is.na(string) ||
    nchar(string) == 0
  ) {
    stop("String must be a character vector of length 1.", call. = FALSE)
  }

  if (any(!unique(strsplit(string, "")[[1]]) %in% c(".", "-", " "))) {
    stop("String can only contain '.', '-', ' ' (space).", call. = FALSE)
  }

  chars <- strsplit(string, " ")[[1]]
  lookup_inv <- setNames(names(lookup), lookup)
  paste0(lookup_inv[chars], collapse = "")

}

#' Play Morse Code as Sound
#'
#' Provide a Morse Code string and it will be played over your computer's
#' speakers.
#'
#' @param string Character. Some Morse Code expressed as 'dits' ('.')
#'     'dahs' ('-') and spaces (' '). Ideally produced by function
#'     \code{\link{txt2morse}}. See details.
#' @param dit_length Numeric. Length of a 'dit' in seconds. The length of a
#'     'dah' will be three times the \code{dit_length}.
#' @param play Logical. Should sounds be played? Defaults to \code{TRUE}.
#'     Included for testing purposes.
#'
#' @details Only certain characters can be converted to and from Morse Code.
#'     See the inbuilt \code{\link{lookup}} dataset.
#'
#' @return Nothing. Sounds will play if \code{play = TRUE}.
#'
#' @export
#'
#' @examples \dontrun{txt2morse("hello there") |> morse2txt() |> morse2sfx}
morse2sfx <- function(string, dit_length = 0.05, play = TRUE) {

  if (
    length(string) != 1 ||
    !is.character(string) ||
    is.na(string) ||
    nchar(string) == 0)
  {
    stop("String must be a character vector of length 1.", call. = FALSE)
  }

  if (any(!unique(strsplit(string, "")[[1]]) %in% c(".", "-", " "))) {
    stop("String can only contain '.', '-', ' ' (space).", call. = FALSE)
  }

  ditdahs <- strsplit(string, "")[[1]]

  for (ditdah in ditdahs) .ditdah2sfx(ditdah, dit_length, play)

}

#' Convert a Dit or Dah to a Sound
#'
#' @param ditdah. Character. A single 'dit' ('.'), 'dah' ('-'), or space (' ').
#' @param dit_length Numeric. Length of a 'dit' in seconds. The length of a
#'     'dah' will be three times the \code{dit_length}.
#' @param play Logical. Should sounds be played? Defaults to \code{TRUE}.
#'     Included for testing purposes.
#'
#' @noRd
.ditdah2sfx <- function(ditdah = c(".", "-", " "), dit_length, play) {

  ditdah <- match.arg(ditdah)

  if (length(dit_length) != 1 || !is.numeric(dit_length) || is.na(dit_length)) {
    stop("Argument 'dit_length' must be non-NA numeric of length 1.")
  }

  if (is.numeric(play) || !is.logical(play)) {
    stop("Argument 'play' must be logical (TRUE/FALSE).", call. = FALSE)
  }

  if (play) {

    dah_length <- dit_length * 3

    if (ditdah == ".") {
      sonify::sonify(1, 1, duration = dit_length)
      Sys.sleep(dit_length)
    }

    if (ditdah == "-") {
      sonify::sonify(1, 1, duration = dah_length)
      Sys.sleep(dit_length)
    }

    if (ditdah == " ") {
      Sys.sleep(dah_length - dit_length)
    }

  }

}
