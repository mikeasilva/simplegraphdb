#' Initialize a new graph database
#'
#' @param db_file The name of the SQLite database
#' @param schema_file The SQL schema file (optional)
#' @export
initialize <- function(db_file, schema_file = "./tests/schema.sql") {
  for (statement in strsplit(readChar(schema_file, file.info(schema_file)$size), ";")[[1]]) {
    simplegraphdb::atomic(db_file, paste0(statement, ";"))
  }
}
