#' Add a node to the database
#'
#' @param source_id Source node's id
#' @param target_id Target node's id
#' @param properties Edge properties (optional)
#' @import rjson
connect_nodes <- function(source_id, target_id, properties = list()) {
  rjson::toJSON(properties)
  paste0("INSERT INTO edges VALUES(", source_id, ", ", target_id, ", json('", rjson::toJSON(properties), "'));")
}
