

source("global.R")

ui <- dashboardPage(
  
  dashboardHeader(title = "Home Energy"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "scotland_overview"),
      menuItem("Temporal", tabName = "home_energy_area"),
      menuItem("Home Energy in Scotland", tabName = "map"),
      menuItem("About", tabName = "about")
    )
  ),
  
  ## Body content
  dashboardBody(
    shinyDashboardThemes(theme = "poor_mans_flatly"),
    tabItems(
      
      
      # overview of Scotland
      tabItem(tabName = "scotland_overview",
              h2("An Overview of Home Energy in Scotland by Year"),
              
              fluidRow(
                box(width = 12,
                    background = "light-blue",
                    column(width = 6, 
                           selectInput(inputId = "year",
                                       label = "Year",
                                       choices = sort(unique(home_energy$year)),
                                       selected = "2020"
                           )
                    )
                )
              ),
              
              fluidRow(
                
                box(
                  title = "Average CO2 Emissions per Current Floor Area",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("co2_pfa_overview", height = 250)
                ),
                
                box(
                  title = "Average Primary Energy",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("primary_overview", height = 250)
                ),
                
                box(
                  title = "Average Current CO2 Emissions",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("current_overview", height = 250)
                ),
                
              )
              
              
              ),
      
      
      
      # home energy content
      tabItem(tabName = "home_energy_area",
              h2("Home Energy in Scotland over Time by Area"),
              
              fluidRow(
                box(width = 12,
                    background = "light-blue",
                    column(width = 6, 
                           selectInput(inputId = "ca_name",
                                       label = "Area",
                                       choices = sort(unique(home_energy$ca_name)),
                                       selected = "Aberdeen City"
                           )
                    )
              )
              ),
              
              fluidRow(
                
                box(
                  title = "Average CO2 Emissions per Current Floor Area", 
                  solidHeader = TRUE,
                  status = "primary",
                  plotOutput("home_energy_output", height = 250)
              ),
                
                box(
                  title = "Primary Energy by Area", 
                  solidHeader = TRUE,
                  status = "primary",
                  plotOutput("primary_energy_output", height = 250)
                ),
        
        box(
          title = "Average Current CO2 Emissions", 
          solidHeader = TRUE,
          status = "primary",
          plotOutput("current_emissions_output", height = 250)
        )
              )
    ), 
    
    
    #map content
    
    tabItem(tabName = "map",
            h2("Home Energy in Scotland"),
            fluidRow(
              tags$head(tags$style(css)),
              leafletOutput("map", height = 500),
              )
            ),
      
      
      
      # About tab content
      tabItem(tabName = "about",
              h1("About"),
              h3("Author:", tags$a(href = "https://www.linkedin.com/in/stephanie-mpd/",
                                   "Stephanie Duncan")),
              "This interactive dashboard gives insights and trends on home energy in Scotland between 2012 - 2020.",
              br(),
              br(),
              tags$strong("Home Energy Definitions"),
              tags$li("Primary Energy - the amount of energy required at source, before conversion and transmission, to meet the calculated energy demand of the dwelling (Units: kWh/m2/year)."),
              tags$li("Current CO2 Emissions - The total annual emissions reduction for the building based upon the calculated energy demand for heating, cooling, lighting and ventilating the building. (Units: tonnes per year)."),
              tags$li("CO2 Emissions per Current Floor Area - Annual CO2 equivalent emissions per square metre of floor area (units: kg.CO2e/m2/yr)"),
              br(),
              "The code I wrote to produce this dashboard can be found on my ", tags$a(href = "https://github.com/stephanieduncan/climate_challenge_cop26/", "Github Repository"),
              br(),
              "The data used to carry out analysis for this dashboard is open source and can be found in the links below.",
              br(),
              br(),
              fluidRow(
                box(title = "Data Sources", solidHeader = TRUE, status = "primary",
                    h5(strong("Statistics.gov.scot")),
                    
                    tags$a(href="https://statistics.gov.scot/data/domestic-energy-performance-certificates", 
                           "Home Energy Performance Certificates Data"),
                    br(),
                    tags$a(href="https://www.opendata.nhs.scot/es_AR/dataset/geography-codes-and-labels/resource/e92d19d4-ced7-40c8-b628-e28e4528fc41", 
                           "Geography Local Authority Area Labels Lookup")
                )
              )
      )
    )
  )
)
