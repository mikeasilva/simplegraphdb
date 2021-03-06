# About

This is a simple graph database in [SQLite](https://www.sqlite.org/), inspired by "[Denis Papathanasiou's simple-graph project](https://github.com/dpapathanasiou/simple-graph)", however this is written in R.  This package is fully compatible with the python equivalant and interoperable.  There are minor differences in the API, but it is largely identical.

# Structure

Similar to the python library, the [schema](https://github.com/mikeasilva/simplegraphdb/blob/main/tests/schema.sql) consists of just two structures:

* Nodes - these are any [json](https://www.json.org/) objects, with the only constraint being that they each contain a unique `id` value 
* Edges - these are pairs of node `id` values, specifying the direction, with an optional json object as connection properties

# Applications

* [Social networks](https://en.wikipedia.org/wiki/Social_graph)
* [Interest maps/recommendation finders](https://en.wikipedia.org/wiki/Interest_graph)
* [To-do / task lists](https://en.wikipedia.org/wiki/Task_list)
* [Bug trackers](https://en.wikipedia.org/wiki/Open-source_software_development#Bug_trackers_and_task_lists)
* [Customer relationship management (CRM)](https://en.wikipedia.org/wiki/Customer_relationship_management)
* [Gantt chart](https://en.wikipedia.org/wiki/Gantt_chart)

# Usage

## Installation

  - `devtools::install_github("https://github.com/mikeasilva/simplegraphdb")`

## Basic Functions

The R package provides convenience functions for [atomic transactions](https://en.wikipedia.org/wiki/Atomicity_(database_systems)) to add, delete, connect, and search for nodes.

Any single node or path of nodes can also be depicted graphically by using the `visualize` function within the database script to generate [dot](https://graphviz.org/doc/info/lang.html) files, which in turn can be converted to images with Graphviz.

### Example

Once loading the package in R, we can create, [upsert](https://en.wiktionary.org/wiki/upsert), and connect people from the early days of [Apple Computer](https://en.wikipedia.org/wiki/Apple_Inc.). The resulting database will be saved to a SQLite file named `apple.sqlite`:

```
apple <- "apple.sqlite"
initialize(apple)
atomic(apple, add_node(list("name" = "Apple Computer Company", "type" = c("company", "start-up"), "founded" = "April 1, 1976"), 1))
atomic(apple, add_node(list("name" = "Steve Wozniak", "type" = c("person", "engineer", "founder")), 2))
atomic(apple, add_node(list("name" = "Steve Jobs", "type" = c("person", "designer", "founder")), 3))
atomic(apple, add_node(list("name" = "Ronald Wayne", "type" = c("person", "administrator", "founder")), 4))
atomic(apple, add_node(list("name" = "Mike Markkula", "type" = c("person", "investor")), 5))
atomic(apple, connect_nodes(2, 1, list("action" = "founded")))
atomic(apple, connect_nodes(3, 1, list("action" = "founded")))
atomic(apple, connect_nodes(4, 1, list("action" = "founded")))
atomic(apple, connect_nodes(5, 1, list("action" = "invested", "equity" = 80000, "debt" = 170000)))
atomic(apple, connect_nodes(1, 4, list("action" = "divested", "amount" = 800, "date" = "April 12, 1976")))
atomic(apple, connect_nodes(2, 3))
atomic(apple, upsert_node(2, list("nickname" = "Woz"), apple))
```

The nodes can be searched by their ids or any other combination of attributes (either as strict equality, or using `search_like` in combination with `search_starts_with` or `search_contains`):

```
atomic(apple, find_node(1))
{'name': 'Apple Computer Company', 'type': ['company', 'start-up'], 'founded': 'April 1, 1976', 'id': 1}
atomic(apple, find_nodes({'name': 'Steve'}, "search_like", "search_starts_with"))
[{'name': 'Steve Wozniak', 'type': ['person', 'engineer', 'founder'], 'id': 2, 'nickname': 'Woz'}, {'name': 'Steve Jobs', 'type': ['person', 'designer', 'founder'], 'id': 3}]
```

Paths through the graph can be discovered with a starting node id, and an optional ending id; the default neighbor expansion is nodes connected nodes in either direction, but that can changed by specifying either `find_outbound_neighbors` or `find_inbound_neighbors` instead:

```
traverse(apple, 2, 3)
[2, 3]
traverse(apple, 4, 5)
[4, 1, 5]
traverse(apple, 5, neighbors_fn="find_inbound_neighbors")
[5]
traverse(apple, 5, neighbors_fn="find_outbound_neighbors")
[5, 1, 4]
traverse(apple, 5, neighbors_fn="find_neighbors")
[5, 1, 4, 3, 2]
```

Any path or list of nodes can rendered graphically by using the `visualize` function. This command produces [dot](https://graphviz.org/doc/info/lang.html) files, which are also rendered as images with Graphviz:

```
visualize(apple, 'apple.dot', c(4, 1, 5))
```

There are display options to help refine what is produced:

```
visualize(apple, 'apple.dot', c(4, 1, 5), exclude_node_keys=c('type'), hide_edge_key=TRUE)
```
