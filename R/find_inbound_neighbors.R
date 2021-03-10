#' Generates the SQL to find the inbound neighbors for a node in the database
#'
#' @param identifier The identifier for the node
#' @return A SQL statement to find the inbound neighbors
#' @export
find_inbound_neighbors <- function(identifier) {
  paste0("SELECT * FROM edges WHERE target = \"", identifier, "\";")
}
