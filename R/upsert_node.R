#' Generates the SQL to upsert a node in the database
#'
#' @param identifier The identifier for the node
#' @param data Data to be added to the node in a list format
#' @param db_file The name of the 'SQLite' database
#' @return A SQL statement to upsert a node
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
#'
#' #Upsert some data
#' atomic(apple, upsert_node(2, list("nickname" = "Woz"), apple))
#'}
#' @import rjson
#' @export
upsert_node <- function(identifier, data, db_file) {
  # TODO: Add in JSON string to list handling
  identifier <- as.character(identifier)
  current_data <- simplegraphdb::atomic(db_file, simplegraphdb::find_node(identifier))
  current_data <- rjson::fromJSON(current_data$body)
  updated_data <- c(current_data, data)
  updated_data <- simplegraphdb::set_id(identifier, rjson::toJSON(updated_data))
  paste0("UPDATE nodes SET body = json('", updated_data, "') WHERE id = \"", identifier, "\"")
}
