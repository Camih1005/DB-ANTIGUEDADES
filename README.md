# DB-ANTIGUEDADES


-- 1
 
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

-- 2

SELECT a.nombre, c.nombre_categoria, a.precio, a.estado_conservacion
FROM Antiguedades a
JOIN categorias c ON a.categoria_id = c.categoria_id
WHERE c.nombre_categoria = 'Arte' AND a.precio BETWEEN 100 AND 2000;


-- 3

SELECT a.nombre, t.fecha_transaccion, t.precio_final, u.nombre AS comprador
FROM Transacciones t
JOIN Antiguedades a ON t.antiguedad_id = a.antiguedad_id
JOIN Usuarios u ON t.comprador_id = u.usuario_id
WHERE t.vendedor_id = 2; 

-- 4

SELECT SUM(t.precio_final) AS total_ventas
FROM Transacciones t
WHERE t.fecha_transaccion >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH);


-- 5

SELECT u.nombre, COUNT(t.transaccion_id) AS num_compras
FROM Transacciones t
JOIN Usuarios u ON t.comprador_id = u.usuario_id
GROUP BY u.nombre
ORDER BY num_compras DESC;

-- 6

SELECT u.nombre, COUNT(u.nombre) AS frecuencia
FROM Transacciones AS t
JOIN Usuarios AS u ON u.usuario_id = t.comprador_id
GROUP BY u.nombre
ORDER BY frecuencia DESC;

-- 7

SELECT a.nombre, t.fecha_transaccion, u.nombre AS vendedor, u2.nombre AS comprador
FROM Transacciones t
JOIN Antiguedades a ON t.antiguedad_id = a.antiguedad_id
JOIN Usuarios u ON t.vendedor_id = u.usuario_id
JOIN Usuarios u2 ON t.comprador_id = u2.usuario_id
WHERE t.fecha_transaccion BETWEEN '2022-01-01' AND '2025-01-31';

-- 8

SELECT c.nombre_categoria, COUNT(a.antiguedad_id) AS cantidad_disponible
FROM Antiguedades a
JOIN Categorias c ON a.categoria_id = c.categoria_id
WHERE a.estatus_id = 4 
GROUP BY c.nombre_categoria;





