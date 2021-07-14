DELIMITER //
CREATE TRIGGER after_insert_actualizacion_libros -- Creacion del trigger
AFTER INSERT ON libros -- Tiempo en el que se ejecutara, el evento y la tabla asociada
FOR EACH ROW -- Se ejecuta por cada registro afectado
BEGIN 
	UPDATE autores SET cantidad_libros = cantidad_libros + 1
	WHERE autor_id = NEW.autor_id; -- Sentencias que se ejecutaran. NEW para INSERT 
END;
//
DELIMITER ;
-- ===================================================================================
DELIMITER //
CREATE TRIGGER after_delete_actualizacion_libros 
AFTER DELETE ON libros 
FOR EACH ROW 
BEGIN 
	UPDATE autores SET cantidad_libros = cantidad_libros - 1
	WHERE autor_id = OLD .autor_id; -- OLD hace referencia al registro eliminado
END;
//
DELIMITER ;
-- ===================================================================================
DELIMITER //
CREATE TRIGGER after_update_actualizacion_libros 
AFTER UPDATE ON libros 
FOR EACH ROW 
BEGIN 
	IF(NEW.autor_id != OLD.autor_id) THEN 
	UPDATE autores SET cantidad_libros = cantidad_libros + 1
	WHERE autor_id = NEW.autor_id;
	UPDATE autores SET cantidad_libros = cantidad_libros - 1
	WHERE autor_id = OLD.autor_id;
	END IF;
END;
//
DELIMITER ;

INSERT INTO libros(autor_id, titulo, fecha_publicacion)
VALUES (1, 'Area 81', '2011-07-01');

SELECT * FROM autores a WHERE autor_id = 1;

SELECT libro_id, titulo FROM libros;

DELETE FROM libros 
WHERE libro_id = 56;

SHOW TRIGGERS; -- Muestra todos los triggers
DROP TRIGGER IF EXISTS libreria_cf.after_delete_actualizacion_libros; -- Elimina el trigger


