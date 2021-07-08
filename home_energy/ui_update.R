

source("global.R")

ui <- dashboardPage(
  
  dashboardHeader(title = "Home Energy"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Scotland Overall", tabName = "scotland_overall"),
      menuItem("Overview", tabName = "scotland_overview"),
      menuItem("Home Energy by Area", tabName = "home_energy_area"),
      menuItem("Map of Scotland", tabName = "map"),
      menuItem("About", tabName = "about")
    )
  ),
  
  ## Body content
  dashboardBody(
    shinyDashboardThemes(theme = "poor_mans_flatly"),
    tabItems(
      
      #overvall
      tabItem(tabName = "scotland_overall",
               h2("Average Household Energy"),
               
               fluidRow(
                 box(
                   title = "Average Household Energy Consumption in Scotland",
                   status = "primary",
                   solidHeader = TRUE,
                   plotOutput("scotland_energy_overall", height = 400)
                 )
               )
               ),
      
      # overview of Scotland
      tabItem(tabName = "scotland_overview",
              h2("Home Energy in Scotland"),
              
              fluidRow(
                box(width = 12,
                    background = "light-blue",
                    column(width = 3, 
                           div(style="display:inline-block", selectInput(inputId = "year",
                                       label = "Year",
                                       choices = sort(unique(home_energy$year)),
                                       selected = "2020")
                           ),
                           div(style="display:inline-block", selectInput(inputId = "quarter",
                                       label = "Quarter",
                                       choices = sort(unique(home_energy$quarter)),
                                       selected = "1")
                           )  
                    )
                )
              ),
              
              fluidRow(
                
                box(
                  title = "CO2 Emissions in homes per Current Floor Area",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("co2_pfa_overview", height = 250)
                ),
                
                box(
                  title = "Primary Energy",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("primary_overview", height = 250)
                ),
                
                box(
                  title = "Current Emissions",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("current_overview", height = 250)
                ),
                
              )
              
              
              ),
      
      
      
      # home energy content
      tabItem(tabName = "home_energy_area",
              h2("Temporal"),
              
              fluidRow(
                box(width = 12,
                    background = "light-blue",
                    column(width = 6,
                           selectInput(inputId = "postcode",
                                       label = "Postcode",
                                       choices = sort(unique(home_energy$postcode)),
                                       selected = "AB10"
                           )
                    )
              )
              ),
              
              fluidRow(
                
                box(
                  title = "Home Energy by Area", 
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
          title = "Current Emissions by Area", 
          solidHeader = TRUE,
          status = "primary",
          plotOutput("current_emissions_output", height = 250)
        )
              )
    ), 
    
    
    #map content
    
    tabItem(tabName = "map",
            h2("Map of Scotland"),
            fluidRow(
             
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

