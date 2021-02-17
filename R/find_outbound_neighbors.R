#' Generates the SQL to find the outbound neighbors for a node in the database
#'
#' @param identifier The identifier for the node
#' @export
find_outbound_neighbors <- function(identifier){
  identifier <- as.character(identifier)
  paste0("SELECT * FROM edges WHERE source = \"", identifier, "\";")
}
