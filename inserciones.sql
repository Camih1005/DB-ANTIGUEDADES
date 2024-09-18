
USE antiguedades;



INSERT INTO Permisos (nombre_permiso) VALUES
('Administrador'),
('Vendedor'),
('Comprador');



INSERT INTO Roles (nombre_rol, id_permiso) VALUES
('Administrador', 1),
('Vendedor', 2),
('Comprador', 3);



INSERT INTO Usuarios (nombre, email, contraseña, rol_id) VALUES
('John Doe', 'john@example.com', 'password123', 1),  -- Administrador
('Jane Doe', 'jane@example.com', 'password123', 2),  -- Vendedor
('Bob Smith', 'bob@example.com', 'password123', 3),  -- Comprador
('Alice Johnson', 'alice@example.com', 'password123', 2),  -- Vendedor
('Mike Brown', 'mike@example.com', 'password123', 3);  -- Comprador


INSERT INTO Perfiles_Usuarios (usuario_id, telefono) VALUES
(1, '123-456-7890'),
(2, '987-654-3210'),
(3, '555-123-4567'),
(4, '555-555-5555'),
(5, '666-666-6666');


INSERT INTO Direcciones_Usuarios (usuario_id, direccion, ciudad, provincia, codigo_postal) VALUES
(1, '123 Main St', 'New York', 'NY', '10001'),
(2, '456 Elm St', 'Los Angeles', 'CA', '90001'),
(3, '789 Oak St', 'Chicago', 'IL', '60601'),
(4, '321 Park Ave', 'San Francisco', 'CA', '94111'),
(5, '901 Broadway', 'New York', 'NY', '10010');


INSERT INTO Categorias (nombre_categoria, descripcion) VALUES
('Antigüedades', 'Objetos antiguos y valiosos'),
('Arte', 'Obras de arte y pinturas'),
('Coleccionables', 'Objetos coleccionables y raros'),
('Furniture', 'Muebles antiguos y restaurados');


INSERT INTO Estatus_Antiguedad (estatus_nombre) VALUES
('Nuevo'),
('Usado'),
('Restaurado'),
('En venta'),
('Vendido'),
('Retirado');



INSERT INTO Antiguedades (nombre, descripcion, foto, categoria_id, epoca, estado_conservacion, precio, vendedor_id, estatus_id) VALUES
('Vaso Romano', 'Vaso romano antiguo', 'vaso_romano.jpg', 1, 'Romano', 'Excelente', 100.00, 2, 4),  
('Pintura Moderna', 'Pintura moderna abstracta', 'pintura_moderna.jpg', 2, 'Modern', 'Bueno', 500.00, 4, 1),  
('Moneda Antigua', 'Moneda antigua rara', 'moneda_antigua.jpg', 3, 'Antigua', 'Restaurado', 200.00, 2, 4),  
('Mesa Antigua', 'Mesa antigua restaurada', 'mesa_antigua.jpg', 4, 'Victoriano', 'Excelente', 800.00, 4, 4); 



INSERT INTO Estados_pagos (estado_pago_nombre) VALUES
('Pendiente'),
('Aprobado'),
('Rechazado'),
('En proceso');



INSERT INTO Transacciones (comprador_id, vendedor_id, antiguedad_id, precio_final, metodo_pago, estado_pago_id) VALUES
(3, 2, 1, 100.00, 'Tarjeta de Crédito', 1),  
(5, 4, 2, 500.00, 'PayPal', 2), 
(3, 2, 3, 200.00, 'Transferencia Bancaria', 2),
(3, 1, 3, 400.00, 'Efectivo', 2);  



INSERT INTO Historial_Precios (antiguedad_id, precio_final, fecha_cambio) VALUES
(1, 90.00, '2022-01-01 00:00:00'),
(1, 100.00, '2022-01-15 00:00:00'),
(2, 450.00, '2022-02-01 00:00:00'),
(3, 180.00, '2022-03-01 00:00:00');



INSERT INTO Inventario (antiguedad_id, cantidad_disponible) VALUES
(1, 5),
(2, 3),
(3, 2),
(4, 1);



-- 1
 
select a.nombre,c.nombre_categoria,a.precio,a.estado_conservacion from Antiguedades as a 
join Estatus_Antiguedad as ea on a.estatus_id = ea.estatus_id
join categorias as c on c.categoria_id = a.categoria_id
where ea.estatus_id = 4;

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

