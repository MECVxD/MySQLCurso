SELECT CONCAT(nombre, ' ', apellido) AS NombreCompleto -- CONCAT permite concatenar datos
FROM autores;

SELECT LENGTH('Hola Mundo'); -- LENGTH permite calcular la longitud de un dato

SELECT * 
FROM autores
WHERE LENGTH(nombre)>7;

SELECT UPPER(nombre), LOWER(nombre) -- UPPER, LOWER permite traer los datos en MAYUSCULAS o minusculas respectivamente 
FROM autores;

SELECT TRIM("    cadena con espacios al inicio y al final  "); -- TRIM elimina espacios al principio y al final del string

SELECT 
LEFT("Esta es una cadena de caracteres", 5) AS SUBSTRING_IZQUIERDO, -- LEFT permite traer los caracteres indicados en su parametro a la izquierda
RIGHT("Esta es una cadena de caracteres", 10) AS SUBSTRING_DERECHO; -- RIGHT permite traer los caracteres indicados en su parametro a la derecha

SELECT *
FROM libros
WHERE LEFT(titulo, 12)='Harry Potter';

SELECT RAND(); -- Genera un numero aleatorio

SELECT ROUND(RAND()*100); -- ROUND redondea un numero

SELECT TRUNCATE(1.123456789, 3); -- Truca el numero de decimales tomando solo los que se indican en su 2do parametro

SELECT POW(2, 16); -- Eleva el primer parametro al segundo parametro

SET @now = NOW(); -- NOW() permite consultar la fecha y hora del servidor

SELECT 
SECOND(@now), -- SECOND() devuelve los segundos
MINUTE(@now), -- MINUTE() devuelve los minutos
HOUR(@now),  -- HOUR() devuelve las horas	
MONTH(@now), -- MONTH() devuelve el mes
YEAR(@now); -- YEAR() devuelve el año

SELECT 
DAYOFWEEK(@now), -- DAYOFWEEK() devuelve el dia de la semana 1=Domingo y 7=Sabado
DAYOFMONTH(@now), -- DAYOFMONTH() devuelve el dia del mes
DAYOFYEAR(@now); -- DAYOFYEAR() devuelve el dia del año

SELECT 
DATE(@now); -- DATE() convierte el parametro a tipo DATE

SELECT *
FROM libros
WHERE DATE(fecha_creacion)=CURDATE(); -- CURDATE() trae la fecha actual.

SELECT CURDATE();

SELECT @now + INTERVAL 30 DAY; -- Permite sumar dias, meses o años a una fecha

SELECT IF(10>9, "El número es mayor", "El número no es mayor"); -- Evalua una condicion y devuelve un mensaje si esta es verdadera o falsa

SELECT IF(paginas=0, "El libro no posee páginas", paginas)
FROM libros; 

SELECT IFNULL(seudonimo, "El autor no cuenta con un seudónimo") -- Evalua si un valor es nulo y devuelve un mensaje
FROM autores;