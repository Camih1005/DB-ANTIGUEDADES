CREATE database if not exists antiguedades;

drop database antiguedades;
USE antiguedades;


-- Tabla Permisos
CREATE TABLE Permisos (
    permiso_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_permiso VARCHAR(50) UNIQUE NOT NULL
);



-- Tabla Roles
CREATE TABLE Roles (
    rol_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) UNIQUE NOT null,
    id_permiso int,
    foreign key(id_permiso) references Permisos(permiso_id)
);



-- Tabla Usuarios
CREATE TABLE Usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL, 
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rol_id INT, 
    FOREIGN KEY (rol_id) REFERENCES Roles(rol_id) 
);

-- Tabla Perfiles de Usuarios
CREATE TABLE Perfiles_Usuarios (
    perfil_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    telefono VARCHAR(20),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla Direcciones de Usuarios
CREATE TABLE Direcciones_Usuarios (
    direccion_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    provincia VARCHAR(100),
    codigo_postal VARCHAR(10),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);


-- Tabla Categorias
CREATE TABLE Categorias (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT
);

-- Tabla Estatus de Antigüedades
CREATE TABLE Estatus_Antiguedad (
    estatus_id INT AUTO_INCREMENT PRIMARY KEY,
    estatus_nombre VARCHAR(50) UNIQUE NOT NULL  
);

-- Tabla Antigüedades
CREATE TABLE Antiguedades (
    antiguedad_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    foto VARCHAR(255),  
    categoria_id INT,
    epoca VARCHAR(100),
    estado_conservacion VARCHAR(50),
    precio DECIMAL(10, 2),
    vendedor_id INT,
    estatus_id INT, 
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id),
    FOREIGN KEY (vendedor_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (estatus_id) REFERENCES Estatus_Antiguedad(estatus_id)
);


CREATE TABLE Estados_pagos (
    estado_pago_id INT AUTO_INCREMENT PRIMARY KEY,
    estado_pago_nombre VARCHAR(50) UNIQUE NOT NULL 
);

-- Tabla Transacciones
CREATE TABLE Transacciones (
    transaccion_id INT AUTO_INCREMENT PRIMARY KEY,
    comprador_id INT,
    vendedor_id INT,
    antiguedad_id INT,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    precio_final DECIMAL(10, 2) NOT NULL,
    metodo_pago VARCHAR(50),
    estado_pago_id INT, 
    FOREIGN KEY (comprador_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (vendedor_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (antiguedad_id) REFERENCES Antiguedades(antiguedad_id),
    FOREIGN KEY (estado_pago_id) REFERENCES  Estados_pagos(estado_pago_id)
);


CREATE TABLE Historial_Precios (
    historial_precio_id INT AUTO_INCREMENT PRIMARY KEY,
    antiguedad_id INT,
    precio_final DECIMAL(10.2) not null,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (antiguedad_id) REFERENCES Antiguedades(antiguedad_id)
);


CREATE TABLE Inventario (
    inventario_id INT AUTO_INCREMENT PRIMARY KEY,
    antiguedad_id INT,
    cantidad_disponible INT DEFAULT 0,
    FOREIGN KEY (antiguedad_id) REFERENCES Antiguedades(antiguedad_id)
);
