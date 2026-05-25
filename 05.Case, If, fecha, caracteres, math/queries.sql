-- FUNCIONES DE TEXTO
-- 1. Mostrar nombres de actores en MAYÚSCULA.
	SELECT
		UPPER(nombre)
    FROM
		actores;
        
-- 2. Mostrar títulos de series en minúscula.
	SELECT
		LOWER(titulo)
    FROM
		series;
        
-- 3. Mostrar: nombre actor cantidad de caracteres del nombre
	SELECT 
		nombre,
		LENGTH(nombre) AS 'Cantidad de Caracteres'
    FROM
		actores;
        
-- 4. Mostrar: Actor: Henry Cavill -- Formato completo concatenado.
SELECT
	CONCAT('Actor: ' , nombre) AS 'Modificacion'
FROM
	actores;
    
-- 5. Mostrar los primeros 3 caracteres de cada serie.
	SELECT
		titulo,
		SUBSTRING(titulo, 1, 3) AS 'Modificacion'
    FROM
		series;
        
-- 6. Reemplazar la palabra: The por: La en títulos de series.
	SELECT
		titulo,
		REPLACE(titulo, 'The', 'La') AS 'Modificacion'
    FROM
		series;
        
-- 7. Mostrar títulos sin espacios al inicio/final.
	SELECT
		TRIM(titulo) 
    FROM
		series;
        
-- CASE e IF
-- 8. Mostrar: episodio rating clasificación: Excelente (>8) Bueno (>6) Regular
	SELECT
		titulo,
        rating_imdb,
        CASE 
			WHEN rating_imdb > 8 THEN 'Excelente'
            WHEN rating_imdb > 6 THEN 'Bueno'
            ELSE 'Regular' END AS 'Clasificacion'
    FROM
		episodios;
        
-- 9. Mostrar actores: “Veterano” si nació antes de 1985 “Moderno” si nació después
	SELECT
		nombre,
        fecha_nacimiento,
        IF(YEAR(fecha_nacimiento) < 1985, 'Veterano', 'Moderno') AS 'Categoria'
    FROM
		actores;
        
-- 10. Mostrar: serie categoría: “Larga” si tiene más de 3 episodios “Corta” si no
	SELECT
		s.titulo,
        COUNT(e.titulo) AS 'Cantidad de Episodios',
        IF(COUNT(e.titulo) > 3, 'Larga', 'Corta') AS 'Categoria'
    FROM
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id
	GROUP BY s.titulo;
    
-- 11. mostrar: “Tiene rating” “Sin rating” según rating_imdb
	SELECT
		s.titulo,
        IF(e.rating_imdb <= 0, 'Sin rating', 'Tiene rating') AS 'Clasificacion' -- ¿Porque no pude usar NULL? 
    FROM                                                                        -- Respuesta: Confusion usando NULL (escribi IN NULL y debe ser IS NULL)
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id; 

-- FUNCIONES NUMÉRICAS
-- 12. Mostrar rating redondeado.
	SELECT
		ROUND(rating_imdb)
	FROM
		episodios;
        
-- 13. Mostrar rating redondeado hacia arriba.
	SELECT 
		CEIL(rating_imdb)
	FROM
		episodios;

-- 14. Mostrar rating redondeado hacia abajo.
	SELECT
    FLOOR(rating_imdb)
    FROM
		episodios;
        
-- 15. Mostrar: rating original ROUND CEIL FLOOR en la misma consulta.
	SELECT
		rating_imdb,
        ROUND(rating_imdb),
        CEIL(rating_imdb),
        FLOOR(rating_imdb)
    FROM
		episodios;
        
-- FUNCIONES DE FECHA
-- 16. Mostrar: episodio año estreno
	SELECT
		titulo,
        YEAR(fecha_estreno) AS 'Año Estreno'
    FROM
		episodios;
        
-- 17. Mostrar: actor año nacimiento
	SELECT
		nombre,
        YEAR(fecha_nacimiento) AS 'Año Nacimiento'
    FROM
		actores;
    
-- 18. Mostrar episodios estrenados en 2022.
	SELECT
		titulo,
        YEAR(fecha_estreno) AS 'Fecha de Estreno'
    FROM
		episodios
    WHERE
		YEAR(fecha_estreno) = 2022;
        
-- 19. Mostrar cuántos años han pasado desde estreno.
	SELECT
		titulo,
        fecha_estreno,
        DATEDIFF(CURDATE(), fecha_estreno) AS 'Tiempo Transcurrido'
    FROM
		episodios; -- consulta muestra dias y no años se debe usar TIMESTAMPDIFF(YEAR, fecha_estreno, CURDATE())
    
-- 20. Mostrar fecha actual.
	SELECT
		NOW(); -- Alternativa puede ser CURDATE()