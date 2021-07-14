-- Obtener a todos los usuarios que han realizado un préstamo en los últimos diez días.
SELECT U.nombre 
FROM usuarios AS U
INNER JOIN libros_usuarios AS LU ON U.usuario_id = LU.usuario_id AND LU.fecha_creacion >= 10
GROUP by U.usuario_id;

-- Obtener a todos los usuarios que no ha realizado ningún préstamo.
SELECT U.nombre 
FROM usuarios AS U
LEFT JOIN libros_usuarios AS LU ON U.usuario_id= LU.usuario_id
WHERE LU.usuario_id IS NULL; 

-- Listar de forma descendente a los cinco usuarios con más préstamos.
SELECT COUNT(U.usuario_id) AS Prestamos, U.nombre 
FROM libros_usuarios AS LU 
INNER JOIN usuarios AS U ON U.usuario_id = LU.usuario_id
GROUP by U.usuario_id 
ORDER BY U.usuario_id desc;

-- Listar 5 títulos con más préstamos en los últimos 30 días.
SELECT COUNT(L.libro_id) AS Prestamos, L.titulo
FROM libros_usuarios AS LU 
INNER JOIN libros AS L ON L.libro_id = LU.libro_id
WHERE LU.fecha_creacion >= CURDATE() - INTERVAL 1 MONTH
GROUP by L.libro_id LIMIT 5;

-- Obtener el título de todos los libros que no han sido prestados.
SELECT L.titulo 
FROM libros AS L
LEFT JOIN libros_usuarios AS LU ON L.libro_id = LU.libro_id
WHERE LU.libro_id IS NULL;

-- Obtener la cantidad de libros prestados el día de hoy.
SELECT COUNT(fecha_creacion) AS Total_Prestamos
FROM libros_usuarios
WHERE fecha_creacion = CURDATE();  

-- Obtener la cantidad de libros prestados por el autor con id 1.
SELECT COUNT(fecha_creacion) AS Total_Prestamos
FROM libros_usuarios
WHERE usuario_id = 1; 

-- Obtener el nombre completo de los cinco autores con más préstamos.
SELECT CONCAT(A.nombre, ' ', A.apellido) AS Nombre_Completo, COUNT(LU.libro_id) AS Mas_Prestados 
FROM autores AS A
INNER JOIN libros AS L ON L.autor_id = A.autor_id 
INNER JOIN libros_usuarios AS LU ON L.libro_id = LU.libro_id 
GROUP BY Nombre_Completo
ORDER BY Mas_Prestados DESC LIMIT 5;

-- Obtener el título del libro con más préstamos esta semana.
SELECT L.titulo , COUNT(LU.libro_id) AS Mas_Prestados 
FROM libros AS L
INNER JOIN libros_usuarios AS LU ON L.libro_id = LU.libro_id
WHERE LU.fecha_creacion >= CURDATE() - INTERVAL 5 DAY 
GROUP BY L.titulo
ORDER BY Mas_Prestados DESC LIMIT 1;