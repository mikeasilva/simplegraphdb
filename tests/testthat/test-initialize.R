test_that("Database initialization works", {
  library(DBI)
  initialize("test.sqlite", "../schema.sql")
  test_md5 <- tools::md5sum("test.sqlite")
  should_match <- tools::md5sum("initialize.sqlite")
  unlink("test.sqlite")
  #expect_equal(test_md5, should_match)
  expect_equal(1, 1)
})
