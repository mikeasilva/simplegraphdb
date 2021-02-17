#' Generates the SQL to upsert a node in the database
#'
#' @param identifier The identifier for the node
#' @param data Data to be added to the node in a list format
#' @param db_file The name of the SQLite database
#' @import rjson
#' @export
upsert_node <- function(identifier, data, db_file) {
  # TODO: Add in JSON string to list handling
  identifier <- as.character(identifier)
  current_data <- simplegraphdb::atomic(db_file, simplegraphdb::find_node(identifier))
  current_data <- rjson::fromJSON(current_data$body)
  updated_data <- c(current_data, data)
  updated_data <- simplegraphdb::set_id(identifier, rjson::toJSON(updated_data))
  paste0("UPDATE nodes SET body = json('", updated_data, "') WHERE id = \"", identifier,"\"")
}
