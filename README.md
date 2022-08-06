# Proyecto Analisis Mercado E-Commerce
Proyecto de Analisis de Mercado que genera cuadros y metricas estadisticas acompañados de algunos indicadores de Gestion; 
informacion de mucha relevancia para las empresas comerciales de ventas y distribucion de productos mediante canales ECommerce.

Cabe resaltar que la solucion le brinda a las areas de analisis de datos y gerencias lo siguiente: 
1. prediccion de costos de distribucion
2. Segmentacion de clientes por volumen de compras y segmentacion de clientes por ubicaciones geograficas
Estos ultimos puntos se han desarrollado aplicando modelos de Regresion Lineal y algortimos de Machine Learning

Tecnologia Utilizada
1. Se ha utilizado la plataforma de AWS Cloud; especificamente con los siguientes servicios:
* S3          -> Generacion Buickets o repositorios de datos
* GlueCrawler -> Determina las fuentes de informacion a ser normalizadas
* Glue Data Catalog -> Identificacion de cada uno de las fuentes de informacion
* SageMaker   -> Utilizado para los servicios de Machine Learnig - ML

La solucion de ML contenpla 2 caminos el uso del servicio SageMaker como el uso de Python y librerias Scikitlearn que nos brinda los modelos utilizados

Desarrollo:
1. Se utizo Steamlit como herramienta de desarrollo web
2. Heroku como herramienta de despliegue en la web del producto final
3. Cada uno de estos puntos centralizados y controlados utilizando el GitHub


