-- NIVEL BASICO
-- Listar usuarios mayores de 18
	SELECT *
	FROM usuarios
	WHERE edad > 18;
-- 2. Mostrar nombres y ciudad de usuarios que viven en Bogotá  
	SELECT nombre, ciudad
	FROM usuarios
	WHERE ciudad = 'Bogota';
    
-- 3. Listar usuarios menores de 25 años
	SELECT *
	FROM usuarios
	WHERE edad < 25;
    
-- 4. Mostrar todos los usuarios ordenados por edad (mayor a menor)
	SELECT *
	FROM usuarios
	ORDER BY edad DESC;
    
-- 5. Mostrar solo los primeros dos usuarios
	SELECT *
	FROM usuarios
	LIMIT 2;
    
-- FILTROS COMBINADOS
-- 6. Usuarios mayores de 20 que vivan en Bogotá
	SELECT *
	FROM usuarios
	WHERE edad > 20 AND ciudad = 'Bogota';
    
-- 7. Usuarios menores de 30 que vivan en Cali
	SELECT *
	FROM usuarios
	WHERE edad < 30 OR ciudad = 'Cali';

-- 8. Usuarios que no viven en Medellin
	SELECT *
	FROM usuarios
	WHERE ciudad != 'Medellin';
    
-- 9. Usuarios entre 20 y 30 años
	SELECT *
	FROM usuarios
	WHERE edad BETWEEN 20 AND 30;
    
 -- 10. Usuarios cuyo nombre empiece por 'c'   
    SELECT *
	FROM usuarios
	WHERE nombre LIKE('C%');

-- CONSULTAS SOBRE COMPRAS
-- 11. Listar compras mayores a 100
	SELECT *
	FROM compras
	WHERE precio > 100;
    
-- 12. Compras menores a 500 ordenadas de menor a mayor precio
	SELECT *
	FROM compras
	WHERE precio < 500
    ORDER BY precio;
    
-- 13. Mostrar producto y precio de todas las compras
	SELECT producto, precio
	FROM compras;
    
-- 14. Mostrar las 3 compras mas caras
	SELECT *
	FROM compras
	ORDER BY precio DESC
    LIMIT 3;
    
-- 15. Compras cuyo precio esta entre 100 y 1000
	SELECT *
	FROM compras
	WHERE precio BETWEEN 100 AND 1000;
    
-- FILTROS UN POCO MAS FINOS
-- 16. Compras hechas por usuario_id 1
	SELECT *
	FROM compras
	WHERE usuario_id = 1;
    
-- 17. Compras de usuario_id 2 o 3
	SELECT *
	FROM compras
	WHERE usuario_id = 2 OR usuario_id = 3;
    
-- 18. Compras donde el producto contenga la letra 'o'
	SELECT *
	FROM compras
	WHERE producto LIKE('%O%');
    
-- 19. Compras donde el producto empoece por 'm'
	SELECT *
	FROM compras
	WHERE producto LIKE ('M%');
    
-- 20. Compras que no sean de 'laptop'
	SELECT *
	FROM compras
	WHERE producto != 'laptop';
    
-- MINIRETOS
-- 21. Usuarios de Bogotá mayores de 25 años ordenados por nombre
	SELECT *
	FROM usuarios
	WHERE edad > 25 AND ciudad = 'Bogota'
    ORDER BY nombre;
    
-- 22. Compras mayores de 200 ordenadas de mayor a menor
	SELECT *
	FROM compras
	WHERE precio > 200 
    ORDER BY precio DESC;
    
-- 23. Usuarios cuyo nombre termine en 'a'
	SELECT *
	FROM usuarios
	WHERE nombre LIKE ('%a');
    
-- 24. Compras con precio distinto a 100
	SELECT *
	FROM compras
	WHERE precio != 100;
    
-- 25. Top 2 compras mas baratas
	SELECT *
	FROM compras
	ORDER BY precio
    LIMIT 2;
