test_that("Set id works", {
  expect_equal(as.character(set_id(1, jsonlite::toJSON(list("test" = 1)))), "{\"test\":[1],\"id\":[1]}")
})

test_that("Set no id works",{
  expect_equal(as.character(set_id(NA, jsonlite::toJSON(list("test"=1)))), "{\"test\":[1]}")
})
