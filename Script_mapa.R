install.packages("mapsPERU")
install.packages("sf")
install.packages("mapview")
install.packages("ggrepel")
install.packages("plotly")
install.packages("leaflet")
install.packages("leaflet.extras")
install.packages("rworldxtra")
install.packages("raster")

library(plotly)
library(mapsPERU)
library(ggrepel)
library(ggplot2)
library(leaflet)
library(leaflet.extras)
library(sp)
library(rworldxtra)
library(raster)
library(sf)
library(tidyverse)

###############################################################
df <- map_DEP

df_1 <- mutate_if(df, is.character, toupper)
df_1$DEPARTAMENTO <- chartr('??,??,??,??,??','A,E,I,O,U', df_1$DEPARTAMENTO)

ggplot(df, aes(geometry=geometry)) +
  geom_sf(aes(fill=DEPARTAMENTO)) +
  geom_text(data = df, aes(coords_x, coords_y, group=NULL, label=DEPARTAMENTO), size=2.5)+
  labs(x="", y="")


#############################################################

dg <- st_read("BAS_LIM_DEPARTAMENTO.shp")
dk <- st_read("E_2023.shp")

##mapview::mapview(dg,legend = TRUE, labels=F)
##INFO https://r-spatial.github.io/mapview/articles/mapview_01-basics.html

dg <- dg %>% mutate(centroid = map(geometry, st_centroid), 
                    coords = map(centroid, st_coordinates), 
                    coords_x = map_dbl(coords,1), 
                    coords_y = map_dbl(coords, 2))


ingresantes2022 <- read_delim("ingresante_2022.csv", 
                              delim = "|", escape_double = FALSE, locale = locale(encoding = "ASCII"), 
                              trim_ws = TRUE)

#ingresantes2022 %>% 
#  select(DEPARTAMENTO_FILIAL) %>% 
#  count(DEPARTAMENTO_FILIAL) %>% 
#  print(n = Inf)

library(readr)

ingresantes <- readxl::read_excel("Ingresantes2022.xlsx")

mapa <- df_1 %>% 
  left_join(ingresantes)



#addAwesomeMarkers

leaflet() %>% addTiles() %>% 
  addCircles(data = df, lat = ~ coords_x, 
             lng = ~ coords_y)

leaflet() %>% addTiles() %>% 
  addAwesomeMarkers(data = mapa, lat = ~Latitud, 
             lng = ~Longitud)
  
#addCircleMarkers

#datamap <- left_join(df_1, ENA2019, by = "DISTRITO")

leaflet() %>% addTiles() %>% 
  addAwesomeMarkers(data = mapa, lat = ~coords_y, lng = ~coords_x)

Colores <- c('#e41a1c', '#377eb8', '#4daf4a', )
pal <- colorFactor(Colores, domain = REGIONES)

leaflet() %>% addTiles() %>% addCircles(data = mapa, lat = ~coords_y, 
                                        lng = ~coords_x, 
                                        fillOpacity = 0.5, label = ~INGRESANTES, 
                                        group = "Codigo")


p <- ggplot(mapa, aes(geometry=geometry)) +
  geom_sf(aes(fill=INGRESANTES)) +
  geom_text(data = mapa, aes(coords_x, coords_y, group=NULL, label=INGRESANTES), size=2.2)+
  labs(x="", y="")

ggplotly(p, width = 700, height = 700, tooltip = c("NOMBDEP"))


p <- ggplot(mapa) + 
  geom_sf(aes(fill = INGRESANTES)) +
  geom_text(data = mapa, aes(coords_x, coords_y, group=NULL ,label = NOMBDEP), size = 2.15)

ggplotly(p, width = 700, height = 700, tooltip = c("INGRESANTES"))





