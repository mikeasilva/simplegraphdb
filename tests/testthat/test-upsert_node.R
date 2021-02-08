test_that("upsert_node works", {
  expect_equal(upsert_node(1, list("test" = 1), "apple.sqlite"), "UPDATE nodes SET body = json('{\"name\":[\"Apple Computer Company\"],\"type\":[\"company\",\"start-up\"],\"founded\":[\"April 1, 1976\"],\"id\":[1],\"test\":[1]}') WHERE id = 1")
})
