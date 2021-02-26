#' Generates the SQL to add a node to the database
#'
#' @param data Data to be added to the node in a list format
#' @param identifier The identifier for the node
#' @import rjson
#' @export
add_node <- function(data, identifier = NA) {
  # TODO: Add in JSON string to list handling
  data <- rjson::toJSON(data)
  paste0("INSERT INTO nodes VALUES(json('", simplegraphdb::set_id(identifier, data), "'));")
}
