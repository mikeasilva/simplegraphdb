#' Generate SQL to find nodes matching a criteria
#'
#' @param data A list of data that are the search criteria
#' @param where_fn The function to use in the SQL WHERE clause.  Valid values are: search_where (default) or search_like
#' @param search_fn The function to use in the search.  Valid values are: search_equals (default), search_starts_with, or search_contains
#' @export
find_nodes <- function(data, where_fn = "search_where", search_fn = "search_equals") {

  sql <- "SELECT body FROM nodes WHERE json_extract(body, '$."

  sql_where_opperator <- " = "

  if(search_fn == "search_like") {
    sql_where_opperator <- " LIKE "
  }

  for (key in names(data)){
    val <- data[key]

    if(where_fn == "search_starts_with"){
      val <- paste0("%", val)
    }

    if(where_fn == "search_contains"){
      val <- paste0("%", val, "%")
    }

    sql <- paste0(sql, key, "')", sql_where_opperator, '"', val, '"')
  }
  return(sql)
}
