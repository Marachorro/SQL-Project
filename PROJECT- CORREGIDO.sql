-- 1.	Crea el esquema de la BBDD.

--2.	Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
select title 
from film f 
where rating = 'R';


--3.	Encuentra los nombres de los actores que tengan n “actor_idˮ entre 30 y 40. 
select distinct A. actor_id, A.first_name, A.last_name
from actor a 
inner join  film_actor fa 
on A.actor_id = FA.actor_id
where A.actor_id between 30 and 40;

-- 4.	Obtén las películas cuyo idioma coincide con el idioma original. 
select title 
from film f 
inner join "language" l 
on l.language_id = F.language_id 
where L.language_id = F.original_language_id;

--5.	Ordena las películas por duración de forma ascendente.
select TITLE, length 
from film f 
order by  f.length asc;

--6.	Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

select first_name, last_name 
from actor a 
where last_name = 'Allen';

--7.	Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.

select rating, COUNT(title ) as RECUENTO
from film f 
group by f.rating; 

--8.	Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.
select title 
from film f 
where rating ='PG-13' or length > 180;

--9.	Encuentra la variabilidad de lo que costaría reemplazar las películas.
select round(variance(replacement_cost ),2)
from film f; -- 36.61

--10.	Encuentra la mayor y menor duración de una película de nuestra BBDD.

select MAX(length ) as MAYOR_DURACION, MIN(length ) as MENOR_DURACION
from film f;-- MAX 185 Y MIN 46

--11.	Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select amount
from rental r 
inner join payment p 
on p.rental_id = r.rental_id
order by  r.rental_date desc 
offset 1
limit 1; -- 0.99

--12.	Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC- 17ʼ ni ‘Gʼ en cuanto a su clasificación.

select title 
from film f 
where rating not in ('NC-17','G'); 

--13.	Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select rating as CATEGORIAS, ROUND (AVG(length ), 3) as PROMEDIO
from film f 
group by rating; -- G-111.051; PG-112.005;R-118,662;PG-13- 120.444; NC-17 - 113.229

--14.	Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select title 
from film f 
where length >180;

--15.	¿Cuánto dinero ha generado en total la empresa?
select ROUND(SUM (amount),2) as TOTAL_GENERADO
from payment p;-- 67416.51

--16.	Muestra los 10 clientes con mayor valor de id.
select customer_id, first_name, last_name 
from customer c 
order by c.customer_id desc
limit 10; 

--17.	Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
select a.first_name, a.last_name 
from actor a
inner join film_actor fa 
on fa.actor_id = a.actor_id
inner join film f 
on f.film_id = fa.film_id 
where f.title = 'Egg Igby';



--18.	Selecciona todos los nombres de las películas únicos.
select distinct title 
from film f; 

--19.	Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
select F.TITLE
from film f 
inner join film_category fc 
on fc.film_id = f.film_id
inner join category c 
on c.category_id = fc.category_id
where f.length >180 and c.name= 'Comedy';


--20.	Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c.name as cathegory, round(AVG(f.length ),2)as promedio_duracion 
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category c 
on fc.category_id =c.category_id
group by c.name 
having avg (f.length) >110;


--21.	¿Cuál es la media de duración del alquiler de las películas?
select round(AVG(rental_duration ),2) as PROMEDIO_DIAS 
from film f ; -- 4,98 DÍAS 

--22.	Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(a.first_name , ' ',a.last_name) as full_name
from actor a;  

--23.	Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.


select date(r. rental_date), count(inventory_id) as total_sales
from rental r 
group by r.rental_date
order by total_sales desc; 


--24.	Encuentra las películas con una duración superior al promedio.

select TITLE
from film f 
where length >(select AVG(length) 
	from film f2  );

--25.	Averigua el número de alquileres registrados por mes.
select EXTRACT(month from rental_date ) as MES , COUNT(R.INVENTORY_ID) as TOTAL
from rental r 
group by MES;

--26.	Encuentra el promedio, la desviación estándar y varianza del total pagado.

select ROUND(AVG(amount ),3) as PROMEDIO, ROUND(stddev(amount),3) as DESVIACION_STANDARD, ROUND(variance(amount ),3) as VARIANZA
from payment p  ;-- AVG 4.201; STTDEV 2.363 & VAR 5.585

