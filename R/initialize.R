#' Initialize a new graph database
#'
#' @param db_file The name of the SQLite database
#' @param schema_file The SQL schema file (optional)
#' @return No return value.  It creates the database.
#' @examples
#' \dontrun{
#' library(simplegraphdb)
#' initialize("network.sqlite")
#' }
#' @export
initialize <- function(db_file, schema_file = "./tests/schema.sql") {
  for (statement in strsplit(readChar(schema_file, file.info(schema_file)$size), ";")[[1]]) {
    simplegraphdb::atomic(db_file, paste0(statement, ";"))
  }
}
