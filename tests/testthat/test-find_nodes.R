test_that("test_nodes works", {
  expect_equal(find_nodes(list("name"="Steve Jobs")), "SELECT body FROM nodes WHERE json_extract(body, '$.name') = \"Steve Jobs\"")
  expect_equal(find_nodes(list("name"="Steve Jobs"), search_fn = "search_like"), "SELECT body FROM nodes WHERE json_extract(body, '$.name') LIKE \"Steve Jobs\"")
  expect_equal(find_nodes(list("name"="Steve"), where_fn = "search_starts_with"), "SELECT body FROM nodes WHERE json_extract(body, '$.name') = \"%Steve\"")
  expect_equal(find_nodes(list("name"="Steve"), where_fn = "search_contains"), "SELECT body FROM nodes WHERE json_extract(body, '$.name') = \"%Steve%\"")
})
