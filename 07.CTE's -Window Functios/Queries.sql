-- 1. Mostrar: serie cantidad de episodios Usando CTE.
	WITH seriesDisponibles AS ( SELECT s.titulo AS nombre, COUNT(e.titulo) AS cantidad_episodios 
		 FROM series AS s JOIN episodios AS e ON s.serie_id = e.serie_id GROUP BY s.titulo)
	
	 SELECT 
		nombre,
        cantidad_episodios
	FROM
		seriesDisponibles;
        
-- 2. Crear un CTE con: actor cantidad de series Luego mostrar solo actores con más de 1 serie.
	WITH actoresRepetidos AS (
		SELECT a.nombre AS nombre, COUNT(ac.serie_id) AS cantidad_series FROM actores AS a JOIN actuaciones AS ac ON a.actor_id = ac.actor_id GROUP BY a.nombre)
    
    SELECT 
		nombre,
        cantidad_series
	FROM 
		actoresRepetidos
	WHERE
		cantidad_series > 1;
        
-- 3. Crear un CTE con: serie promedio rating Luego mostrar solo series con promedio > 8.
	WITH mejorValoradas AS (
		SELECT s.titulo AS nombre, AVG(e.rating_imdb) AS ratingPromedio 
        FROM series AS s JOIN episodios AS e ON s.serie_id = e.serie_id GROUP BY s.titulo)
        
	SELECT 
		nombre,
        ratingPromedio
	FROM
		mejorValoradas
	WHERE
		ratingPromedio > 8;
        
-- 4. Crear un CTE con: género cantidad de series Mostrar género con más series.
	WITH seriesPorGenero AS (
		SELECT genero, COUNT(*) AS cantidadSeries FROM series GROUP BY genero) 
	SELECT
		genero,
        cantidadSeries
	FROM
		seriesPorGenero
	ORDER BY cantidadSeries DESC LIMIT 1;
    
-- 5. Crear un CTE con: episodios año estreno Luego mostrar solo episodios posteriores a 2020.
	WITH episodiosRecientes AS (
		SELECT titulo, YEAR(fecha_estreno) AS año_estreno FROM episodios)
	SELECT
		titulo,
        año_estreno
	FROM
		episodiosRecientes
	WHERE
		año_estreno > 2020;
        
-- WINDOW FUNCTIONS
-- ROW_NUMBER()
-- 6. Mostrar: episodio rating número de fila global ordenado por rating DESC
	SELECT
		titulo,
        rating_imdb,
        ROW_NUMBER() OVER(ORDER BY rating_imdb DESC) AS ranking_rating
	FROM 
		episodios;

-- 7. Mostrar: actor fecha nacimiento ROW_NUMBER ordenado del más viejo al más joven
	SELECT
		nombre,
		fecha_nacimiento,
		ROW_NUMBER() OVER(ORDER BY fecha_nacimiento ASC) AS ranking_edad
	FROM
		actores;

-- PARTITION BY
-- 8. Mostrar: serie episodio rating ranking dentro de cada serie Usando:
	SELECT 
		s.titulo,
		e.titulo,
		e.rating_imdb,
		ROW_NUMBER() OVER(PARTITION BY s.titulo ORDER BY rating_imdb DESC) AS ranking_imdb_por_serie
	FROM
		series AS s
		JOIN episodios AS e ON s.serie_id = e.serie_id;

-- 9. Mostrar: género serie dentro de cada género
	SELECT
		genero,
        titulo,
        ROW_NUMBER() OVER(PARTITION BY genero) AS rating_series_por_genero
	FROM
		series;
        
-- RANK()
-- 10. Mostrar: episodios rating ranking global por rating
	SELECT
		titulo,
        rating_imdb,
        RANK() OVER(ORDER BY rating_imdb DESC) AS ranking_global
    FROM
		episodios;
-- 11. Mostrar: actores cantidad de series ranking de actores más activos
	SELECT
		a.nombre,
        COUNT(ac.serie_id) AS cantidad_series,
        RANK() OVER(ORDER BY COUNT(ac.serie_id) DESC) AS ranking_mas_activos
    FROM
		actores AS a
        JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
	GROUP BY a.nombre;
    
-- DENSE_RANK()
-- 12. Mismo ejercicio anterior pero usando: DENSE_RANK() y comparar diferencias.
	SELECT
		a.nombre,
        COUNT(serie_id) AS cantidad_series,
        DENSE_RANK() OVER(ORDER BY COUNT(serie_id) DESC) AS ranking_mas_activos
    FROM
		actores AS a
        JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
    GROUP BY a.nombre;
-- NIVEL MÁS IMPORTANTE
-- 13. Mostrar: serie episodio con mejor rating de cada serie
	WITH mejores_episodios AS (
		SELECT s.titulo AS nombre_serie, e.titulo AS nombre_episodio, e.rating_imdb AS 'Rating',
			ROW_NUMBER() OVER(PARTITION BY s.titulo ORDER BY e.rating_imdb DESC) AS 'Ranking'
        FROM series AS s JOIN episodios AS e ON s.serie_id = e.serie_id)
        
	SELECT
		nombre_serie,
        nombre_episodio,
        Rating
    FROM
		mejores_episodios
	WHERE Ranking = 1
    ORDER BY Rating DESC;	

-- 14. Mostrar: actor más joven de cada serie
	WITH actor_joven_por_serie AS (
		SELECT a.nombre AS nombre, a.fecha_nacimiento AS 'Fecha nacimiento', s.titulo AS 'Serie',
            ROW_NUMBER() OVER(PARTITION BY s.titulo ORDER BY a.fecha_nacimiento DESC) AS 'Ranking'
		FROM actores AS a JOIN actuaciones AS ac ON a.actor_id = ac.actor_id JOIN series AS s ON ac.serie_id = s.serie_id)
        
	SELECT
		nombre,
        Serie
    FROM
		actor_joven_por_serie
	WHERE 
		Ranking = 1
	ORDER BY 'Fecha nacimiento' DESC;
-- 15. Mostrar: top 2 episodios mejor calificados por serie
	WITH top_2 AS (
		SELECT e.titulo AS episodio, e.rating_imdb AS rating, s.titulo AS serie,
			ROW_NUMBER() OVER(PARTITION BY s.titulo ORDER BY e.rating_imdb DESC) AS ranking
		FROM episodios AS e JOIN series AS s ON e.serie_id = s.serie_id)
        
	SELECT
		episodio,
        serie,
        ranking
    FROM
		top_2
    WHERE 
		ranking IN(1,2);