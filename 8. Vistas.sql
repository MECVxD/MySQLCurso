CREATE VIEW prestamos_usuarios_vw AS -- De esta manera se puede crear una vista seguida del query que queremos ejecutar
SELECT U.usuario_id, U.nombre, U.email, U.username, COUNT(U.usuario_id) AS total_prestamos 
FROM usuarios AS U
INNER JOIN libros_usuarios AS LU ON U.usuario_id = LU.usuario_id
GROUP by U.usuario_id;

CREATE OR REPLACE VIEW prestamos_usuarios_vw AS -- De esta manera se puede modificar una vista sin necesidad de eliminarla antes.
SELECT U.usuario_id, U.nombre, U.email, U.username, COUNT(U.usuario_id) AS total_prestamos 
FROM usuarios AS U
INNER JOIN libros_usuarios AS LU ON U.usuario_id = LU.usuario_id AND LU.fecha_creacion  >= CURDATE() - INTERVAL 20 DAY
GROUP by U.usuario_id;

SELECT * 
FROM prestamos_usuarios_vw puv
WHERE total_prestamos > 4; -- La vista puede ser usada como una tabla, se le pueden aplicaro condiciones.

DROP VIEW prestamos_usuarios_vw; -- Al igual que las tablas se puede eliminar con el comando DROP

