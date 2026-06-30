CREATE DATABASE toldillosJG;
USE toldillosJG;

CREATE TABLE colores (
	id_color INT PRIMARY KEY AUTO_INCREMENT,
    color VARCHAR(50)
);

CREATE TABLE telas (
	id_tela INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50),
    precio INT
);

CREATE TABLE tela_color (
	id_tela_color INT PRIMARY KEY AUTO_INCREMENT,
    id_color INT,
    id_color INT,
    stock INT,
    FOREIGN KEY (id_tela) REFERENCES telas (id_tela),
    FOREIGN KEY (id_color) REFERENCES colores (id_color)
);

CREATE TABLE productos (
	id_producto INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50),
    nombre VARCHAR(50),
    medida DECIMAL(1,2),
    tamaño VARCHAR(50),
    consumo_tela DECIMAL(1,2),
    precio INT
);

CREATE TABLE productos_variante (
	id_variante INT PRIMARY KEY AUTO_INCREMENT,
    id_producto INT,
    id_color INT,
    id_tela INT,
    stock INT,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_color) REFERENCES colores (id_color),
    FOREIGN KEY (id_tela) REFERENCES telas (id_tela)
);

CREATE TABLE movimientos (
	id_movimiento INT PRIMARY KEY AUTO_INCREMENT,
	tipo ENUM('Compra', 'Venta', 'Fabricacion')
);

CREATE TABLE movimientos_detalle (
	id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_movimiento INT,
    id_variante INT NULL,
    id_tela_color INT NULL,
    operacion ENUM('Entrada', 'Salida'),
    cantidad INT,
    fecha DATETIME,
    FOREIGN KEY (id_movimiento) REFERENCES movimientos (id_movimiento),
    FOREIGN KEY (id_variante) REFERENCES productos_variantes (id_variante_producto),
    FOREIGN KEY (id_tela_color) REFERENCES tela_color (id_tela_color)
);