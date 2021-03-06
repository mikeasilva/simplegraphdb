test_that("Initialize works", {
  skip_on_cran()
  db <- "initialize_test.sqlite"
  initialize(db, "../schema.sql")
  test_md5 <- tools::md5sum(db)
  should_match <- tools::md5sum("initialize.sqlite")
  unlink(db)
  expect_equal(as.character(test_md5), as.character(should_match))
})
