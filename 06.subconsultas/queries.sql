-- SUBCONSULTAS
-- 21. Mostrar episodio con el rating MÁS alto.
	SELECT
		titulo,
        rating_imdb
    FROM
		episodios
    WHERE
		rating_imdb = ( 
			SELECT MAX(rating_imdb) FROM episodios);
	
-- 22. Mostrar actores nacidos después del actor más viejo.
	SELECT
		nombre
    FROM
		actores
    WHERE
		fecha_nacimiento > ( 
			SELECT	MIN(fecha_nacimiento) FROM actores);
    
-- 23. Mostrar series cuyo promedio rating sea mayor al promedio global.
	SELECT
		s.titulo,
		AVG(e.rating_imdb)
    FROM
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id
    GROUP BY s.titulo
    HAVING AVG(e.rating_imdb) > ( 
		SELECT AVG(rating_imdb) FROM episodios);
    
-- 24. Mostrar episodios con rating superior al promedio.
	SELECT
		titulo,
		rating_imdb
	FROM
		episodios
	WHERE
		rating_imdb > (
			SELECT AVG(rating_imdb) FROM episodios);
        
-- 25. Mostrar actores que participan en la misma serie que: Henry Cavill
	SELECT
		a.nombre
    FROM
		actores AS a
        JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
        JOIN series AS s ON ac.serie_id = s.serie_id
    WHERE
		s.titulo = ( -- Recomendaron usar IN en vez de = para tenerlo en cuenta
			SELECT s.titulo 
            FROM series AS s 
				JOIN actuaciones AS ac ON s.serie_id = ac.serie_id
				JOIN actores AS a ON ac.actor_id = a.actor_id
			WHERE a.nombre = 'Henry Cavill');
    
-- 26. Mostrar serie con más episodios.
	SELECT
		s.titulo
	FROM
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id
    GROUP BY s.titulo
    HAVING COUNT(e.episodio_id) = (
		SELECT COUNT(episodio_id) FROM episodios GROUP BY serie_id ORDER BY  COUNT(episodio_id) DESC LIMIT 1);
	
-- 27. Mostrar actores que participan en más series que el promedio.
	SELECT
		a.nombre,
        COUNT(ac.serie_id) AS 'Cantidad de series'
	FROM 
		actores AS a
        JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
	GROUP BY a.nombre
    HAVING COUNT(ac.serie_id) > (
			SELECT AVG(cantidad) FROM (
				SELECT COUNT(serie_id) AS 'cantidad' FROM actuaciones GROUP BY actor_id) AS Promedio_Actores);
                
-- 28. Mostrar episodios del año más reciente existente en la BD.
-- subconsulta con MAX(fecha)
	SELECT
		titulo
	FROM
		episodios
	WHERE YEAR(fecha_estreno) = (
			SELECT MAX(YEAR(fecha_estreno)) FROM episodios);
            
-- 29. Mostrar series cuyo número de episodios sea igual al máximo.
	SELECT
		s.titulo
	FROM 
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id
	GROUP BY s.titulo     
	HAVING COUNT(e.episodio_id) = (
		SELECT MAX(cantidad) FROM (   
			SELECT COUNT(episodio_id) AS cantidad FROM episodios GROUP BY serie_id) AS total_episodios);
                    
-- 30. Mostrar actor más joven.
	SELECT
		nombre
	FROM
		actores
	WHERE
		fecha_nacimiento = (
		SELECT	MAX(fecha_nacimiento) FROM actores);