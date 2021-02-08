test_that("get_connections works", {
  expect_equal(get_connections(1, 2), "SELECT * FROM edges WHERE source = 1 AND target = 2;")
})
