#' Generates the SQL to find a node from the database
#'
#' @param identifier The identifier for the node
#' @return A SQL statement to find a node
#' @export
find_node <- function(identifier) {
  paste0("SELECT body FROM nodes WHERE json_extract(body, '$.id') = \"", identifier, "\";")
}
