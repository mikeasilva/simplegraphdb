#' Generates the SQL to remove a node from the database
#'
#' @param identifier The identifier for the node
#' @export
remove_node <- function(identifier){
  identifier <- as.character(identifier)
  paste0("DELETE FROM edges WHERE source = \"", identifier, "\" OR target = \"", identifier, "\"; DELETE FROM nodes WHERE id = \"", identifier,"\";")
}
