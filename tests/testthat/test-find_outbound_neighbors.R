test_that("find_outbound_neighbors works", {
  expect_equal(find_outbound_neighbors(1), "SELECT * FROM edges WHERE source = 1;")
})
