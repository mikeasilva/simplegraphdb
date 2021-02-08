test_that("connect_nodes without properties works", {
  expect_equal(connect_nodes(1, 2), "INSERT INTO edges VALUES(1, 2, json('[]'));")
})

test_that("connect_nodes without properties works", {
  expect_equal(connect_nodes(1, 2, list("test"=1)), "INSERT INTO edges VALUES(1, 2, json('{\"test\":[1]}'));")
})
