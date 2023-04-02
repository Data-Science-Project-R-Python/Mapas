# Mapas

## Índice 

* [1. Preámbulo](#1-preámbulo)
* [2. Descripción del proyecto](#2-definición-del-producto)
* [2. Desarrollo del proyecto](#2-desarrollo-del-proyecto)

***

## 1. Preámbulo

Para el desarrollo de un país es necesario contar con recursos humanos de diferentes áreas que puedan sostener los diferentes servicios. Un generador importante de recursos humanos son la universidades donde anualmente ingresan una gran cantidad de estudiantes a nivel nacional. La información sobre la cantidad de estudiantes que ingresan anualmente a las universidades licenciadas es recolectado por la SUNEDU y almacenado en la plataforma TUNI.PE

## 2. Definición del producto 

Para el siguiente proyecto utilizamos la base de datos de los ingresantes del 2022, así mismo utilizamos el datasets "map_DEP" incluida en el paquete "mapsPERU", que incluyen los siguientes datos:
 
 - COD_DEPARTAMENTO: Código del departamento
 - DEPARTAMENTO: Nombre del departamento
 - coords_x: Longitud del centroide del departamento
 - coords_y: Latitud del centroide del departamento
 - geometry: MULTIPOLYGON Objeto geométrico

 ## 3. Desarrollo del proyecto

  ![Mapa de la regiones del Perú](/img/mapa-general.png) 

  ![Mapa interactiva base](/img/base_mapa.png)

  ![Resultado final](/img/mapa_final.png)  

  Respecto al diseño final las regiones están agrupada en macroregiones: 

  - Norte: Tumbes, Piura, Lambayeque, Cajamarca, La Libertad
  - Centro: Ancash, Junín, Cerro de Pasco, Huánuco, Huancavelica, Ayacucho, Ica 
  - Sur: Arequipa, Moquegua, Tacna, Cusco, Madre de Dios, Apurímac.
  - Lima y Callao 