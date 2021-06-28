-- INNER JOIN

SELECT LIB.titulo, CONCAT(AUT.nombre, ' ', AUT.apellido) AS NombreCompleto, LIB.fecha_creacion 
FROM libros AS LIB
INNER JOIN autores AS AUT -- INNER JOIN nos regresa los resultados de la interseccion entre esas dos tablas 
ON AUT.autor_id = LIB.autor_id;

SELECT LIB.titulo, CONCAT(AUT.nombre, ' ', AUT.apellido) AS NombreCompleto, LIB.fecha_creacion 
FROM libros AS LIB
INNER JOIN autores AS AUT
USING(autor_id); -- Podemos usar USING si nuestras dos tablas manejan el mismo nombre entre llave primaria y foranea, no acepta ningun tipo de condicion como el ON

SELECT LIB.titulo, CONCAT(AUT.nombre, ' ', AUT.apellido) AS NombreCompleto, LIB.fecha_creacion 
FROM libros AS LIB
INNER JOIN autores AS AUT 
ON AUT.autor_id = LIB.autor_id AND AUT.seudonimo IS NOT NULL;

-- LEFT JOIN

-- Obtener el nombre completo de los usuarios y el id de los libros prestados

-- USUARIOS = A
-- LIBROS_USUARIOS = B

SELECT CONCAT(USU.nombre, ' ', USU.apellidos), LIBU.libro_id 
FROM usuarios AS USU -- El LEFT JOIN nos devolvera informacion de la interseccion de la tabla principal, que se establece en el FROM, la tabla que se especifica en el LEFT JOIN 
LEFT JOIN libros_usuarios AS LIBU
ON USU.usuario_id = LIBU.usuario_id
WHERE LIBU.libro_id IS NOT NULL;

SELECT CONCAT(USU.nombre, ' ', USU.apellidos), LIBU.libro_id 
FROM usuarios AS USU
LEFT JOIN libros_usuarios AS LIBU
ON USU.usuario_id = LIBU.usuario_id
WHERE LIBU.libro_id IS NULL;

-- RIGHT JOIN

-- Obtener el nombre completo de los usuarios y el id de los libros prestados

-- LIBROS_USUARIOS = A
-- USUARIOS = B

SELECT CONCAT(USU.nombre, ' ', USU.apellidos), LIBU.libro_id 
FROM libros_usuarios AS LIBU -- El RIGHT JOIN es similar al LEFT JOIN solo cambia el orden de las tablas 
RIGHT JOIN usuarios AS USU
ON USU.usuario_id = LIBU.usuario_id
WHERE LIBU.libro_id IS NOT NULL;

SELECT CONCAT(USU.nombre, ' ', USU.apellidos), LIBU.libro_id 
FROM libros_usuarios AS LIBU
RIGHT JOIN usuarios AS USU
ON USU.usuario_id = LIBU.usuario_id
WHERE LIBU.libro_id IS NULL;

/*Obtengamos el nombre completo de los usuario que hayan prestado un libro, 
 * el libro debio haber sido escrito por un autor con seudonimo
 * el prestamo debio haber sido realizado el dia de hoy
 * 
 * Trabajaremos con 
 * usuarios
 * libros_usuarios
 * libros
 * autores*/

SELECT DISTINCT CONCAT(USU.nombre, ' ', USU.apellidos) AS NombreUsuario
FROM usuarios AS USU
INNER JOIN libros_usuarios AS LIU ON USU.usuario_id = LIU.usuario_id AND DATE(LIU.fecha_creacion) = CURDATE()
INNER JOIN libros AS LIB ON LIU.libro_id  = LIB.libro_id
INNER JOIN autores AS AUT ON LIB.autor_id = AUT.autor_id AND AUT.seudonimo IS NOT NULL;

SELECT USU.username, LIB.titulo
FROM usuarios AS USU
CROSS JOIN libros AS LIB; -- CROSS JOIN devuelve un producto cartesiano

