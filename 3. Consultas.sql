SELECT libro_id, titulo 	-- Indica los campos a regresar
FROM libros					-- Indica desde que tabla se deben recuperar los datos
WHERE titulo = 'Carrie';	-- Agrega una condicion para la busqueda puede usar los operadores relacionles "<, >, <=, >=, =, !=, <>"

/*
 * MySQL acepta operadores logicos como AND, OR y NOT
 * */

SELECT libro_id, titulo 	
FROM libros					      
WHERE titulo = 'Carrie' AND autor_id=1 AND ventas = 10; -- Si se cumplen todas las condiciones traera el resultado en caso contrario no traera nada

SELECT libro_id, titulo 	
FROM libros					      
WHERE titulo = 'Carrie' OR autor_id=1 OR ventas = 10;

SELECT *
FROM libros 
WHERE (autor_id = 1 AND titulo = 'Carrie') OR  (autor_id = 5 AND titulo = 'El hobbit');

SELECT *
FROM  autores
WHERE  seudonimo IS NULL; -- Null no puede ser tratado como un tipo de dato por eso se debe usar el IS

SELECT *
FROM  autores
WHERE  seudonimo IS NOT NULL;

SELECT *
FROM  autores
WHERE  seudonimo <=> NULL;

SELECT titulo, fecha_publicacion 
FROM  libros
WHERE  fecha_publicacion BETWEEN '1995-01-01'AND '2015-01-31'; -- BETWEEN nos permite establecer un rango dependiendo del tipo de dato del campo afectado

SELECT * 
FROM libros
WHERE autor_id IN (1, 2); -- IN nos permite buscar a manera de lista.

SELECT DISTINCT titulo -- DISTINCT nos trae registros unicos en caso de que haya repetidos y va despues del SELECT 
FROM libros;

SELECT books.autor_id AS autor, books.titulo AS nombre -- AS nos permite establecer un alias a un campo o tabla para hacer mas agil la escritura del query
FROM libros AS books; 

UPDATE libros SET descripcion = 'Nuevo cambio', ventas = 50 -- UPDATE nos permite actualizar registros pueden usarse condiciones con el WHERE
WHERE titulo ='El resplandor';

DELETE FROM libros -- Nos permite eliminar registros de la tabal, podemos apoyarnos del WHERE para condicionar la eliminacion 
WHERE autor_id=1;

DELETE FROM autores -- Si la PK de la tabla esta funcionando con FK de otra tabla y no se tiene habilitada la eliminacion en cascada no se ejecutara la sentencia
WHERE autor_id =1;

ALTER TABLE libros ADD FOREIGN KEY (autor_id) REFERENCES autores(autor_id) ON DELETE CASCADE;-- Eliminara los resigtros sin alterar la integridad de la tabla

TRUNCATE TABLE libros; -- TRUNCATE limpia todos los registros de la tabla, no puede usar la clausula WHERE y resetea la definicion de la tabla por ejemplo el ID
						-- TRUNCATE no permite recuperar datos, a comparacion con DELETE 