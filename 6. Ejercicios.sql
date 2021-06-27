-- En estos ejercicios decidí no usar JOINs, aunque se podrian usar
-- LIBROS

-- Obtener todos los libros escritos por autores que cuenten con un seudónimo.
SELECT titulo
FROM libros 
WHERE autor_id IN (
					SELECT autor_id
					FROM autores
					WHERE seudonimo IS NOT NULL
					);
				
-- Obtener el título de todos los libros publicados en el año actual cuyos autores poseen un pseudónimo.
SELECT titulo
FROM libros 
WHERE autor_id IN (
					SELECT autor_id
					FROM autores
					WHERE seudonimo IS NOT NULL
					) AND YEAR(fecha_publicacion) = YEAR(NOW());
				
-- Obtener todos los libros escritos por autores que cuenten con un seudónimo y que hayan nacido ante de 1965.
SELECT titulo
FROM libros 
WHERE autor_id IN (
					SELECT autor_id
					FROM autores
					WHERE seudonimo IS NOT NULL AND YEAR(fecha_nacimiento)<'1965'
					);
				
-- Colocar el mensaje no disponible a la columna descripción, en todos los libros publicados antes del año 2000.
UPDATE libros SET descripcion = ' NO DISPONIBLE'
WHERE YEAR(fecha_publicacion)<'2000';

-- Obtener la llave primaria de todos los libros cuya descripción sea diferente de no disponible.
SELECT libro_id
FROM libros
WHERE descripcion != 'NO DISPONIBLE';

-- Obtener el título de los últimos 3 libros escritos por el autor con id 2.
SELECT titulo
FROM libros 
WHERE autor_id = 2
ORDER BY fecha_publicacion DESC LIMIT 3;

-- Obtener en un mismo resultado la cantidad de libros escritos por autores con seudónimo y sin seudónimo.
SELECT COUNT(autor_id) AS ConSeudonimo
FROM libros
WHERE autor_id IN (SELECT autor_id
					FROM autores
					WHERE seudonimo IS NOT NULL)
UNION
SELECT COUNT(autor_id) AS SinSeudonimo
FROM libros
WHERE autor_id IN (SELECT autor_id
					FROM autores
					WHERE seudonimo IS NULL);
				
-- Obtener la cantidad de libros publicados entre enero del año 2000 y enero del año 2005.
SELECT *
FROM libros
WHERE fecha_publicacion BETWEEN '2000-01-01' AND '2005-12-31';

-- Obtener el título y el número de ventas de los cinco libros más vendidos.
SELECT titulo, ventas
FROM libros
ORDER BY ventas DESC LIMIT 5;

-- Obtener el título y el número de ventas de los cinco libros más vendidos de la última década.
SELECT titulo, ventas
FROM libros
WHERE fecha_publicacion > CURDATE() - INTERVAL 10 YEAR; 

-- Obtener la cantidad de libros vendidos por los autores con id 1, 2 y 3.
SELECT autor_id, SUM(ventas) AS LibrosVendidos
FROM libros
WHERE autor_id IN(1, 2, 3)
GROUP BY autor_id;

-- Obtener el título del libro con más páginas.
SELECT titulo
FROM libros
HAVING MAX(paginas);

-- Obtener todos los libros cuyo título comience con la palabra “La”.
SELECT *
FROM libros
WHERE titulo LIKE 'La%';

-- Obtener todos los libros cuyo título comience con la palabra “La” y termine con la letra “a”.
SELECT *
FROM libros
WHERE titulo LIKE 'La%' AND titulo LIKE '%a';

-- Establecer el stock en cero a todos los libros publicados antes del año de 1995
UPDATE libros SET stock = 0 
WHERE YEAR(fecha_publicacion) < '1995'; 

-- Mostrar el mensaje Disponible si el libro con id 1 posee más de 5 ejemplares en stock, en caso contrario mostrar el mensaje No disponible.
SELECT IF(
	EXISTS(SELECT libro_id
			FROM libros
			WHERE libro_id = 1 AND stock >= 5),
			'DISPONIBLE',
			'NO DISPONIBLE'
) AS mensaje;

-- Obtener el título los libros ordenador por fecha de publicación del más reciente al más viejo.
SELECT titulo, fecha_publicacion 
FROM libros
ORDER BY fecha_publicacion DESC;

-- AUTORES

-- Obtener el nombre de los autores cuya fecha de nacimiento sea posterior a 1950
SELECT nombre, fecha_nacimiento 
FROM autores
WHERE YEAR(fecha_nacimiento)>'1950';

-- Obtener la el nombre completo y la edad de todos los autores.
SELECT CONCAT(nombre, ' ', apellido) AS NombreCompleto, (YEAR(CURDATE())-YEAR(fecha_nacimiento)) AS Edad
FROM autores; 

-- Obtener el nombre completo de todos los autores cuyo último libro publicado sea posterior al 2005.
SELECT CONCAT(nombre, ' ', apellido) AS NombreCompleto
FROM autores
WHERE autor_id IN(
					SELECT autor_id 
					FROM libros
					WHERE YEAR(fecha_publicacion) > '2005'
				); 

-- Obtener el id de todos los escritores cuyas ventas en sus libros superen el promedio.
SELECT DISTINCT autor_id
FROM libros
WHERE autor_id IN(
					SELECT autor_id
					FROM libros 
					WHERE ventas > (
										SELECT AVG(ventas)
										FROM libros
									) 
				);

-- Obtener el id de todos los escritores cuyas ventas en sus libros sean mayores a cien mil ejemplares.
SELECT autor_id
FROM libros
WHERE autor_id IN(
					SELECT autor_id
					FROM libros 
					HAVING SUM(ventas) > 100000 
				);


-- FUNCIONES

-- Crear una función la cual nos permita saber si un libro es candidato a préstamo o no. Retornar “Disponible” si el libro posee por lo menos un ejemplar en stock, en caso contrario retornar “No disponible.”
DELIMITER // 

CREATE FUNCTION consulta_libro(Contitulo VARCHAR(25))
RETURNS VARCHAR(25)
BEGIN
	SET @MENSAJE = (SELECT IF(
								EXISTS(SELECT libro_id
										FROM libros
										WHERE titulo = Contitulo AND stock >= 1),
										'DISPONIBLE',
										'NO DISPONIBLE'
							)
					);
	RETURN @MENSAJE;
END//

DELIMITER ;
