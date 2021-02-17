test_that("find_neighbors works", {
  expect_equal(find_neighbors(1), "SELECT * FROM edges WHERE source = \"1\" OR target = \"1\";")
})
