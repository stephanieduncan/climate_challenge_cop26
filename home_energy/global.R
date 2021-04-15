library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(tidyverse)
library(sf)
library(here)
library(scales)
library(leaflet)
library(htmltools)
library(janitor)

#home energy statistics data merged with geo look up codes for local authority areas
home_energy <- read_csv(here("clean_data/home_energy.csv")) 


#Map
#Reading in shapefile
la_map_scotland <- st_read(here("clean_data/scotland_map_files/scotland_council_areas_map.shp")) %>%  
  clean_names()

energy_means <- home_energy %>% 
  group_by(ca, ca_name, year) %>% 
  summarise(mean_co2_pfa = round(mean(co2_emissions_per_floor_area), digits = 2),
            mean_primary_energy = round(mean(primary_energy), digits = 2),
            mean_current_emissions = round(mean(current_emissions_t_co2_yr), digits = 2))
energy_means

#Energy means all time
energy_means_all <- energy_means %>% 
  group_by(ca, ca_name) %>% 
  summarise(mean_co2 = round(mean(mean_co2_pfa), digits = 2),
            mean_primary = round(mean(mean_primary_energy), digits = 2),
            mean_current_emissions_all = round(mean(mean_current_emissions), digits = 2))


#joining home energy data with shapefile
la_scotland_home_energy <- la_map_scotland %>%
  left_join(energy_means_all, by = c("area_cod_1" = "ca"))

#Mean CO2 Emissions
# Set pallete for mean co2_emissions across households in Scotland
pal_co2_emissions <- colorNumeric(palette = "YlGnBu",
                                  domain = la_scotland_home_energy$mean_co2)

#Mean Primary Energy
# Set pallete for mean primary energy across households in Scotland
pal_primary_energy <- colorNumeric(palette = "OrRd",
                                  domain = la_scotland_home_energy$mean_primary)

#Mean Current Emissions
# Set pallete for mean current emissions across households in Scotland
pal_current_emissions <- colorNumeric(palette = "RdPu",
                                   domain = la_scotland_home_energy$mean_current_emissions_all)


#Set boundaries of Scotland
bbox <- st_bbox(la_scotland_home_energy) %>%
  as.vector()