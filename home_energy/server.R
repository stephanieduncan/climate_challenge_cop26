server <- function(input, output) {
    
    ##################First tab content
    home_energy_output <- reactive({
        home_energy %>% 
            filter(ca_name == input$ca_name,
                   year == input$year)
        
    })
    
    output$home_energy_output <- renderPlot({
    
        home_energy_output() %>%
            group_by(ca_name, year) %>% 
            summarise(mean_co2_pfa = round(mean(co2_emissions_per_floor_area), digits = 2),
                      mean_primary_energy = round(mean(primary_energy), digits = 2),
                      mean_current_emissions = round(mean(current_emissions_t_co2_yr), digits = 2)) %>% 
            ggplot() +
            aes(x = mean_co2_pfa, y = ca_name) +
            geom_col(fill = "dark green") +
            theme_minimal() +
            labs(
                y = "Council Area",
                x = "Mean CO2 Emissions Per Current Floor Area (kg CO2/m^2/Year)",
                title = "Mean CO2 Emissions Current Floor Area of Homes by Council Area",
                subtitle = "2012 - 2020"
            ) +
            theme(axis.text.x = element_text(angle=45,hjust=1)) 
        
    })
    
    
}
