
#' Convert a String to Morse Code
#'
#' Provide a string of text and it'll be converted to the corresponding string
#' that represents that string in Morse Code.
#'
#' @param string Character. Some text. See details.
#'
#' @details Only certain characters can be converted to and from Morse Code.
#'     See the inbuilt \code{\link{morse_lookup}} dataset. The output will be
#'     composed of dits (or dots, '.'), dahs (or dashes, '-'), dividers around
#'     the dits and dahs that represent a single character ('/') and word
#'     dividers (' ', a space).
#'
#' @return A character string.
#'
#' @export
#'
#' @examples txt2morse("hello there!")
txt2morse <- function(string) {

  if (
    length(string) != 1 ||
    !is.character(string) ||
    is.na(string) ||
    nchar(string) == 0
  ) {
    stop("String must be a character vector of length 1", call. = FALSE)
  }

  string_split <- strsplit(toupper(string), "")[[1]]
  chars <- string_split[which(string_split %in% names(morse_lookup))]
  mismatches <- setdiff(string_split, chars)

  if (length(mismatches) != 0) {
    warning(
      "Some characters could not be matched to Morse Code: ",
      paste(mismatches, collapse = ", "), ".",
      call. = FALSE
    )
  }

  gsub("/ /", " ", paste0(morse_lookup[chars], collapse = "/"))

}

#' Convert Morse Code to a String
#'
#' Provide a string of Morse Code and it'll be converted to the corresponding
#' text.
#'
#' @param string Character. A Morse Code string. See details.
#'
#' @details Only certain characters can be converted to and from Morse Code.
#'     See the inbuilt \code{\link{morse_lookup}} dataset. The input will be
#'     composed of dits (or dots, '.'), dahs (or dashes, '-'), dividers around
#'     the dits and dahs that represent a single character ('/') and word
#'     dividers (' ', a space). Ideally it will have been produced using
#'     \code{\link{txt2morse}}.
#'
#' @return A character string.
#'
#' @export
#'
#' @examples txt2morse("hello there!") |> morse2txt()
morse2txt <- function(string) {

  if (
    length(string) != 1 ||
    !is.character(string) ||
    is.na(string) ||
    nchar(string) == 0
  ) {
    stop("String must be a character vector of length 1.", call. = FALSE)
  }

  if (any(!unique(strsplit(string, "")[[1]]) %in% c(".", "-", "/", " "))) {
    stop("String can only contain '.', '-', '/', ' ' (space).", call. = FALSE)
  }

  morse_lookup_inv <- stats::setNames(names(morse_lookup), morse_lookup)
  chars <- strsplit(gsub(" ", "/ /", string), "/")[[1]]
  mismatches <- unique(chars[!chars %in% morse_lookup])

  if (length(mismatches) != 0) {
    stop(
      "Some of that Morse Code isn't recognised: ",
      paste(mismatches, collapse = ", "), ".",
      call. = FALSE
    )
  }

  paste0(morse_lookup_inv[chars], collapse = "")

}

#' Play Morse Code as Sound
#'
#' Provide a Morse Code string and it will be played over your computer's
#' speakers as dits (dots), dahs (dashes) and pauses.
#'
#' @param string Character. A Morse Code string. See details.
#' @param dit_length Numeric. Length of a dit in seconds. The length of a dah
#'     will be three times the \code{dit_length}.
#' @param play Logical. Should sounds be played? Defaults to \code{TRUE}.
#'     Included for testing purposes.
#'
#' @details Only certain characters can be converted to and from Morse Code.
#'     See the inbuilt \code{\link{morse_lookup}} dataset. The input will be
#'     composed of dits (or dots, '.'), dahs (or dashes, '-'), dividers around
#'     the dits and dahs that represent a single character ('/') and word
#'     dividers (' ', a space). Ideally it will have been produced using
#'     \code{\link{txt2morse}}.
#'
#' @return Nothing. Sounds will play if \code{play = TRUE}.
#'
#' @export
#'
#' @examples \dontrun{txt2morse("hello there!") |> morse2sfx()}
morse2sfx <- function(string, dit_length = 0.05, play = TRUE) {

  if (
    length(string) != 1 ||
    !is.character(string) ||
    is.na(string) ||
    nchar(string) == 0
  ) {
    stop("String must be a character vector of length 1.", call. = FALSE)
  }

  if (any(!unique(strsplit(string, "")[[1]]) %in% c(".", "-", "/", " "))) {
    stop("String can only contain '.', '-', '/', ' ' (space).", call. = FALSE)
  }

  ditdahs <- strsplit(string, "")[[1]]

  for (ditdah in ditdahs) {
    .ditdah2sfx(ditdah, dit_length, play)
  }

}

#' Convert a Dit or Dah to a Sound
#'
#' @param ditdah Character. A single dit ('.'), dah ('-'), divider ('/'), or
#'     space (' ').
#' @param dit_length Numeric. Length of a dit in seconds.
#' @param play Logical. Should sounds be played? Defaults to \code{TRUE}.
#'     Included for testing purposes.
#'
#' @noRd
.ditdah2sfx <- function(ditdah = c(".", "-", "/", " "), dit_length, play) {

  ditdah <- match.arg(ditdah)

  if (length(dit_length) != 1 || !is.numeric(dit_length) || is.na(dit_length)) {
    stop("Argument 'dit_length' must be non-NA numeric of length 1.")
  }

  if (is.numeric(play) || !is.logical(play)) {
    stop("Argument 'play' must be logical (TRUE/FALSE).", call. = FALSE)
  }

  if (ditdah == ".") {
    if (play) {
      sonify::sonify(1, 1, duration = dit_length)
      Sys.sleep(dit_length)
    }
  }

  if (ditdah == "-") {
    if (play) {
      sonify::sonify(1, 1, duration = 3 * dit_length)
      Sys.sleep(dit_length)
    }
  }

  if (ditdah == "/") {
    if (play) {
      Sys.sleep(2 * dit_length)
    }
  }

  if (ditdah == " ") {
    if (play) {
      Sys.sleep(6 * dit_length)
    }
  }

}
