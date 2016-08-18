#######################
#' Fr24.get.input.list
#' 

list_fr24_ACtype <- function(){
  query <- 'SELECT DISTINCT
            AC_TYPE
            FROM AIRCRAFT
            WHERE AC_TYPE IS NOT NULL
            ORDER BY AC_TYPE'
  result <- FR24.query(code = query)
  return(result[,'AC_TYPE'])
}