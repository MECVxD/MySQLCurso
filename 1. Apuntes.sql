SET @nombre = 'Mauricio'; -- Declaracion de variables

SET @nombre := 'Mauricio'; -- Declaracion de variables

CREATE DATABASE libreria_cf; -- Crear una base de datos

SHOW DATABASES;	-- Visualizar todas las bases de datos

DROP  DATABASE libreria_cf; -- Eliminar una base de datos

USE libreria_cf; -- Indica sobre que base de datos se va a trabajar

/*
¿Que tipo de entidades? autores
Nombre : autores

Nombre
Genero
Fecha de nacimiento

Columna y el tipo de dato
*/

CREATE TABLE autores(	-- Definicion de una tabla
	autor_id 			INT 			UNSIGNED PRIMARY KEY AUTO_INCREMENT,		-- UNSIGNED indica que el valor debe ser positivo
	nombre 				VARCHAR(25) 	NOT NULL, 									-- NOT NULL indica que el valor no puede ser negativo
	apellido 			VARCHAR(25) 	NOT NULL,
	seudonimo 			VARCHAR(50) 	UNIQUE, 									-- UNIQUE indica que el valor debe ser unico dentro de la tabla
	genero 				ENUM('M', 'F'),											-- ENUM se usa cuando tenemos como maximo 4 opciones que no cambian a lo largo del tiempo
	fecha_nacimiento 	DATE			NOT NULL,
	pais_origen 		VARCHAR(40) 	NOT NULL,
	fecha_creacion		DATETIME 		DEFAULT current_timestamp 					-- current_timestamp toma el valor del sistema
);

SHOW TABLES; -- Muesta las tablas

SELECT DATABASE(); -- Nos muesta en que base de datos estamos

DROP TABLE autores; -- Elimina una tabla y todos sus registros

SHOW COLUMNS FROM autores; -- Muestra la composicion de una tabla

DESC autores; -- Muestra la composicion de una tabla

CREATE TABLE usuarios LIKE autores; -- crea una nueva tabla con los mismos campos que la tabla base

INSERT INTO autores (autor_id, nombre, apellido, genero, fecha_nacimiento, pais_origen) -- Insertar registros a una tabla
VALUES 	(1, 'Stephen Edwin', 'King', 'Richard Bachman', 'M', '1947-09-27', 'USA'), -- Tuplas
		(2, 'Joanne', 'Rowling', 'J.K Rowling', 'F', '1995-12-16', 'Reino Unido');

SELECT * FROM autores; -- Regresa todos los valores de la tabla

ALTER TABLE libros ADD ventas INT UNSIGNED NOT NULL; 

ALTER TABLE libros ADD stock INT UNSIGNED NOT NULL DEFAULT 10;

ALTER TABLE libros DROP COLUMN stock;

-- ALTER TABLE sirve para modificar la definicion de iuna tabla
		-- Podemos moficiar el nombre de la tabla con RENAME
		-- Podemos agregar una nueva columna con ADD, con o sin CONSTRAINTS
		-- Podemos eliminar una columna o modificar su tipo de dato
		-- Podemos generar una llave primaria
		-- Podemos agregar o eliminar una llave foranea