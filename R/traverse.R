#' Finds the path as you traverse the graph
#'
#' @param db_file The name of the SQLite database
#' @param src The id of the source node
#' @param tgt The id of the target node (optional)
#' @param neighbors_fn The neighbor function to employ.  Valid options are find_neighbors, find_inbound_neighbors or find_outbound_neighbors (optional)
#' @import rjson
#' @import utils
#' @export
traverse <- function(db_file, src, tgt = NA, neighbors_fn = "find_neighbors") {
  `%notin%` <- Negate(`%in%`)
  path <- c()
  queue <- c()
  # Check if the node exists
  data <- simplegraphdb::atomic(db_file, simplegraphdb::find_node(src))
  if (nrow(data) > 0) {
    data <- rjson::fromJSON(data$body)
    queue <- c(data$id)
  }
  # Loop over the queue
  while (length(queue) > 0) {
    # Pick the last node from the queue and remove it from the queue
    node <- queue[length(queue)]
    queue <- utils::head(queue, -1)
    # Add it to the path if it's not there
    if (node %notin% path) {
      path <- c(path, node)
    }
    # Find the neighbors and add them to the queue
    if (neighbors_fn == "find_neighbors") {
      neighbors <- simplegraphdb::atomic(db_file, simplegraphdb::find_neighbors(node))
      neighbors <- c(neighbors$source, neighbors$target)
    }
    if (neighbors_fn == "find_inbound_neighbors") {
      neighbors <- simplegraphdb::atomic(db_file, simplegraphdb::find_inbound_neighbors(node))
      neighbors <- unique(neighbors$source)
    }
    if (neighbors_fn == "find_outbound_neighbors") {
      neighbors <- simplegraphdb::atomic(db_file, simplegraphdb::find_outbound_neighbors(node))
      neighbors <- unique(neighbors$target)
    }
    # Determine which neighbors to add to the queue
    neighbors_not_in_queue <- neighbors[neighbors %notin% queue]
    neighbors_to_add_to_queue <- neighbors_not_in_queue[neighbors_not_in_queue %notin% path]
    queue <- c(queue, neighbors_to_add_to_queue)
    # Check to see if we need to
    if (!is.na(tgt)) {
      if (node == tgt) {
        break
      }
    }
  }

  rjson::toJSON(path)
}
