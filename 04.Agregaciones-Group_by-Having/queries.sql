-- NIVEL 1 - COUNT
-- 1. Mostrar cuántos episodios existen.
	SELECT 
		COUNT(titulo)
    FROM 
		episodios;
    
-- 2. Mostrar cuántos actores existen.
	SELECT
		COUNT(nombre)
    FROM
		actores;
        
-- 3. Mostrar cuántas series tiene cada género.
-- Primer GROUP BY importante.
	SELECT
		genero,
		COUNT(titulo) AS 'Cantidad de Series'
    FROM
		series
	GROUP BY genero;

-- 4. Mostrar cuántos episodios tiene cada serie.
	SELECT
		s.titulo,
        COUNT(e.titulo) AS 'Cantidad de Episodios'
    FROM
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id
	GROUP BY s.titulo;
    
-- 5. Mostrar cuántas series tiene cada actor.
-- (Pista: actuaciones)
	SELECT
		a.nombre,
		COUNT(ac.serie_id) AS 'Numero de Series'
    FROM
		actores AS a
        JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
	GROUP BY a.nombre;
    
-- NIVEL 2 - AVG y SUM mentalidad
-- 6. Mostrar el promedio de rating_imdb de todos los episodios.
	SELECT
		-- titulo,
        AVG (rating_imdb) AS 'Rating Promedio'
    FROM
		episodios;
    -- GROUP BY titulo; -- existe un error en este ejercicio -- CORREGIDO
    
-- 7. Mostrar el promedio de rating por serie.
-- Aquí mezclas: JOIN AVG GROUP BY
	SELECT
		s.titulo,
        AVG (e.rating_imdb) AS 'Rating promedio'
    FROM
		series AS s
		JOIN episodios AS e ON s.serie_id = e.serie_id
    GROUP BY s.titulo;
    
-- 8. Mostrar la calificación más alta de episodios.
-- Usa: MAX
	SELECT
		MAX(rating_imdb)
    FROM
		episodios;
    
-- 9. Mostrar la calificación más baja.
-- Usa: MIN
	SELECT
		MIN(rating_imdb)
	FROM
		episodios;
        
-- 10. Mostrar promedio de rating por temporada.
	SELECT
		temporada,
        AVG(rating_imdb) AS 'Rating Promedio'
    FROM
		episodios
    GROUP BY temporada;
    
-- NIVEL 3 - HAVING
-- 11. Mostrar géneros con más de 1 serie.
-- Aquí aparece HAVING.
	SELECT
		genero,
        COUNT(serie_id) AS 'Numero de Series'
    FROM
		series
    GROUP BY genero
    HAVING COUNT(serie_id) > 1;
    
-- 12. Mostrar actores que participan en más de 1 serie.
	SELECT
		a.nombre,
        COUNT(ac.serie_id) AS 'Numero de Series'
    FROM
		actores AS a
        JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
    GROUP BY a.nombre
    HAVING COUNT(ac.serie_id) > 1;
    
-- 13. Mostrar series con más de 2 episodios.
	SELECT
		s.titulo,
        COUNT(e.titulo) AS 'Numero de episodios'
    FROM
		series AS s
		JOIN episodios AS e ON s.serie_id = e.serie_id
	GROUP BY s.titulo
    HAVING COUNT(e.titulo) > 2;
    
-- 14. Mostrar temporadas cuyo promedio de rating sea mayor a 8.
	SELECT
		temporada,
        AVG(rating_imdb) AS 'Promedio Rating'
    FROM
		episodios
    GROUP BY temporada
    HAVING AVG(rating_imdb) > 8;
    
-- NIVEL 4 - donde realmente aprendes
-- 15. Mostrar: serie cantidad de episodios promedio rating
	SELECT
		s.titulo,
        COUNT(e.episodio_id) AS 'Cantidad de Episodios',
        AVG(e.rating_imdb) AS 'Promedio Rating'
    FROM
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id
        GROUP BY s.titulo;
        
-- 16. Mostrar: actor cantidad de series donde participa Ordenado de mayor a menor.
	SELECT
		a.nombre,
        COUNT(ac.serie_id) AS 'Cantidad de Series'
    FROM
		actores AS a
        JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
	GROUP BY a.nombre
    ORDER BY COUNT(ac.serie_id) DESC;
    
-- 17. Mostrar: género promedio de rating de sus episodios
	SELECT
		s.genero,
        AVG(e.rating_imdb) AS 'Rating Promedio'
    FROM
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id
    GROUP BY s.genero;
    
-- 18. Mostrar: series con promedio de rating mayor a 8
	SELECT
		s.titulo,
        AVG(e.rating_imdb) AS 'Rating Promedio'
    FROM
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id
	GROUP BY s.titulo
    HAVING AVG(e.rating_imdb) > 8;
    
-- 19. Mostrar: actores que participan en series de género Drama y cuántas series Drama tienen
	SELECT
		a.nombre,
        COUNT(s.genero) AS 'Cantidad de Series' -- corregido
        -- COUNT(ac.serie_id) AS 'Cantidad de Series' -- corregido
	FROM
		actores as a
        JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
        JOIN series AS s ON ac.serie_id = s.serie_id
	WHERE s.genero = 'Drama'
    GROUP BY a.nombre; -- s.genero -- corregido
    
		
    -- se tiene otro error ya que se puede simplificar usando COUNT a s.genero evitando agrupar por s.genero y usar
    -- WHERE para filtrar por drama
    
-- 20. Mostrar: serie episodio más reciente
-- Aquí empiezas a pensar más seriamente.
	SELECT
		s.titulo,
        e.titulo,
        e.fecha_estreno
	FROM
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id
	ORDER BY e.fecha_estreno DESC
    LIMIT 1;  -- El resultado no es lo que pedia el ejercicio y tal vez se deberia usar subconsultas (tema que aun no he estudiado)