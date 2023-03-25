

#install.packages("mapsPERU")

library(plotly)
library(mapsPERU)
library(ggplot2)
library(tidyverse)
library(ggrepel)
library(dplyr) #para utilizar mutate
library(readr)
library(haven)

library(leaflet)
library(leaflet.extras)
library(rworldxtra)
library(raster)
library(sf)
library(tidyverse)

#Extraemos las coordenadas del paquete mapsPERU distrito
df <- map_DIST

#Cargamos nuestra base de datos
cap1200 <- haven::read_sav("20_Cap1200.sav")

#Visualizamos la base de datos
View(df)
View(cap1200)

#Notamos que las columnas DEPARTAMENTO PROVINCIA DISTRITO 
#están en minúsculas y con tilde mientras que la base de 
#datos cap1200 aparecen en mayúscula y sin tilde. Tenemos que homogenizarlos.



#convertimos todas las variables que tenga caracteres 
#de minúscula a mayúsculas.

df <- mutate_if(df, is.character, toupper)

#Quitamos las tildes de las mayúsculas

df$DEPARTAMENTO <- chartr('Á,É,Í,Ó,Ú','A,E,I,O,U', df$DEPARTAMENTO)
df$PROVINCIA <- chartr('Á,É,Í,Ó,Ú','A,E,I,O,U', df$PROVINCIA)
df$DISTRITO <- chartr('Á,É,Í,Ó,Ú','A,E,I,O,U', df$DISTRITO)

#Visualizamos el nombre de las variables
names(cap1200)

#Renombramos la variable NOMBREDI de la base cap1200
cap1200 <- rename(cap1200, DISTRITO = NOMBREDI)


#Renombramos la categorias del tamaño de unidades agropecurias

Cod_tipo <- c(`1`="Pequeña y mediana UA",
              `2`="Grande UA")


cap1200$CODIGO <- as.factor(cap1200$CODIGO)

names(cap1200)

cap1200 <- cap1200 %>% 
  mutate(CODIGO = recode_factor(CODIGO,!!!Cod_tipo))


#Integramos ambas bases de datos a través de DISTRITO
ENA2019 <- left_join(df, cap1200, by = "DISTRITO")

names(ENA2019)


#Creamos la base del mapa
leaflet() %>% addTiles()


leaflet() %>% addTiles() %>% 
  addCircles(data = ENA2019, lat = ~coords_y, lng = ~coords_x)


## para generar colores
#número de tipos de productores
Number_tpp <- ENA2019$CODIGO %>% unique() %>% 
  length()

#Nombre de especies
tpp_Names <- ENA2019$CODIGO %>% unique()


## Los colores de los tamaños de las unidades agropecuarias serán:
Colores <- c('#e41a1c', '#377eb8', '#4daf4a')

table(ENA2019$CODIGO)

#Vincular la paleta de colores con los tipos de nombres
pal <- colorFactor(Colores, domain = tpp_Names)



##Mapa con colores. fillopacity es la transparencia
leaflet() %>% addTiles() %>% addCircles(data = ENA2019, lat = ~coords_y, 
                                        lng = ~coords_x, color = ~pal(CODIGO), 
                                        fillOpacity = 0.5)

#labels
p <- leaflet() %>% addTiles() %>% addCircles(data = ENA2019, lat = ~coords_y, 
                                        lng = ~coords_x, color = ~pal(CODIGO), 
                                        fillOpacity = 0.5, label = ~CODIGO, 
                                        group = "Codigo")

## Generar una leyenda
p <- p %>% addLegend(data = ENA2019, "bottomright", pal = pal, 
                     values = ~CODIGO, title = "Tipos de productores", 
                     opacity = 0.8, group = "Leyenda")
p

## Seleccionar capas
p <- p %>% addLayersControl(overlayGroups = c("Codigo", "Leyenda"), 
                            options = layersControlOptions(collapsed = F))
p






















