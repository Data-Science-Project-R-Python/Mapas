# 1. importar librerias de python
import re #paquete regulares
import plotly.express as px #paquete para graficar
import pandas as pd #paquete de analisis de datos
import numpy as np #paquete de analisis de datos 2
import psycopg #paquete para integracion con postgresql

# 2. Declarar variables y hacer conexiones necesarias
cleancountry = str()

# 3. Entrada de datos
df = pd.read_csv('master.csv')
url = 'https://en.wikipedia.org/wiki/Latin_America'
latamdf = pd.read_html(url)[1] # El numero entre barras indica el indice de la tabla que buscamos extraer

# Programa
# 1. Visualizar un poco de la informacion
#print(latamdf.head(1))
#print(df.head(1))
# 2. Modificar los nombres de columnas y errores de tipeo
latamdf = latamdf.rename(columns={'Country/Territory':'country', 'Capital(s)':'capital', 'Population.mw-parser-output .nobold{font-weight:normal}(2021)[2][3]':'population', 'Area(km2)[39]':'area', 'Density(people/km2)':'density', 'Subregion': 'subregion'})

# 4. Revisar datos perdidos
# print(df.isnull().sum())
# print(df.isnull().sum())
# 5. Eliminar columna con perdidas severas y columnas que no utilizaremos
df = df.drop(['hdi_per_year', 'country_year'], axis=1)
latamdf = latamdf.drop(['Flag','Arms','Name(s) in official language(s)', 'Time(s) zone(s)'], axis=1)
#print(latamdf.head(1))
#print(df.head(1))
# 6. Agrupar Latinoamerica
# Para hacer modificaciones con pandas debemos convertir los dataframes en series, 
latamnom = latamdf['country'].squeeze()
# Luego en serie podemos trabajar con los strings, se utilizan las funciones base de python con el sufijo str.
latamnom = latamnom.str.removesuffix('*')
latamdf['country'] = latamnom

# Can we agrupar latam en un nuevo df?... Tomo un tiempo
sui_latam = df[df['country'].isin(latamdf['country'])]

# Contar el numero de casos que tiene cada pais latino
print(sui_latam['country'].value_counts())

# Analizar el Peru de forma aislada segun las muestras por año
print(sui_latam.sort_values(by=['year','age'], ascending=True).loc[(sui_latam['country']=='Peru')])

# Nos damos cuenta que solo tenemos datos del 2017 y 2018. Buscamos en Internet si podemos completar la informacion

# Salida
#print(latamdf['country'])



