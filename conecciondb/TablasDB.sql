-- Crear tabla de Usuarios
CREATE TABLE Usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Crear tabla de Productos
CREATE TABLE Productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0
);
 
-- Crear tabla de Pedidos
CREATE TABLE Pedidos (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);
 
-- Agregar datos de ejemplo
INSERT INTO Usuarios (nombre, apellido, email) VALUES
('Juan', 'Pérez', 'juan.perez@example.com'),
('Ana', 'Gómez', 'ana.gomez@example.com'),
('Luis', 'Martínez', 'luis.martinez@example.com');
 
INSERT INTO Productos (nombre, descripcion, precio, stock) VALUES
('Laptop', 'Laptop de última generación', 1200.50, 10),
('Mouse', 'Mouse inalámbrico', 25.00, 100),
('Teclado', 'Teclado mecánico', 80.00, 50);
 
INSERT INTO Pedidos (id_usuario, total) VALUES
(1, 1225.50),
(2, 105.00),
(3, 80.00);