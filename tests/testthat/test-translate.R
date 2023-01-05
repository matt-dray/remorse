
test_that("only length 1 character vectors accepted in txt2morse", {

  expect_identical(txt2morse("hello"), ".... . .-.. .-.. ---")
  expect_error(txt2morse(string = c("x", "y")))
  expect_error(txt2morse(string = 1))
  expect_error(txt2morse(string = 1:2))
  expect_error(txt2morse(string = NA_character_))
  expect_error(txt2morse(string = NULL))
  expect_error(txt2morse(string = list(x = 1, y = 1)))

})

test_that("only length 1 character vectors accepted in morse2*", {

  expect_identical(morse2txt(".... . .-.. .-.. ---"), "HELLO")
  expect_error(morse2txt(string = c("x", "y")))
  expect_error(morse2txt(string = 1))
  expect_error(morse2txt(string = 1:2))
  expect_error(morse2txt(string = NA_character_))
  expect_error(morse2txt(string = NULL))
  expect_error(morse2txt(string = list(x = 1, y = 1)))

  expect_invisible(morse2sfx(".... . .-.. .-.. ---", play = FALSE))
  expect_error(morse2sfx(string = c("x", "y")))
  expect_error(morse2sfx(string = 1))
  expect_error(morse2sfx(string = 1:2))
  expect_error(morse2sfx(string = NA_character_))
  expect_error(morse2sfx(string = NULL))
  expect_error(morse2sfx(string = list(x = 1, y = 1)))

})

test_that("only '.', '-' and ' ' accepted in morse2*", {

  expect_identical(morse2txt(string = ".... . .-.. .-.. ---"), "HELLO")
  expect_error(morse2txt(string = "x .... . .-.. .-.. ---"))

  expect_invisible(morse2sfx(string = ".... . .-.. .-.. ---", play = FALSE))
  expect_error(morse2sfx(string = "x .... . .-.. .-.. ---"))

})

test_that("dit_length is numeric of length 1", {

  expect_invisible(morse2sfx("-..-", dit_length = 0.05, play = FALSE))
  expect_error(morse2sfx("-..-", dit_length = "x", play = FALSE))
  expect_error(morse2sfx("-..-", dit_length = 1:2, play = FALSE))
  expect_error(morse2sfx("-..-", dit_length = NULL, play = FALSE))
  expect_error(morse2sfx("-..-", dit_length = NA_real_, play = FALSE))

  expect_invisible(.ditdah2sfx(".", dit_length = 0.05, play = FALSE))
  expect_error(.ditdah2sfx("-..-", dit_length = "x", play = FALSE))
  expect_error(.ditdah2sfx("-..-", dit_length = 1:2, play = FALSE))
  expect_error(.ditdah2sfx("-..-", dit_length = NULL, play = FALSE))
  expect_error(.ditdah2sfx("-..-", dit_length = NA_real_, play = FALSE))

})

test_that("play is logical", {

  expect_error(morse2sfx("-..-", play = "x"))
  expect_error(morse2sfx("-..-", play = 1))
  expect_error(morse2sfx("-..-", play = NULL))
  expect_error(morse2sfx("-..-", play = NA))

  expect_error(.ditdah2sfx("-..-", play = "x"))
  expect_error(.ditdah2sfx("-..-", play = 1))
  expect_error(.ditdah2sfx("-..-", play = NULL))
  expect_error(.ditdah2sfx("-..-", play = NA))

})

test_that("each ditdah type gets played without error", {

  small_dur <- 0.0001

  expect_invisible(.ditdah2sfx(".", dit_length = small_dur, play = TRUE))
  expect_invisible(.ditdah2sfx("-", dit_length = small_dur, play = TRUE))
  expect_invisible(.ditdah2sfx(" ", dit_length = small_dur, play = TRUE))

})

test_that("there's a warning if Morse can't be matched", {

  expect_warning(txt2morse("hello!±§"))

})

test_that("stop for unmatched Morse", {

  expect_error(morse2txt(". - .........."))

})
