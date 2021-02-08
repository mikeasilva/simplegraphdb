test_that("remove_node works", {
  expect_equal(remove_node(1), "DELETE FROM edges WHERE source = 1 OR target = 1; DELETE FROM nodes WHERE id = 1;")
})
