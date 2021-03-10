#' An atomic transaction wrapper function
#'
#' @param db_file The name of the SQLite database
#' @param sql_statement The SQL statement to execute
#' @return Either the query results or NA for executed SQL statements
#' @import RSQLite
#' @export
atomic <- function(db_file, sql_statement) {
  # Determine if we can use the dbSendQuery function (assume yes initially)
  use_db_send_query <- TRUE
  # Check the SQL statement to see if we need to change this assumption
  for (data_manipulation_keyword in c("INSERT", "DELETE", "UPDATE", "MERGE", "LOAD", "TRUNCATE", "DROP", "CREATE")) {
    if (grepl(data_manipulation_keyword, toupper(sql_statement))) {
      use_db_send_query <- FALSE
    }
  }
  # Connect to the database and send the query
  connection <- RSQLite::dbConnect(RSQLite::SQLite(), db_file)
  #RSQLite::dbExecute(connection, "PRAGMA foreign_keys = TRUE;")
  RSQLite::dbExecute(connection, "BEGIN TRANSACTION;")
  if (use_db_send_query) {
    res <- RSQLite::dbSendQuery(connection, sql_statement)
    results <- RSQLite::dbFetch(res)
    RSQLite::dbClearResult(res)
  } else {
    RSQLite::dbExecute(connection, sql_statement)
    results <- NA
  }
  RSQLite::dbCommit(connection)
  RSQLite::dbDisconnect(connection)
  return(results)
}
