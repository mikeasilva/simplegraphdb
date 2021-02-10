test_that("Database initialization works", {
  db <- "initialize_test.sqlite"
  initialize(db, "../schema.sql")
  test_md5 <- tools::md5sum(db)
  should_match <- tools::md5sum("initialize.sqlite")
  #unlink(db)
  #expect_equal(test_md5, should_match)
})
