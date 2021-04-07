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
      geom_col(fill = "dark green") +
      theme_minimal() +
      labs(
        y = "Mean CO2 Emissions
        (kg CO2/m^2/Year)",
        x = "Local Authority Area",
        title = "Mean CO2 Emissions per Current Floor Area of Homes",
        subtitle = "2012 - 2020"
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
      geom_col(fill = "dark green") +
      theme_minimal() +
      labs(
        y = "Mean Primary Energy",
        x = "Local Authority Area",
        title = "Mean Primary Energy of Homes",
        subtitle = "2012 - 2020"
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
      geom_col(fill = "dark green") +
      theme_minimal() +
      labs(
        y = "Mean Current Emissions",
        x = "Local Authority Area",
        title = "Mean Current Emissions of Homes",
        subtitle = "2012 - 2020"
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
            geom_line(fill = "dark green") +
        geom_point() +
            theme_minimal() +
            labs(
                y = "Mean CO2 Emissions (kg CO2/m^2/Year)",
                x = "Year",
                title = "Mean CO2 Emissions per Current Floor Area of Homes",
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
        geom_line(fill = "dark green") +
        geom_point() +
        theme_minimal() +
        labs(
          y = "Mean Primary Energy",
          x = "Year",
          title = "Mean Primary Energy of Homes",
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
        geom_line(fill = "dark green") +
        geom_point() +
        theme_minimal() +
        labs(
          y = "Mean Current Emissions",
          x = "Year",
          title = "Mean Current Emissions of Homes",
          subtitle = "2012 - 2020"
        ) +
        theme(axis.text.x = element_text(angle=45,hjust=1)) 
      
    })
    
    
}
