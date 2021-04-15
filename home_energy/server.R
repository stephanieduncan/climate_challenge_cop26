server <- function(input, output) {
  
  ##################First tab content
  overview_output <- reactive({
    home_energy %>% 
      filter(year == input$year)
    
  })
  
  output$co2_pfa_overview <- renderPlot({
    
    overview_output() %>%
      group_by(ca_name, year) %>% 
      summarise(mean_co2_pfa = round(mean(co2_emissions_per_floor_area), digits = 2),
                mean_primary_energy = round(mean(primary_energy), digits = 2),
                mean_current_emissions = round(mean(current_emissions_t_co2_yr), digits = 2)) %>% 
      ggplot() +
      aes(x = ca_name, y = mean_co2_pfa) +
      geom_col(fill = "#3c8dbc") +
      theme_minimal() +
      labs(
        y = "Emissions per Current Floor Area
        (kg CO2e/m2/Year)",
        x = "Local Authority Area"
        #title = "Mean CO2 Emissions per Current Floor Area of Homes"
      ) +
      theme(axis.text.x = element_text(angle=45,hjust=1)) 
    
  })
  
  output$primary_overview <- renderPlot({
    
    overview_output() %>%
      group_by(ca_name, year) %>% 
      summarise(mean_co2_pfa = round(mean(co2_emissions_per_floor_area), digits = 2),
                mean_primary_energy = round(mean(primary_energy), digits = 2),
                mean_current_emissions = round(mean(current_emissions_t_co2_yr), digits = 2)) %>% 
      ggplot() +
      aes(x = ca_name, y = mean_primary_energy) +
      geom_col(fill = "#3c8dbc") +
      theme_minimal() +
      labs(
        y = "Average Primary Energy
        (kWh/m2/year)",
        x = "Local Authority Area"
        #title = "Mean Primary Energy of Homes"
      ) +
      theme(axis.text.x = element_text(angle=45,hjust=1)) 
    
  })
  
  
  output$current_overview <- renderPlot({
    
    overview_output() %>%
      group_by(ca_name, year) %>% 
      summarise(mean_co2_pfa = round(mean(co2_emissions_per_floor_area), digits = 2),
                mean_primary_energy = round(mean(primary_energy), digits = 2),
                mean_current_emissions = round(mean(current_emissions_t_co2_yr), digits = 2)) %>% 
      ggplot() +
      aes(x = ca_name, y = mean_current_emissions) +
      geom_col(fill = "#3c8dbc") +
      theme_minimal() +
      labs(
        y = "Average Current Emissions
        (Tonnes per Year)",
        x = "Local Authority Area"
        #title = "Mean Current Emissions of Homes"
      ) +
      theme(axis.text.x = element_text(angle=45,hjust=1)) 
    
  })
    
    ##################Second tab content
    home_energy_output <- reactive({
        home_energy %>% 
            filter(ca_name == input$ca_name)
        
    })
    
    output$home_energy_output <- renderPlot({
    
        home_energy_output() %>%
            group_by(ca_name, year) %>% 
            summarise(mean_co2_pfa = round(mean(co2_emissions_per_floor_area), digits = 2),
                      mean_primary_energy = round(mean(primary_energy), digits = 2),
                      mean_current_emissions = round(mean(current_emissions_t_co2_yr), digits = 2)) %>% 
            ggplot() +
            aes(x = year, y = mean_co2_pfa) +
            geom_line(color = "#3c8dbc") +
        geom_point(color = "#3c8dbc") +
            theme_minimal() +
            labs(
                y = "Emissions per Current Floor Area
                (kg CO2/m^2/Year)",
                x = "Year",
                #title = "Mean CO2 Emissions per Current Floor Area of Homes",
                subtitle = "2012 - 2020"
            ) +
            theme(axis.text.x = element_text(angle=45,hjust=1)) 
        
    })
    
    output$primary_energy_output <- renderPlot({
      
      home_energy_output() %>%
        group_by(ca_name, year) %>% 
        summarise(mean_co2_pfa = round(mean(co2_emissions_per_floor_area), digits = 2),
                  mean_primary_energy = round(mean(primary_energy), digits = 2),
                  mean_current_emissions = round(mean(current_emissions_t_co2_yr), digits = 2)) %>% 
        ggplot() +
        aes(x = year, y = mean_primary_energy) +
        geom_line(color = "#3c8dbc") +
        geom_point(color = "#3c8dbc") +
        theme_minimal() +
        labs(
          y = "Average Primary Energy
          (kWh/m2/year)",
          x = "Year",
          #title = "Mean Primary Energy of Homes",
          subtitle = "2012 - 2020"
        ) +
        theme(axis.text.x = element_text(angle=45,hjust=1)) 
      
    })
    
    
    output$current_emissions_output <- renderPlot({
      
      home_energy_output() %>%
        group_by(ca_name, year) %>% 
        summarise(mean_co2_pfa = round(mean(co2_emissions_per_floor_area), digits = 2),
                  mean_primary_energy = round(mean(primary_energy), digits = 2),
                  mean_current_emissions = round(mean(current_emissions_t_co2_yr), digits = 2)) %>% 
        ggplot() +
        aes(x = year, y = mean_current_emissions) +
        geom_line(color = "#3c8dbc") +
        geom_point(color = "#3c8dbc") +
        theme_minimal() +
        labs(
          y = "Average Current Emissions
          (Tonnes per Year)",
          x = "Year",
          #title = "Mean Current Emissions of Homes",
          subtitle = "2012 - 2020"
        ) +
        theme(axis.text.x = element_text(angle=45,hjust=1)) 
      
    })
    
    output$map <- renderLeaflet({
      
      leaflet(la_scotland_home_energy) %>%
        #adding base tiles
        addProviderTiles("CartoDB.Positron") %>%
        #setting bounds of map
        fitBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>%
        setView(lat = 56, lng = -4.3, zoom = 6) %>% 
        #layer for CO2 emissions pfa
        addPolygons(
          color = "grey", weight = 1,
          fillColor = ~ pal_co2_emissions(mean_co2), 
          fillOpacity = 1,
          opacity = 0.8,
          label = ~ lapply(leaflet_labels, HTML),
          labelOptions = labelOptions(
            style = list("font-weight" = "normal", padding = "3px 8px"),
            textsize = "18px",
            direction = "auto"
          ),
          highlightOptions = highlightOptions(
            color = "#3c8dbc",
            weight = 1,
            bringToFront = TRUE
          ),
          group = "CO2 Emissions per Current Floor Area"
        ) %>%
        #layer for primary energy
        addPolygons(
          color = "grey", weight = 1,
          fillColor = ~ pal_primary_energy(mean_primary), 
          fillOpacity = 1,
          opacity = 0.8,
          label = ~ lapply(leaflet_labels, HTML),
          labelOptions = labelOptions(
            style = list("font-weight" = "normal", padding = "3px 8px"),
            textsize = "18px",
            direction = "auto"
          ),
          highlightOptions = highlightOptions(
            color = "#3c8dbc",
            weight = 1,
            bringToFront = TRUE
          ),
          group = "Average Primary Energy"
        ) %>%
        #layer for current emissions
        addPolygons(
          color = "grey", weight = 1,
          fillColor = ~ pal_current_emissions(mean_current_emissions_all), 
          fillOpacity = 1,
          opacity = 0.8,
          label = ~ lapply(leaflet_labels, HTML),
          labelOptions = labelOptions(
            style = list("font-weight" = "normal", padding = "3px 8px"),
            textsize = "18px",
            direction = "auto"
          ),
          highlightOptions = highlightOptions(
            color = "#3c8dbc",
            weight = 1,
            bringToFront = TRUE
          ),
          group = "Average Current Emissions"
        ) %>%
        #adding legend for CO2 emissions pfa
        addLegend(
          pal = pal_co2_emissions, 
          values = ~mean_co2, 
          opacity = 1,
          title = "CO2 Emissions per Current Floor Area", 
          position = "bottomleft",
          group = "Average CO2 Emissions"
        ) %>%
        #adding legend for primary energy 
        addLegend(
          pal = pal_primary_energy, 
          values = ~mean_primary, 
          opacity = 1,
          title = "Average Primary Energy", 
          position = "bottomright",
          group = "Average Primary Energy"
        )  %>%
        #adding legend for current emissions 
        addLegend(
          pal = pal_current_emissions, 
          values = ~mean_current_emissions_all, 
          opacity = 1,
          title = "Average Current Emissions", 
          position = "bottomright",
          group = "Average Current Emissions"
        )  %>%
        #adding button for user to choose which layer to look at on map
        addLayersControl(
          position = c("bottomleft"),
          baseGroups = c("Average CO2 Emissions
                         per Current Floor Area", "Average Primary Energy", "Average Current Emissions"),
          options = layersControlOptions(collapsed = FALSE)
        ) 
      
    })
    
}
