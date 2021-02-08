#' Generates the SQL to add a node to the database
#'
#' @param data Data to be added to the node in a list format
#' @param identifier The identifier for the node
#' @import jsonlite
#' @export
add_node <- function(data, identifier = NA){
  # TODO: Add in JSON string to list handling
  data <- jsonlite::toJSON(data)
  paste0("INSERT INTO nodes VALUES(json('", simplegraphdb::set_id(identifier, data), "'));")
}
