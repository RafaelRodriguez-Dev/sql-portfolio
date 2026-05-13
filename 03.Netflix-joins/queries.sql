-- EJERCICIOS JOIN (sin resolver)
-- 🟢 NIVEL 1 - INNER JOIN básico
-- 1. Mostrar: título de la serie, título del episodio
	SELECT
		s.titulo AS 'titulo de la serie',
        e.titulo AS 'Titulo de episodio'
    FROM
		series AS s
        JOIN episodios AS e ON s.serie_id = e.serie_id;
        
-- 2. Mostrar: título de la serie, temporada, rating_imdb
	SELECT
		s.titulo,
        e.temporada,
        e.rating_imdb
    FROM 
		series AS s
		JOIN episodios AS e ON s.serie_id = e.serie_id;
        
-- 3. Mostrar: nombre del actor, serie donde actúa
	SELECT
		a.nombre,
        s.titulo AS 'Titulo de la Serie'
    FROM
		actuaciones AS ac
		JOIN actores AS a ON ac.actor_id = a.actor_id
        JOIN series AS s ON ac.serie_id = s.serie_id;
        
-- 4. Mostrar: nombre del actor, personaje interpretado, serie
	SELECT
		a.nombre,
        ac.personaje,
        s.titulo
    FROM 
		actuaciones AS ac
		JOIN actores AS a ON a.actor_id = ac.actor_id
        JOIN series AS s ON s.serie_id = ac.serie_id;
        
-- 5. Mostrar: episodios con rating mayor a 8, junto con el nombre de la serie
	SELECT
		e.titulo,
        e.rating_imdb,
        s.titulo
    FROM 
		episodios AS e
		JOIN series AS s ON e.serie_id = s.serie_id
    WHERE
		rating_imdb > 8;
	
-- NIVEL 2 - LEFT JOIN (IMPORTANTE)
-- 6. Mostrar TODAS las series: incluso si no tienen episodios
	SELECT
		s.titulo,
        e. titulo AS 'Episodios'
    FROM
		series AS s
		LEFT JOIN episodios AS e ON s.serie_id = e.serie_id;
        
-- 7. Mostrar TODOS los actores: incluso si no participan en ninguna serie
	SELECT
		a.nombre,
        s.titulo
    FROM
		actuaciones AS ac
		LEFT JOIN actores AS a ON ac.actor_id = a.actor_id
        LEFT JOIN series AS s ON ac.serie_id = s.serie_id;
	
-- 8. Mostrar TODAS las series: incluso si no tienen actores relacionados
	SELECT
		s.titulo,
		a.nombre        
    FROM
		actuaciones AS ac
		LEFT JOIN series AS s ON ac.serie_id = s.serie_id
        LEFT JOIN actores AS a ON ac.actor_id = a.actor_id;

-- 9. Mostrar TODOS los episodios: incluso si accidentalmente una serie no existiera
	-- (Este es más conceptual por las foreign keys)
	SELECT
		e.titulo,
        s.titulo
    FROM
		episodios AS e
		LEFT JOIN series AS s ON e.serie_id = s.serie_id;
        
-- NIVEL 3 - múltiples JOINs
-- 10. Mostrar: actor, personaje, serie, género de la serie
	SELECT 
		a.nombre,
        ac.personaje,
        s.titulo,
        s.genero
    FROM 
		actuaciones AS ac
		JOIN actores AS a ON ac.actor_id = a.actor_id
        JOIN series AS s ON ac.serie_id = s.serie_id;
        
-- 11. Mostrar: serie, episodio, actor relacionado con la serie
	-- ⚠️ Aquí ya cruzas: -- Series -- Episodios -- Actuaciones -- Actores
    SELECT 
		s.titulo AS 'Serie',
        e.titulo AS 'Episodio',
        a.nombre AS 'Actor Relacionado'
    FROM
		series AS s
		JOIN episodios AS e ON s.serie_id = e.serie_id
        JOIN actuaciones AS ac ON ac.serie_id = s.serie_id
        JOIN actores AS a ON a.actor_id = ac.actor_id;

-- 12. Mostrar: actores que participan en series de género “Drama”
	SELECT
		nombre
    FROM
		actores AS a
		JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
        JOIN series	AS s ON ac.serie_id = s.serie_id
	WHERE
		s.genero = 'Drama';
        
-- 13. Mostrar: episodios de series donde actúe cierto actor
	SELECT
		e.titulo
    FROM
		episodios AS e
		JOIN actuaciones AS ac ON e.serie_id = ac.serie_id
        JOIN series AS s ON ac.serie_id = s.serie_id
        JOIN actores AS a ON ac.actor_id = a.actor_id
    WHERE
		a.nombre = 'Henry Cavill';
		
-- 14. Mostrar: nombre del actor, cantidad visual de series en las que participa
-- (NO COUNT todavía)
	SELECT
		a.nombre,
        s.titulo
    FROM
		actores AS a
		JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
        JOIN series AS s ON ac.serie_id = s.serie_id;

-- 🔴 NIVEL 4 - donde realmente aprendes
-- 15. Mostrar todas las series: aunque no tengan episodios, aunque no tengan actores
-- 👉 aquí probablemente usarás varios LEFT JOIN
	SELECT 
		DISTINCT (s.titulo)
    FROM
		series AS s
		LEFT JOIN episodios AS e ON s.serie_id = e.serie_id
        LEFT JOIN actuaciones AS ac ON s.serie_id = ac.serie_id;
        
-- 16. Mostrar: series con episodios estrenados después de cierta fecha
	SELECT
		s.titulo
    FROM
		series AS s
		JOIN episodios AS e ON s.serie_id = e.serie_id
	WHERE
		e.fecha_estreno > '2020-01-15';   -- aun no he visto como trabajar con fechas; se hace correccion despues de buscar un poco de información

-- 17. Mostrar: actores nacidos después del 1990, junto con sus series
SELECT
	a.nombre,
    s.titulo
FROM
	actores AS a
    JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
	JOIN series AS s ON ac.serie_id = s.serie_id
WHERE
	a.fecha_nacimiento > '1990-01-01'; -- se que esta mal, sigo sin saber como manejar fechas; se hace correcion despues de buscar un poco de información

-- 18. Mostrar: series cuyo género sea "Ciencia ficción" y sus actores ordenados alfabéticamente
	SELECT
		s.titulo,
        a.nombre
    FROM
		series AS s
        JOIN actuaciones AS ac ON s.serie_id = ac.serie_id
        JOIN actores AS a ON ac.actor_id = a.actor_id
	WHERE
		genero = 'Ciencia ficción'
	ORDER BY a.nombre;
    
-- 19. Mostrar: episodios ordenados: primero por temporada luego por rating
	SELECT
		titulo,
        temporada,
        rating_imdb AS 'Rating'
    FROM
		episodios
	ORDER BY temporada, rating_imdb;

-- 20. Mostrar: actores que NO participan en ninguna serie
-- (Este debes poder resolverlo fluido ya)
	SELECT
		a.nombre
    FROM
		actores AS a
		LEFT JOIN actuaciones AS ac ON a.actor_id = ac.actor_id
	WHERE
		ac.serie_id IN (NULL); -- despues de repasar tema se debe escribir IS NULL en vez de IN(NULL)