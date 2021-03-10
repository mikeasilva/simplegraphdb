#' Generates the SQL to add a node to the database
#'
#' @param data Data to be added to the node in a list format
#' @param identifier The identifier for the node
#' @return A SQL statement to add a node to a database
#' @examples
#' \dontrun{
#' library(simplegraphdb)
#' apple <- "apple_test.sqlite"
#' initialize(apple)
#'
#' # Add in some nodes with data
#' atomic(apple, add_node(list("name" = "Apple Computer Company", "type" = c("company", "start-up"), "founded" = "April 1, 1976"), 1))
#' atomic(apple, add_node(list("name" = "Steve Wozniak", "type" = c("person", "engineer", "founder")), 2))
#' atomic(apple, add_node(list("name" = "Steve Jobs", "type" = c("person", "designer", "founder")), 3))
#' atomic(apple, add_node(list("name" = "Ronald Wayne", "type" = c("person", "administrator", "founder")), 4))
#' atomic(apple, add_node(list("name" = "Mike Markkula", "type" = c("person", "investor")), 5))
#'}
#' @import rjson
#' @export
add_node <- function(data, identifier = NA) {
  # TODO: Add in JSON string to list handling
  data <- rjson::toJSON(data)
  paste0("INSERT INTO nodes VALUES(json('", simplegraphdb::set_id(identifier, data), "'));")
}
