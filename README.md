# SQL-Project
Este proyecto realiza un análisis de los datos extraídos de la base de datos facilitada. El objetivo del proyecto es analizar y comprender a fondo la estructura de la base de datos y poder sacar insights de ésta, ya que el proyecto contempla desde la limpieza de datos hasta las consultas con la intención de explorar cualitativa como cuantitativamente el modelo de datos.  
## Instalación y requisitos: 
Este proyecto usa Mypostgres y DBeaver como gestor de base de datos. 

## Análisis llevados a cabo- Resultados
Estructura, transformación y limpieza de datos: 
La creación de la base de datos y del esquema, el esquema generado es el siguiente. Contempla varios datos con varias tablas unidas por primary y foreign  keys para explorar diversas áreas del negocio del alquiler de películas, desde  características de las películas, su clasificación o información específica de la tienda y el staff que trabaja en ellas.  
 
Una gran parte de las consultas que implican nombre y apellido en columnas separadas, ya que para una mayor facilidad y entendimiento, se ha usado la función concat() para devolver en una sola columna el nombre completo de los actores y clientes. También se han usado funciones como extract() para extraer el mes o día de las fechas. 
Análisis de medidas de tendencia central. 
El total de beneficios de la empresa es de **67,416.51€**. 

### Análisis de medidas de tendencia central.
•	AVG 4.201

•	STTDEV 2.363. Valores alejados de la media, sugiere que están muy alejados de los 4.21€ de promedio. 

•	VAR 5.585, encontramos un valor alto, lo cual indica que los precios que se presentan para el alquiler de películas son muy diversos, se ecuentan dispersos, no son valores cercanos a la media (4.21). 

La varianza del coste de remplazo es de 36.62, una varianza muy alta. 
El promedio de la duración de las películas es de 115,27 minutos. Encontramos también que la película con mayor duración es de 185 minutos y la de menor duración es de 46, es importante destacar que hay 954 películas con una duración inferior a 180 minutos y únicamente 39 con una duración superior. 
El promedio de duración de las películas según la clasificación de la tabla film va desde 111.051  hasta 120.44, de la siguiente manera: 
•	G-111.051

•	PG-112.005

•	R-118,662

•	PG-13- 120.444

•	NC-17 - 113.229

La media de duración del alquiler de las películas es de 4.98 días, aunque es importante destacar que hay sólo el 5% -894-de los alquileres se han realizado por el máximo de tiempo, 9 días.

## Creación de tablas y agrupación de valores para conocer medidas y filtrados.  

### Actores
La media de participación de los actores en películas es de 27,31, el actor en el que menos películas ha participado es en 14 películas, mientras que el actor en el que más películas ha participado es en 42. Sólo 2 actores participado en más de 40 películas, en este caso, sólo son 2, el actor con ID 107 y 102. Al ser 14 el menor número de películas en el que un actor o actriz ha actuado, también podemos conocer el número de actores o actrices que no han participado en ninguna película, 0. 
### Películas y categorías
Las películas se dividen en 16 categorías (desde Sci-Fi hasta documental), que a su vez tienen una subclasificación según el contenido de la película, donde se especifica si el contenido es o no apto para menores, si existe o no contenido sensible, etc. 
Las películas tienen 6 idiomas: italiano, inglés, japonés, chino-mandarín, francés y alemán. No existe ninguna película cuyo idioma coincida con su idioma original.  
Las categorías de películas se ordenan de la siguiente manera respecto al total de alquileres. Esto nos ayuda a conocer qué categorías tienen más extirto entre los clientes -Sports y animation- y las que menos -Music y travel- 
Sports	1179
Animation	1166
Action	1112
Sci-Fi	1101
Family	1096
Drama	1060
Documentary	1050
Foreign	1033
Games	969
Children	945
Comedy	941
New	940
Classics	939
Horror	846
Travel	837
Music	830

### Meses, días e ingresos 
El día con mayor número de alquiler de películas fue el 31/7/2005 con 679 alquileres en un único día mientras que el que día con menor número de alquileres es el 24 de Mayo del 2005 con únicamente 12 películas alquiladas, números que tienen sentido ya que el mes con mayor número de alquileres son Julio (6709), mientras que los meses con menor número de alquileres son Febrero con 182 alquileres y Mayo con 1156, lo que supone el 1 y el 7% del total respectivamente 
### Clientes y actividad
Los 5 clientes que han tenido mayores gastos son KARL SEAL (221,55€), ELEANOR HUNT (216,54€); CLARA SHAW (195,58€); RHONDA KENNEDY (194.61€); MARION SNYDER (194,61€). En línea con lo mencionado anteriormente, la persona con mayor número de alquileres ha sido ELEANOR HUNT (46), que es la segunda persona con mayor gasto. Esto indica que la persona que mayores gastos tiene, Karl Seal (45) ha alquilado películas con mayor precio que Eleanor. 
## Conclusiones.
 Gracias al análisis llevado a cabo he en tendido no sólo la estructura general de los datos, sino también sacar métricas clave para el análisis del negocio, como el total de beneficios, los clientes con mayor contribución o el máximo de tiempo de alquiler de una película y cuánta variabilidad hay con la media de tiempo de alquiler. Gracias a este informe podemos también anticipar oportunidades de mejora para aumentar la rentabilidad y, con ello, mejorar la experiencia del cliente. 

_‘Sports’_ y _‘Animation’_ las categorías con mayor número de alquileres, sería conveniente invertir una mayor cantidad de dinero en comprar más películas de estas categorías para aumentar la oferta y, con ello, aumentar los beneficios. De manera contraria, la inversión en películas de categorías _'Tusic' y _'Travel'_ debería de ser inferior, puesto que son las películas menos alquiladas y una inversión grande en este tipo de películas podría suponer pérdidas.  
Como se ha mencionado anteriormente, no existen películas cuyo idioma coincida con el idioma original, por tanto, podría ser un campo interesante al que abrirse, ya que una gran cantidad de personas disfrutan de ver las películas en su idioma original. 

Se propone crear un sistema de recompensas orientado a premiar a los clientes más activos o con mayor gasto acumulado. Este tipo de programa no solo retiene a los mejores clientes, sino que además incentiva a otros a alcanzar esos beneficios.

Sería conveniente analizar también analizar el importe medio por cliente y segmentar por grupos para poder implementar también un programa de promociones que se adecue a cada uno de éstos y poder incrementar las ventas también en los grupos que menores ingresos han generado para la compañía.  

Sería conveniente también explorar más en detalle la estacionalidad de los alquileres, ya que parece haber registros centrados en 5 meses de los 12 existentes, lo que invita a revisar si hubo problemas en la carga de datos o si realmente existe una estacionalidad muy intensa. 
Este ejercicio resulta útil para la toma de decisiones a nivel estratégico y comercial, y, con ello potenciar el crecimiento del negocio, mejorando a su vez la experiencia del usuario.
