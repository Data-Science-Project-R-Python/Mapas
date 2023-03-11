# 1. importar librerias de python
import re #paquete regulares
import plotly.express as px #paquete para graficar
import pandas as pd #paquete de analisis de datos
import numpy as np #paquete de analisis de datos 2
import psycopg #paquete para integracion con postgresql

# 2. Entrada de datos
df = pd.read_csv('~/Documents/02_proj/01_dataprojects/ds_project/kaggle/master.csv')

#3. Limpieza basica
df = df.drop(['country_year'], axis=1)

# 4. Salida de archivo peruano
peru_csv = df.sort_values(by=['year'], ascending=True).loc[(df['country']=='Peru')]

print('Making file with the following data\n...\n...', df.sort_values(by=['year'], ascending=True).loc[(df['country']=='Peru')])

peru_csv = peru_csv.to_csv('peru_suicidio.csv', index = False)
print('Felicidades! Deberia encontrar su archivo en la carpeta')
