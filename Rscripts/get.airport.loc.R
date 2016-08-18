######### get.airport.loc #########

get.airport.loc <- function(detail = FALSE){
  # con <- dbConnect(MySQL(), user="user_ext", password="fr0-dmds-p01", dbname='FR24', host="fr0-dmds-p01")
  # rs <- dbSendQuery(con, 
  #                   "select 
  #                   APT.IATA, 
  #                   APT.LONGITUDE,
  #                   APT.LATITUDE
  #                   from FR24.AIRPORT APT;")
  # data <- fetch(rs, n = -1)
  # names(data) <- c("IATA","long", "lat")
  # huh <- dbHasCompleted(rs)
  # dbClearResult(rs)
  # dbDisconnect(con)
  if(detail){
    BIO <- odbcDriverConnect('driver={SQL Server};
                              server=fr0-bio-p01,10335;
                           database=BIO_NEO_PROD;
                           trusted_connection=true')
    query.BIO <- sqlQuery(BIO, 
                          'SELECT DISTINCT apt.IATA,
                              apt.LONGITUDE,
                              apt.LATITUDE,
                              apt.NAME,
                              city.NAME as CITY_NAME,
                              state.NAME as STATE_NAME,
                              country.NAME as COUNTRY_NAME,
                              region.NAME as REGION_NAME
                            from BIO_NEO_PROD.bio.AIRPORT apt
                              INNER JOIN BIO_NEO_PROD.bio.GEO_CITY city ON apt.CITY_ID = city.GEO_CITY_ID
                              INNER JOIN BIO_NEO_PROD.bio.GEO_COUNTRY_STATE state ON city.GEO_COUNTRY_STATE_ID = state.GEO_COUNTRY_STATE_ID
                              INNER JOIN BIO_NEO_PROD.bio.GEO_COUNTRY country ON state.GEO_COUNTRY_ID = country.GEO_COUNTRY_ID
                              INNER JOIN BIO_NEO_PROD.bio.GEO_REGION region ON country.GEO_REGION_ID = region.GEO_REGION_ID
                            WHERE (apt.AIRPORT_TYPE_ID = 7 OR apt.AIRPORT_TYPE_ID = 10)
                            AND apt.IATA IS NOT NULL

                          ')
    names(query.BIO) <- c("IATA","long", "lat", "name",'city_name','state_name','country_name','region_name')
    close(BIO)
  }else{
    BIO <- odbcDriverConnect('driver={SQL Server};
                              server=fr0-bio-p01,10335;
                           database=BIO_NEO_PROD;
                           trusted_connection=true')
    query.BIO <- sqlQuery(BIO, 
                          'select IATA,
                            LONGITUDE,
                            LATITUDE,
                            NAME
                    from BIO_NEO_PROD.bio.AIRPORT apt
                            WHERE (apt.AIRPORT_TYPE_ID = 7 OR apt.AIRPORT_TYPE_ID = 10)
                            AND apt.IATA IS NOT NULL')
    names(query.BIO) <- c("IATA","long", "lat", "name")
    close(BIO)
  }
  return(query.BIO)
}

# apttest <- get.airport.loc()

get.airport.esad <- function(){
  BIO <- odbcDriverConnect('driver={SQL Server};
                           server=fr0-bio-p01,10335;
                           database=BIO_NEO_PROD;
                           trusted_connection=true')
  query.BIO <- sqlQuery(BIO, 
                        'SELECT DISTINCT from_.IATA AS ORG,
                                to_.IATA AS DST,
                                apt.DISTANCE,
                                apt.ESAD
                        FROM BIO_NEO_PROD.bio.AIRPORT_PAIR apt
                        INNER JOIN BIO_NEO_PROD.bio.AIRPORT from_ ON apt.ORG_AIRPORT_ID = from_.AIRPORT_ID
                        INNER JOIN BIO_NEO_PROD.bio.AIRPORT to_ ON apt.DST_AIRPORT_ID = to_.AIRPORT_ID
                        ')
  # names(query.BIO) <- c("IATA","long", "lat")
  close(BIO)
  return(query.BIO)
}

get.airline.code <- function(){
  BIO <- odbcDriverConnect('driver={SQL Server};
                           server=fr0-bio-p01,10335;
                           database=BIO_NEO_PROD;
                           trusted_connection=true')
  query.BIO <- sqlQuery(BIO, 
                        "
                      SELECT DISTINCT
                        (IATA + ', ' + SHORT_NAME) AS NAME
                        FROM BIO_NEO_PROD.bio.ACCOUNT
                        WHERE (IATA IS NOT NULL AND IATA != '')
                        ORDER BY NAME
                        ")

  close(BIO)
  return(levels(query.BIO$NAME))
}
# apttest <- get.airport.esad()
