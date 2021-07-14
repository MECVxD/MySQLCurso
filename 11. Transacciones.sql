-- Permiten que se mantenga al integridad de la base de datos por ejemplo los bancos
START TRANSACTION;-- Indica el inicio de la transaccion

SET @libro_id = 21, @usuario_id = 100;

UPDATE libros SET stock = stock - 1
WHERE libro_id = @libro_id;

SELECT stock
FROM libros
WHERE libro_id = @libro_id;

INSERT INTO libros_usuarios(libro_id, usuario_id)
VALUES (@libro_id, @usuario_id);

SELECT *
FROM libros_usuarios; 

SHOW ENGINES;

COMMIT; -- Indica que queremos que se guarden los cambios y finaliza la transaccion
ROLLBACK; -- Revierte todos los cambios hasta antes de iniciar la transaccion y tambien la finaliza