--27.	¿Qué películas se alquilan por encima del precio medio?
select P.amount , F.title 
FROM payment p 
inner join rental r 
on r.rental_id = p.rental_id
inner join inventory i 
on i.inventory_id = r.inventory_id
inner join film f 
on f.film_id = i.film_id 
WHERE P.amount >
	(select AVG(amount )
 from payment p2 );


--28.	Muestra el id de los actores que hayan participado en más de 40 películas.
select fa.actor_id, COUNT(fa.film_id )
from film_actor fa 
inner join film f 
on f.film_id = fa.film_id
group by fa.actor_id
having COUNT(fa.film_id) >40;

--29.	Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
 select f.title as pelicula, COUNT(i. inventory_id ) as total_copias
 from inventory i 
 RIGHT JOIN film f 
 on f.film_id = i.film_id
 group by f.title;

--30.	Obtener los actores y el número de películas en las que ha actuado.
select CONCAT (A.first_name,' ', A.last_name ) as nombre_actor, COUNT(FA. film_id) as peliculas_actuadas
from film_actor fa 
inner join film f 
on f.film_id = fa.film_id
inner join actor a 
on a.actor_id = fa.actor_id
group by concat(A. first_name,' ',A.last_name );

--31.	Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select F.TITLE, CONCAT(A. first_name, ' ',A.last_name)
from film f 
left join film_actor fa 
on fa.film_id = f.film_id 
LEFT join actor a 
on a.actor_id = fa.actor_id;


--32.	Obtener todos los actores y mostrar las películas en las que hanactuado, incluso si algunos actores no han actuado en ninguna película.
select concat(A.first_name, ' ', A.last_name) as NOMBRE_COMPLETO, F.title as PELICULA
from actor a 
left join film_actor fa 
on A.actor_id =FA.actor_id
left join film f 
on f.film_id = fa.film_id;

--33.	Obtener todas las películas que tenemos y todos los registros de alquiler.
select F.TITLE, R.rental_date
from film f 
LEFT join inventory i 
on i.film_id = f.film_id
left join rental r 
on r.inventory_id = i.inventory_id
group by F.TITLE, R.rental_date
order by R.rental_date DESC; 


--34.	Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select P.customer_id, SUM (amount ) as CANTIDAD_TOTAL
from payment p
group by P.customer_id
order by CANTIDAD_TOTAL DESC
limit 5;
--35.	Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select CONCAT(first_name, ' ', last_name ) as NOMBRE_COMPLETO
from  actor a 
where first_name ilike 'Johnny';


--36.	Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
select first_name as NOMBRE, last_name as APELLIDO
from actor a; 

--37.	Encuentra el ID del actor más bajo y más alto en la tabla actor.
select MIN(actor_id ), MAX(actor_id )
from actor a; -- MIN 1 Y MAX 200

--38.	Cuenta cuántos actores hay en la tabla “actorˮ.
select COUNT(actor_id )
from actor a; -- 200

--39.	Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select CONCAT(first_name, ' ', last_name ) as NOMBRE_COMPLETO
from actor a
order by last_name asc; 

--40.	Selecciona las primeras 5 películas de la tabla “filmˮ.
select title 
from film f 
limit 5; 

--41.	Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select A.first_name, COUNT(first_name ) as RECUENTO
from actor a 
group by first_name
order by recuento DESC ; --KENNETH (4) Y PENELOPE (4)
 


--42.	Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select rental_id, CONCAT (C.first_name, ' ',C.last_name) as NOMBRE_CLIENTE 
from rental r 
inner join customer c 
on c.customer_id = r.customer_id;

--43.	Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select concat(C. first_name , ' ', C.last_name ) as NOMBRE_CUSTOMER, rental_id
from customer c 
LEFT join rental r 
on r.customer_id = c.customer_id
order by nombre_customer; 


--44.	Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select * 
from film f 
cross join category c -- Nos da el total de combinaciones que pueden darse entre la tabla f y la tabla c, no aporta valor más allá de saber el número total de combinaciones que podrían darse entre ambas tablas, ya que la información no está relacionada teniendo en cuenta ningún criterio. 

