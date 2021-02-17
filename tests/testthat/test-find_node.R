test_that("find_node works", {
  expect_equal(find_node(1), "SELECT body FROM nodes WHERE json_extract(body, '$.id') = \"1\";")
})
