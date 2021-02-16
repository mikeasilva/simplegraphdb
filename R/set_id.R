#' Sets the id attribute in JSON data
#'
#' @param identifier The id
#' @param data The JSON data
#' @import rjson
#' @export
set_id <- function(identifier = NA, data) {
  if(!is.na(identifier)){
    data <- rjson::fromJSON(data)
    data$id = as.character(identifier)
    data <- rjson::toJSON(data)
  }
  return(data)
}
