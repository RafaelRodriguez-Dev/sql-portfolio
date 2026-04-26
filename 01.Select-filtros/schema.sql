CREATE SCHEMA datasetsimple;

USE datasetsimple;

CREATE TABLE usuarios (
id INT,
nombre VARCHAR(50),
edad INT,
ciudad VARCHAR(50)
);

CREATE TABLE compras (
id INT,
usuario_id INT,
producto VARCHAR(50),
precio INT
);

ALTER TABLE usuarios
ADD PRIMARY KEY (id);

ALTER TABLE compras
ADD CONSTRAINT fk_usuario
FOREIGN KEY (usuario_id) REFERENCES
usuarios(id);



 