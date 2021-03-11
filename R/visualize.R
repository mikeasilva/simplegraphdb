#' Generates dot files for visualization of the graph
#'
#' @param db_file The name of the SQLite database
#' @param dot_file The name of the file
#' @param path The path to include in the visualization
#' @param exclude_node_keys The node keys to exclude from the visualization
#' @param hide_node_key Boolean if the node key is hidden
#' @param node_kv The node key values
#' @param exclude_edge_keys The key of edges to exclude
#' @param hide_edge_key Boolean if the edge key is hidden
#' @param edge_kv The edge key values
#' @return No return value.  It creates a file.
#' @examples
#' \dontrun{
#' library(simplegraphdb)
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
#' atomic(apple, upsert_node(2, list("nickname" = "Woz"), apple))
#'
#' # Visualize the data
#' visualize(apple, dot_file = "apple.dot", path = c(4, 1, 5))
#'}
#' @import rjson
#' @export
visualize <- function(db_file, dot_file = "file.dot", path = c(),  exclude_node_keys = c(), hide_node_key = FALSE, node_kv = " ", exclude_edge_keys = c(), hide_edge_key = FALSE, edge_kv = " ") {
  # All the data will be stored in the following vector
  lines <- c("digraph {")
  nodes <- c()
  edges <- c()

  for (i in path) {
    # Get the node information
    node_string <- paste0(i, " [label=\"")
    node <- simplegraphdb::atomic(db_file, simplegraphdb::find_node(i))
    node <- rjson::fromJSON(node$body)

    for (key in names(node)) {
      if (key != "id" & !(key %in% exclude_node_keys)) {
        if (!hide_node_key) {
          node_string <- paste0(node_string, key, " ")
        }
        val <- node[key]
        if (length(unlist(val)) > 1) {
          val <- as.character(rjson::toJSON(val))
          val <- strsplit(val, ":")[[1]][2]
          val <- gsub('\"', "\'", val)
          val <- gsub("}", "", val)
          val <- gsub("','", "', '", val)
        }

        node_string <- paste0(node_string, val, "\\n")
      }
    }
    node_string <- trimws(node_string, which = "right")
    node_string <- substr(node_string, 1, nchar(node_string) - 2)
    node_string <- paste0(node_string, "\"];")
    nodes <- c(nodes, node_string)

    # Get the edge information
    neighbors <- simplegraphdb::atomic(db_file, simplegraphdb::find_outbound_neighbors(i))
    for (neighbor_id in neighbors$target) {
      edge <- rjson::fromJSON(neighbors[neighbors$target == neighbor_id, "properties"])
      edge_string <- paste0(i, " -> ", neighbor_id, " [label=\"")

      for (key in names(edge)) {
        if (!(key %in% exclude_edge_keys)) {
          if (!hide_edge_key) {
            edge_string <- paste0(edge_string, key, " ")
          }
          val <- edge[key]
          if (length(unlist(val)) > 1) {
            val <- as.character(rjson::toJSON(val))
            val <- strsplit(val, ":")[[1]][2]
            val <- gsub('\"', "\'", val)
            val <- gsub("}", "", val)
          }

          edge_string <- paste0(edge_string, val, "\\n")
        }
      }
      edge_string <- trimws(edge_string, which = "right")
      edge_string <- substr(edge_string, 1, nchar(edge_string) - 2)
      edge_string <- paste0(edge_string, "\"];")
      edges <- c(edges, edge_string)
    }
  }
  lines <- c(lines, nodes, edges, "}")
  # Write the file out
  file_connection <- file(dot_file)
  writeLines(lines, file_connection)
  close(file_connection)
}
