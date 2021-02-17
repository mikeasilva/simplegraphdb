test_that("upsert_node works", {
  apple <- "apple_test.sqlite"
  initialize(apple, "../schema.sql")
  atomic(apple, add_node(list("name" = "Apple Computer Company", "type" = c("company", "start-up"), "founded" = "April 1, 1976"), 1))
  upsert_node_sql <- upsert_node(1, list("test" = 1), apple)
  unlink(apple)
  expect_equal(upsert_node_sql, "UPDATE nodes SET body = json('{\"name\":\"Apple Computer Company\",\"type\":[\"company\",\"start-up\"],\"founded\":\"April 1, 1976\",\"id\":\"1\",\"test\":1}') WHERE id = \"1\"")
})
