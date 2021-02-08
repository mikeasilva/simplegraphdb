#' Generates the SQL to find the connections for a node in the database
#'
#' @param source_id The identifier for the source node
#' @param target_id The identifier for the target node
#' @export
get_connections <- function(source_id, target_id){
  paste0("SELECT * FROM edges WHERE source = ", source_id, " AND target = ", target_id, ";")
}
