test_that("Set id works", {
  expect_equal(as.character(set_id(1, rjson::toJSON(list("test" = 1)))), "{\"test\":1,\"id\":\"1\"}")
})

test_that("Set no id works",{
  expect_equal(as.character(set_id(NA, rjson::toJSON(list("test"= 1)))), "{\"test\":1}")
})
