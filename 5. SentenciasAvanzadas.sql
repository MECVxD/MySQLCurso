SELECT * 
FROM libros
WHERE titulo LIKE 'Harry Potter%'; -- Like permite buscar mediante strings, buscará todos los libros cuyo titulo inicie con Harry Potter

SELECT * 
FROM libros
WHERE titulo LIKE '%AZKABAN'; -- Buscará todos los libros cuyo titulo termine en AZKABAN

SELECT * 
FROM libros
WHERE titulo LIKE '%Y EL%'; -- Buscará todos los titulos que contengan Y EL en alguna parte del titulo

SELECT * 
FROM libros
WHERE titulo LIKE '__b__'; -- Buscará el titulo que tenga 5 letras y cuya tercera letra sea la b

SELECT * 
FROM libros
WHERE titulo LIKE '_a__o%'; -- Buscará el titulo que inicie con una palabra de 6 letras cuya segunda letra sea a y sexta letra sea o

-- Buscar los libros cuyo titulo inicie con H o L

SELECT autor_id, titulo 
FROM libros
WHERE titulo LIKE 'H%' OR titulo LIKE 'L%';

SELECT autor_id, titulo 
FROM libros
WHERE LEFT(titulo, 1) = 'H' OR LEFT(titulo, 1) = 'L';

SELECT titulo
FROM libros
WHERE titulo REGEXP '^[HL]'; -- SE puede usar REGEXP para hacer la busqueda mediante expresiones regulares

SELECT titulo
FROM libros
ORDER BY titulo; -- ORDER BY permite ordenar los resultados por uno o dos campos especificos, por defecto se ordena de manera asendente

SELECT titulo
FROM libros
ORDER BY titulo DESC; -- DESC se usa despues del campo a ordenar, para indicar que el ordenamiento sera descendente

SELECT libro_id, titulo
FROM libros
ORDER BY libro_id AND titulo DESC; -- No solo se pueden ordenar cadenas, sino tambien numeros e incluso mas de un campo

SELECT titulo
FROM libros 
WHERE autor_id = 2 LIMIT 5; -- LIMIT nos permite limitar el numero de registros que devolvera el query

SELECT libro_id, titulo
FROM libros LIMIT 5, 5; -- Permite la paginacion de registros el primer parametro indica desde que registro iniciara, el segundo parametro cuantos registro traera apartir del primer parametro

SELECT COUNT(*) AS TOTAL -- COUNT permite contar cuantos registros hay, tomando en cuenta la tabla completa o un campo en particular 
FROM autores a 
WHERE seudonimo IS NOT NULL;

SELECT SUM(paginas) AS TOTAL -- SUM permite sumar los valores del campo que se pasa como paremtro 
FROM libros;

SELECT MAX(paginas) AS TOTAL -- MAX devuelve el valor mas grande del campo que se pasa como paremtro 
FROM libros;

SELECT MIN(paginas) AS TOTAL -- MIN devuelve el valor mas pequeño del campo que se pasa como paremtro 
FROM libros;

SELECT AVG(paginas) AS TOTAL -- AVG devuelve el promedio de los valores del campo que se pasa como paremtro 
FROM libros;

SELECT autor_id, SUM(paginas) AS TOTAL
FROM libros
GROUP BY autor_id 				-- Permite agrupar los resgistros por un campo en especifico
ORDER BY TOTAL DESC LIMIT 1;	-- Se puede combinar con otras sentencias como el ORDER BY

SELECT autor_id, SUM(paginas) AS TOTAL 
FROM libros
GROUP BY autor_id
HAVING SUM(paginas)>100; -- HAVING permite usar las funciones de agregacion para usar algun tipo de condicion.

SELECT CONCAT(nombre, ' ', apellido)
FROM autores
UNION									-- Union permite unir el resultado de dos consultas distitnas, deben tener el mismo numero de campos en su SELECT
SELECT CONCAT(nombre, ' ', apellidos)
FROM usuarios;

-- Devolver el nombre completo de los autores cuyas ventas son mayores al promedio

SELECT CONCAT(nombre, ' ', apellido) AS NombreCompleto
FROM autores
WHERE autor_id IN (
					SELECT autor_id 
					FROM libros
					GROUP BY autor_id 
					HAVING SUM(ventas) > (
											SELECT AVG(ventas) -- Se pueden realizar subconsultas si son necesarias
											FROM libros)
					);

/*Obtener Disponible, No disponible dependiendo si un titulo existe*/
				
SELECT IF(
	EXISTS(SELECT libro_id
			FROM libros
			WHERE titulo = 'El hobbit'),
			'DISPONIBLE',
			'NO DISPONIBLE'
) AS mensaje;

