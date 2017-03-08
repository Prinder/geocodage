
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "géocodage"),
  dashboardSidebar(disable = T),
  dashboardBody(
    fluidPage(
      column(width=6,
      numericInput("numero","Numero",min=1,max=10000,value = 1),
      textInput("rue","Nom de la voie",value = ""),
      textInput("ville","Nom de la ville",value = ""),
      actionButton("recherche","Recherchez !")),
      column(width=6,textOutput("adresse")),
      hr(),
      leafletOutput("map")
    )
  )
)
