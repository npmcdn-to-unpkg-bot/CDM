#-------------------------------------------------------------
# This is the global environment definition of Cargo Data Miner. You can
# run the application by clicking 'Run App' above.
#
# Xuzhou QIN, xuzhou.qin@airbus.com
#-------------------------------------------------------------

#' If you want to change the defaut web browser
#' modify and run the following variable before running the app
#' 
#' ###### Browser parameter #######
# browser.path = file.path("C:/Users/QIN_XUZ/AppData/Local/Google/Chrome/Application/chrome.exe") 
# options(browser = browser.path)
# shiny::runApp(launch.browser=TRUE)


###################################################
# _____________load environment_______________ ####

#### PACKAGES ####
list.of.packages <- c("ggplot2", "maps", 'rgeos', 'maptools', 'geosphere', 'ggmap','RColorBrewer',
                      "zoo", 'lubridate', "dplyr", "rworldmap",
                      'data.table', 'ggthemes','xts','gridExtra', 'reshape2', 'devtools','DT', 'shinydashboard',
                      'plotly', 'RMySQL','RODBC','googleVis', 'plyr', 'leaflet','htmltools', 'stringdist',
                      'visNetwork')

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

check.ROracle <- 'ROracle'  %in% installed.packages()[,'Package']
if(!check.ROracle){install.packages('Rpackages/ROracle_1.2-1.zip', repos = NULL, type="source")}



library(ROracle)
library(RODBC)
library(RMySQL)

library(googleVis)
library(zoo)
library(ggplot2)
library(plyr)

library(lubridate)
library(shinydashboard)
library(maps)
library(rgeos)
library(maptools)
library(geosphere)
library(ggmap)
library(dplyr)
library(rworldmap)

library(stringdist)
library(visNetwork)
library(leaflet)
library(htmltools)

library(gridExtra)
library(data.table)
library(ggthemes)
library(xts)
library(reshape2)
library(devtools)
library(igraph)
library(plotly)
library(DT)
library(RColorBrewer)