--45.	Encuentra los actores que han participado en películas de la categoría 'Action'.
select concat(a.first_name, ' ', last_name ) as NOMBRE_ACTOR
from actor a  
inner join film_actor fa 
on fa.actor_id = a.actor_id
inner join film f 
on f.film_id = fa.film_id
inner join film_category fc  
on f.film_id =fc.film_id
inner join category c 
on c.category_id = fc.category_id
where c.name = 'Action';



---46.	Encuentra todos los actores que no han participado en películas.
select CONCAT (A.first_name,' ',A.last_name ) as NOMBRE_ACTOR
from actor a 
left join film_actor fa 
on fa.actor_id = a.actor_id
left join film f 
on f.film_id = fa.film_id
where fA.film_id is null;

--47.	Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select CONCAT(A.first_NAME, ' ', last_name) as NOMBRE_ACTOR, COUNT(FA.film_id )
from actor a 
inner join film_actor fa 
on fa.actor_id = a.actor_id
group by CONCAT(A.first_NAME, ' ', last_name); 


--48.	Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
 create view ACTOR_NUM_PELICULAS as 
 select CONCAT(A.first_NAME, ' ', last_name) as NOMBRE_ACTOR, COUNT(FA.film_id )
from actor a 
inner join film_actor fa 
on fa.actor_id = a.actor_id
group by CONCAT(A.first_NAME, ' ', last_name); 

select*
from actor_num_peliculas anp;


--49.	Calcula el número total de alquileres realizados por cada cliente.
select concat(first_name, ' ', last_name ) as NOMBRE_CUSTOMER, COUNT(rental_id ) as total
from customer c 
inner join rental r 
on r.customer_id = c.customer_id
group by concat(first_name, ' ', last_name )
order by total desc ; 

--50.	Calcula la duración total de las películas en la categoría 'Action'.
select SUM(length )
from film f 
inner join film_category fc 
on fc.film_id = f.film_id
inner join category c 
on c.category_id = fc.category_id
group by C.name
having C.name = 'Action';-- 7143

--51.	Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.

create temporary table  cliente_rentas_temporal as
select concat(c.first_name, ' ', c.last_name) as nombre_cliente , COUNT(rental_id )
from customer c 
inner join rental r 
on c.customer_id =r.customer_id 
group by concat(c.first_name, ' ', c.last_name);

select*
from cliente_rentas_temporal;


--52.	Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table  peliculas_alquiladas as 
select f.title, COUNT(r.rental_id ) as recuento_peliculas
from rental r
inner join inventory i 
on i.inventory_id = r.inventory_id
inner join film f 
on f.film_id =i.film_id 
group by f.title 
having count(r.rental_id) >10;

select*
from peliculas_alquiladas;

--53.	Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

select concat(c.first_name, ' ', c.last_name ) as Nombre_cliente, f. title 
from customer c 
inner join rental r 
on r.customer_id = c.customer_id
inner join inventory i 
on i.inventory_id = r.inventory_id
left join film f 
on f.film_id = i.film_id
where concat(c.first_name, ' ', c.last_name ) ='Tammy Sanders' and r.return_date is NULL
order by f.title asc; 


--54.	Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultadosalfabéticamente por apellido.
select a.first_name, a.last_name
from actor a 
inner join film_actor fa 
on fa.actor_id = a.actor_id 
inner join film f 
on f.film_id = fa.film_id 
inner join film_category fc 
on fc.film_id = f.film_id
inner join category c 
on c.category_id =fc.category_id 
where c.name = 'Sci-Fi'
order by a.last_name asc; 


--55.	Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultadosalfabéticamente por apellido.

WITH fecha_sportacus AS (
  SELECT MIN(r.rental_date) AS fecha_referencia
  FROM rental r
  INNER JOIN inventory i ON r.inventory_id = i.inventory_id
  INNER JOIN film f ON f.film_id = i.film_id
  WHERE f.title = 'Sportacus Cheaper'
),
peliculas_posteriores AS (
  SELECT DISTINCT f.film_id
  FROM rental r
  INNER JOIN inventory i ON i.inventory_id = r.inventory_id
  INNER JOIN film f ON f.film_id = i.film_id
  CROSS JOIN fecha_sportacus fs
  WHERE r.rental_date > fs.fecha_referencia
),
actores_peliculas AS (
  SELECT a.first_name, a.last_name
  FROM actor a
  INNER JOIN film_actor fa ON fa.actor_id = a.actor_id
  INNER JOIN peliculas_posteriores pp ON fa.film_id = pp.film_id
)
SELECT *
FROM actores_peliculas
ORDER BY last_name ASC;


