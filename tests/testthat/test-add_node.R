test_that("add_node works", {
  expect_equal(add_node(list("test"=1)), "INSERT INTO nodes VALUES(json('{\"test\":[1]}'));")
})
