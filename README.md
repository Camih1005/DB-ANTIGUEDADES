# DB-ANTIGUEDADES


-- 1
"Obtén una lista de todas las piezas antiguas que están actualmente disponibles para la
venta, incluyendo el nombre de la pieza, su categoría, precio y estado de conservación."
 ``` sql
select a.nombre,c.nombre_categoria,a.precio,a.estado_conservacion from Antiguedades as a 
join Estatus_Antiguedad as ea on a.estatus_id = ea.estatus_id
join categorias as c on c.categoria_id = a.categoria_id
where ea.estatus_id = 4;
-- resultado

nombre        |nombre_categoria|precio|estado_conservacion|
--------------+----------------+------+-------------------+
Vaso Romano   |Antigüedades    |100.00|Excelente          |
Moneda Antigua|Coleccionables  |200.00|Restaurado         |
Mesa Antigua  |Furniture       |800.00|Excelente          |
``` 
-- 2 "Busca todas las antigüedades dentro de una categoría específica (por ejemplo, 'Muebles')
que tengan un precio dentro de un rango determinado (por ejemplo, entre 500 y 2000
dólares)."
``` sql
SELECT a.nombre, c.nombre_categoria, a.precio, a.estado_conservacion
FROM Antiguedades a
JOIN categorias c ON a.categoria_id = c.categoria_id
WHERE c.nombre_categoria = 'Arte' AND a.precio BETWEEN 100 AND 2000;

nombre         |nombre_categoria|precio|estado_conservacion|
---------------+----------------+------+-------------------+
Pintura Moderna|Arte            |500.00|Bueno              |
``` 
-- 3 "Muestra todas las piezas antiguas que un cliente específico ha vendido, incluyendo la fecha
de la venta, el precio de venta y el comprador."
``` sql
SELECT a.nombre, t.fecha_transaccion, t.precio_final, u.nombre AS comprador
FROM Transacciones t
JOIN Antiguedades a ON t.antiguedad_id = a.antiguedad_id
JOIN Usuarios u ON t.comprador_id = u.usuario_id
WHERE t.vendedor_id = 2;

nombre        |fecha_transaccion  |precio_final|comprador|
--------------+-------------------+------------+---------+
Vaso Romano   |2024-09-17 19:14:23|      100.00|Bob Smith|
Moneda Antigua|2024-09-17 19:14:23|      200.00|Bob Smith|
``` 
-- 4 "Calcula el total de ventas realizadas en un período específico, por ejemplo, durante el último
mes."
``` sql
SELECT SUM(t.precio_final) AS total_ventas
FROM Transacciones t
WHERE t.fecha_transaccion >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH);


total_ventas|
------------+
     1200.00|
``` 

-- 5 "Identifica los clientes que han realizado la mayor cantidad de compras en la plataforma."
``` sql
SELECT u.nombre, COUNT(t.transaccion_id) AS num_compras
FROM Transacciones t
JOIN Usuarios u ON t.comprador_id = u.usuario_id
GROUP BY u.nombre
ORDER BY num_compras DESC;

nombre    |num_compras|
----------+-----------+
Bob Smith |          3|
Mike Brown|          1|
``` 
-- 6 "Muestra las piezas antiguas que han recibido la mayor cantidad de visitas o consultas por
parte de los usuarios.
``` sql
SELECT u.nombre, COUNT(u.nombre) AS frecuencia
FROM Transacciones AS t
JOIN Usuarios AS u ON u.usuario_id = t.comprador_id
GROUP BY u.nombre
ORDER BY frecuencia DESC;

nombre    |frecuencia|
----------+----------+
Bob Smith |         3|
Mike Brown|         1|
``` 
-- 7 "Obtén una lista de todas las piezas antiguas que se han vendido dentro de un rango de
fechas específico, incluyendo la información del vendedor y comprador."
``` sql
SELECT a.nombre, t.fecha_transaccion, u.nombre AS vendedor, u2.nombre AS comprador
FROM Transacciones t
JOIN Antiguedades a ON t.antiguedad_id = a.antiguedad_id
JOIN Usuarios u ON t.vendedor_id = u.usuario_id
JOIN Usuarios u2 ON t.comprador_id = u2.usuario_id
WHERE t.fecha_transaccion BETWEEN '2022-01-01' AND '2025-01-31';

nombre         |fecha_transaccion  |vendedor     |comprador |
---------------+-------------------+-------------+----------+
Vaso Romano    |2024-09-17 19:14:23|Jane Doe     |Bob Smith |
Pintura Moderna|2024-09-17 19:14:23|Alice Johnson|Mike Brown|
Moneda Antigua |2024-09-17 19:14:23|Jane Doe     |Bob Smith |
Moneda Antigua |2024-09-17 19:14:23|John Doe     |Bob Smith |
``` 
-- 8 "Genera un informe del inventario actual de antigüedades disponibles para la venta,
mostrando la cantidad de artículos por categoría."
``` sql
SELECT c.nombre_categoria, COUNT(a.antiguedad_id) AS cantidad_disponible
FROM Antiguedades a
JOIN Categorias c ON a.categoria_id = c.categoria_id
WHERE a.estatus_id = 4 
GROUP BY c.nombre_categoria;

nombre_categoria|cantidad_disponible|
----------------+-------------------+
Antigüedades    |                  1|
Coleccionables  |                  1|
Furniture       |                  1|
``` 




