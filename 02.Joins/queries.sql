-- Nivel 1 (entender INNER JOIN)
-- 1. Mostrar nombre del usuario y producto comprado
	SELECT 
		nombre,
        producto
	FROM
		compras
		JOIN usuarios ON compras.usuario_id = usuarios.id; 
        
-- 2. Mostrar nombre, ciudad y producto
	SELECT
		nombre,
        ciudad,
        producto
	FROM
		usuarios
        JOIN compras ON usuarios.id = compras.usuario_id;
        
-- 3. Listar todas las compras con el nombre del usuario
	SELECT 
		u.nombre,
        producto,
        precio
    FROM
		compras AS c
        LEFT JOIN usuarios AS U ON c.usuario_id = u.id;
        
-- 4. Mostrar nombre del usuario y precio de cada compra
	SELECT
		nombre,
        precio
	FROM
		compras
        JOIN usuarios ON compras.usuario_id = usuarios.id;
        
-- 5. Listar usuarios que han hecho compras (sin repetirlos)
	SELECT DISTINCT
		u.nombre
	FROM
		compras AS c
        JOIN usuarios AS u ON c.usuario_id = u.id;
        
-- Nivel 2 (filtrar con JOIN)
-- 6. Mostrar compras mayores a 200 con nombre del usuario
	SELECT
		u.nombre,
        producto,
        precio
	FROM
		compras AS c
        JOIN usuarios AS u ON c.usuario_id = u.id
	WHERE
		precio > 200;
        
-- 7. Mostrar usuarios de Bogotá y lo que compraron
	SELECT
		u.nombre,
        c.producto
	FROM
		usuarios AS u
        JOIN compras AS c ON u.id = c.usuario_id
	WHERE
		ciudad = 'Bogota';
        
-- 8. Mostrar compras hechas por usuarios mayores de 25
	SELECT
		u.nombre,
        c.producto,
        c.precio
	FROM
		compras AS c
        JOIN usuarios AS u ON c.usuario_id = u.id
	WHERE
		 edad > 25;
         
-- 9. Mostrar productos comprados por usuarios de Cali
	SELECT
		producto
	FROM
		compras AS c
        JOIN usuarios AS u ON c.usuario_id = u.id
	WHERE
		ciudad = 'Cali';
        
-- 10. Mostrar compras de “Laptop” con nombre del usuario
	SELECT
		u.nombre,
        producto
	FROM
		compras AS c
        JOIN usuarios AS u ON c.usuario_id = u.id
	WHERE
		producto = 'Laptop';
        
-- Nivel 3 (pensar un poco más)
-- 11. Mostrar usuarios que NO han comprado nada
	SELECT
		nombre,
        producto
	FROM 
		usuarios AS u
		LEFT JOIN compras AS c ON u.id = c.usuario_id
	WHERE
		producto = null; -- null no se usa con comparador se debe usar IS
        
-- 12. Mostrar todos los usuarios aunque no tengan compras
	SELECT
		nombre,
        producto
	FROM 
		usuarios AS u
        LEFT JOIN compras AS c ON u.id = c.usuario_id;
    
-- 13. Mostrar todas las compras aunque el usuario no exista (si puedes forzarlo)
	SELECT
		nombre,
        producto
	FROM 
		compras AS c
        RIGHT JOIN usuarios AS u ON c.usuario_id = u.id; -- se debe cambiar el orden de las tablas o usar LEFT JOIN emn consulta actual
        
-- 14. Mostrar usuarios y total de compras (solo listar, sin SUM todavía, ojo)
	SELECT
		nombre,
		producto
	FROM
		usuarios AS u
		JOIN compras AS c ON u.id = c.usuario_id;

-- 15. Listar usuarios con sus compras ordenadas por precio
	SELECT
		nombre,
        producto,
        precio
	FROM
		usuarios AS u
        JOIN compras AS c ON u.id = c.usuario_id
	ORDER BY 
		precio;