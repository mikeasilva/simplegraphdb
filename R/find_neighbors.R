#' Generates the SQL to find the neighbors for a node in the database
#'
#' @param identifier The identifier for the node
#' @return A SQL statement to find the neighbors
#' @export
find_neighbors <- function(identifier) {
  paste0("SELECT * FROM edges WHERE source = \"", identifier, "\" OR target = \"", identifier, "\";")
}
