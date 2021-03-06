% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/visualize.R
\name{visualize}
\alias{visualize}
\title{Generates dot files for visualization of the graph}
\usage{
visualize(
  db_file,
  dot_file = "file.dot",
  path = c(),
  exclude_node_keys = c(),
  hide_node_key = FALSE,
  node_kv = " ",
  exclude_edge_keys = c(),
  hide_edge_key = FALSE,
  edge_kv = " "
)
}
\arguments{
\item{db_file}{The name of the SQLite database}

\item{dot_file}{The name of the file}

\item{path}{The path to include in the visualization}

\item{exclude_node_keys}{The node keys to exclude from the visualization}

\item{hide_node_key}{Boolean if the node key is hidden}

\item{node_kv}{The node key values}

\item{exclude_edge_keys}{The key of edges to exclude}

\item{hide_edge_key}{Boolean if the edge key is hidden}

\item{edge_kv}{The edge key values}
}
\value{
No return value.  It creates a file.
}
\description{
Generates dot files for visualization of the graph
}
\examples{
\dontrun{
library(simplegraphdb)
library(simplegraphdb)
apple <- "apple_test.sqlite"
initialize(apple)
atomic(apple, add_node(list(
  "name" = "Apple Computer Company",
  "type" = c("company", "start-up"),
  "founded" = "April 1, 1976"), 1))
atomic(apple, add_node(list(
  "name" = "Steve Wozniak",
  "type" = c("person", "engineer", "founder")), 2))
atomic(apple, add_node(list(
  "name" = "Steve Jobs",
  "type" = c("person", "designer", "founder")), 3))
atomic(apple, add_node(list(
  "name" = "Ronald Wayne",
  "type" = c("person", "administrator", "founder")), 4))
atomic(apple, add_node(list(
  "name" = "Mike Markkula",
  "type" = c("person", "investor")), 5))
atomic(apple, connect_nodes(2, 1, list("action" = "founded")))
atomic(apple, connect_nodes(3, 1, list("action" = "founded")))
atomic(apple, connect_nodes(4, 1, list("action" = "founded")))
atomic(apple, connect_nodes(5, 1, list(
  "action" = "invested",
  "equity" = 80000,
  "debt" = 170000)))
atomic(apple, connect_nodes(1, 4, list(
  "action" = "divested",
  "amount" = 800,
  "date" = "April 12, 1976")))
atomic(apple, connect_nodes(2, 3))
atomic(apple, upsert_node(2, list("nickname" = "Woz"), apple))

# Visualize the data
visualize(apple, dot_file = "apple.dot", path = c(4, 1, 5))
}
}
