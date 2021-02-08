#' Sets the id attribute in JSON data
#'
#' @param identifier The id
#' @param data The JSON data
#' @import jsonlite
#' @export
set_id <- function(identifier = NA, data) {
  if(!is.na(identifier)){
    data <- jsonlite::fromJSON(data)
    data$id = identifier
    data <- jsonlite::toJSON(data)
  }
  return(data)
}