--56.	Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
select first_name, last_name
from actor
inner join film_actor fa
on fa.actor_id = actor.actor_id
inner join film f 
on f.film_id = fa.film_id
inner join film_category fc 
on fc.film_id = f.film_id
inner join category c 
on c.category_id = fc.category_id
where  c.name  not in ('Music');

--57.	Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

with tiempo_alquilado as(
select r.inventory_id,extract (day from r.return_date-r.rental_date) as dias_alquilado 
from rental r
inner join inventory i 
on i.inventory_id = r.inventory_id)
select f.title, dias_alquilado 
from film f 
inner join inventory i 
on i.film_id=f.film_id 
inner join tiempo_alquilado
on i.inventory_id= tiempo_alquilado.inventory_id
where dias_alquilado > 8;


--58.	Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

select f. title 
from film f 
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category c 
on c.category_id = fc.category_id
where c.name = 'Animation';

--59.	Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.
with duracion_D as(
select  length 
from film f 
where f.title = 'Dancing Fever'
)

select title 
from film f 
where length =
(select length
from duracion_D)
order by f.title asc;


--60.	Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

select first_name , last_name, COUNT(r.rental_id ) as total_peliculas
from customer c 
inner join rental r
on r.customer_id = c.customer_id
group by c.first_name, c.last_name 
having COUNT(distinct (r.rental_id)) >=7
order by c.last_name asc; 


--61.	Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select name as cartegoria, count(rental_id ) as total_alquileres
from film f 
inner join film_category fc 
on f.film_id = fc.film_id
inner join category
on category.category_id = fc.category_id
inner join inventory i  
on i.film_id = f.film_id
inner join rental r 
on i.inventory_id = r.inventory_id
group by name; 


--62.	Encuentra el número de películas por categoría estrenadas en 2006.
select C.NAME as CATEGORIA, COUNT(title )
from film f 
inner join film_category fc 
on fc.film_id = f.film_id
inner join category c 
on c.category_id = fc.category_id
where F.RELEASE_YEAR = '2006'
group by c.name , f.release_year ; 


--63.	Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select concat(s.first_name, ' ',s.last_name) as EMPLEADO, s2.store_id as TIENDA
from staff s 
cross join store s2; 

--64.	Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

select CONCAT(first_name, ' ',last_name)as NOMBRE_CLIENTE, c.customer_id, COUNT(R.rental_id )
from customer c
inner join rental r 
on R.CUSTOMER_ID = C.CUSTOMER_ID
GROUP by CONCAT(FIRST_NAME, ' ', LAST_NAME), C.CUSTOMER_ID; 


-- QUERYS PARA REALIZAR EL INFORME 
with recuento_peliculas as(
select a.actor_id , count(f.title) as recuento
from actor a 
inner join film_actor fa 
on a.actor_id =fa.actor_id 
inner join film f 
on f.film_id = fa.film_id
group by a.actor_id )
select max (recuento ), min (recuento), round(AVG(recuento ),2)
from recuento_peliculas; 

select P.customer_id, CONCAT (C.first_name, ' ', C.last_name ) as NOMBRE_CLIENTE, SUM (P.AMOUNT) as CANTIDAD_TOTAL
from payment p
inner join customer c 
on c.customer_id = p.customer_id
group by NOMBRE_CLIENTE, P.customer_id
order by CANTIDAD_TOTAL DESC
limit 5;

select count(rental_id )
from rental r 

--
select c. name, count (rental_id ) as recuento
from rental r 
inner join inventory i 
on i.inventory_id = r.inventory_id
inner join film f 
on f.film_id = i.film_id
inner join film_category fc  
on fc.film_id = f.film_id
inner join category c 
on c.category_id = fc.category_id
group by c.name
order by recuento desc; 



