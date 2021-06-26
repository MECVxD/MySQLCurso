DELIMITER // /*Cambia el delimitador de una sentencia para que se pueda agregar una función o un procedimiento alamcenado*/

CREATE FUNCTION agregar_dias(fecha DATE, dias INT) -- Sentencia para crear una función e indicar sus parametros
RETURNS DATE -- Tipo de dato que retornará la función
BEGIN -- Inicio de la logica
	RETURN fecha + INTERVAL dias DAY; 
END// -- Fin de la logica

DELIMITER ;

SET @now= CURDATE(); 

SELECT agregar_dias(@now , 60); -- Ejemplo de uso de la nueva función

SELECT name 
FROM mysql.proc 
WHERE db = DATABASE() AND  `type` = 'FUNCTION'; -- Nos permite listar las funciones que tenemos en nuestra base de datos.

DELIMITER // 

CREATE FUNCTION obtener_paginas()
RETURNS INT
BEGIN
	SET @paginas = (SELECT (ROUND(RAND() * 100) * 4 ));
	RETURN @paginas;
END//

DELIMITER ;

SELECT obtener_paginas();

UPDATE  libros  SET paginas=obtener_paginas();

SELECT * FROM libros;
