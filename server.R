library(stringdist)
library(shiny)
library(leaflet)

shinyServer(function(input, output) {
  
  voie <- reactive({
    input$recherche
    isolate({
      suppraccent(suppmotscourants(toupper(input$rue)))
    })  
  })

  ville <- reactive({
    input$recherche
    isolate({
      suppraccent(suppmotscourants(toupper(input$ville)))
    }) 
  })
    
  distance <- reactive(
    stringdist(ville(),voie_unique$ville)+stringdist(voie(),voie_unique$voie)
  )
  
  code <- reactive(
    voie_unique$code[which.min(distance())]
  )
  
  numero <- reactive({
    input$recherche
    isolate({
    code <- as.character(code())
    selection <- adresses_lgt$V2[substr(adresses_lgt$V1,1,nchar(code))==code]
    selection[which.min(abs(as.numeric(selection)-as.numeric(input$numero)))]
    })
  })
  
  correspondance <- reactive({
    input$recherche
    isolate({
      code <- as.character(code())
      (vi_vo==code) & (adresses_lgt$V2==numero())
    })
  })
  
  coordonnee <- reactive({
    input$recherche
    isolate({
      code <- as.character(code())
      adresse <- adresses_lgt[(vi_vo==code) & (adresses_lgt$V2==numero()),]
      unlist(adresse)[3:4]
    })
  })
  
  output$map <- renderLeaflet({
    coor <- coordonnee()
    leaflet() %>% setView(lng = as.numeric(coor[2]),lat = as.numeric(coor[1]),zoom = 15) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addMarkers(coor[2],coor[1])
  })
  
  output$adresse <- renderText({
    input$recherche
    isolate({
      code=code()
      i <- match(code,voie_unique$code)
      paste(numero(),voie_unique$voie[i],",",voie_unique$ville[i])
    })  
  })

})


