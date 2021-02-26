test_that("traverse works", {
  apple <- "apple_test.sqlite"
  initialize(apple, "../schema.sql")
  atomic(apple, add_node(list("name" = "Apple Computer Company", "type" = c("company", "start-up"), "founded" = "April 1, 1976"), 1))
  atomic(apple, add_node(list("name" = "Steve Wozniak", "type" = c("person", "engineer", "founder")), 2))
  atomic(apple, add_node(list("name" = "Steve Jobs", "type" = c("person", "designer", "founder")), 3))
  atomic(apple, add_node(list("name" = "Ronald Wayne", "type" = c("person", "administrator", "founder")), 4))
  atomic(apple, add_node(list("name" = "Mike Markkula", "type" = c("person", "investor")), 5))
  atomic(apple, connect_nodes(2, 1, list("action" = "founded")))
  atomic(apple, connect_nodes(3, 1, list("action" = "founded")))
  atomic(apple, connect_nodes(4, 1, list("action" = "founded")))
  atomic(apple, connect_nodes(5, 1, list("action" = "invested", "equity" = 80000, "debt" = 170000)))
  atomic(apple, connect_nodes(1, 4, list("action" = "divested", "amount" = 800, "date" = "April 12, 1976")))
  atomic(apple, connect_nodes(2, 3))
  atomic(apple, upsert_node(2, list("nickname" = "Woz"), apple))

  expect_equal(traverse(apple, 2, 3), "[\"2\",\"3\"]")
  expect_equal(traverse(apple, 4, 5), "[\"4\",\"1\",\"5\"]")
  expect_equal(traverse(apple, 5, neighbors_fn = "find_inbound_neighbors"), "\"5\"")
  expect_equal(traverse(apple, 5, neighbors_fn = "find_outbound_neighbors"), "[\"5\",\"1\",\"4\"]")
  expect_equal(traverse(apple, 5, neighbors_fn = "find_neighbors"), "[\"5\",\"1\",\"4\",\"3\",\"2\"]")

  unlink(apple)
})
