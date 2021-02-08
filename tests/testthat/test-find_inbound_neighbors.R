test_that("find_inbound_neighbors works", {
  expect_equal(find_inbound_neighbors(1), "SELECT * FROM edges WHERE target = 1;")
})
