#' Add an edge to the database
#'
#' @param source_id Source node's id
#' @param target_id Target node's id
#' @param properties Edge properties (optional)
#' @return A SQL statement to insert an edge into the database
#' @examples
#' \dontrun{
#' library(simplegraphdb)
#' apple <- "apple_test.sqlite"
#' initialize(apple)
#' atomic(apple, add_node(list(
#'   "name" = "Apple Computer Company",
#'   "type" = c("company", "start-up"),
#'   "founded" = "April 1, 1976"), 1))
#' atomic(apple, add_node(list(
#'   "name" = "Steve Wozniak",
#'   "type" = c("person", "engineer", "founder")), 2))
#' atomic(apple, add_node(list(
#'   "name" = "Steve Jobs",
#'   "type" = c("person", "designer", "founder")), 3))
#' atomic(apple, add_node(list(
#'   "name" = "Ronald Wayne",
#'   "type" = c("person", "administrator", "founder")), 4))
#' atomic(apple, add_node(list(
#'   "name" = "Mike Markkula",
#'   "type" = c("person", "investor")), 5))
#'
#' # Add in some edges to the graph
#' atomic(apple, connect_nodes(2, 1, list("action" = "founded")))
#' atomic(apple, connect_nodes(3, 1, list("action" = "founded")))
#' atomic(apple, connect_nodes(4, 1, list("action" = "founded")))
#' atomic(apple, connect_nodes(5, 1, list(
#'   "action" = "invested",
#'   "equity" = 80000,
#'   "debt" = 170000)))
#' atomic(apple, connect_nodes(1, 4, list(
#'   "action" = "divested",
#'   "amount" = 800,
#'   "date" = "April 12, 1976")))
#' atomic(apple, connect_nodes(2, 3))
#'}
#' @import rjson
#' @export
connect_nodes <- function(source_id, target_id, properties = list()) {
  rjson::toJSON(properties)
  paste0("INSERT INTO edges VALUES(\"", as.character(source_id), "\", \"", as.character(target_id), "\", json('", rjson::toJSON(properties), "'));")
}
