# Tema 08: Diseño base de datos

###  Base de datos de negocio local de venta de toldillos
Base de datos de un negocio dedicado a la fabricacion y venta de toldillos, es un diseño mini-ERP que gestiona y controla lo mas relevante del negocio.

###  Entidades
* Colores
* Telas
* Productos
* Movimientos
* Movimientos_detalle
* Productos_variante
* Tela_color

### Relaciones
* Productos 1:N Productos_variante
* Telas 1:N Tela_color
* Movimientos 1:N Movimientos_detalle

### Cardinalidad
* Colores - Tela_color: Un color puede estar en muchas  combinaciones tela_color, pero cada registro en tela-color  tiene un solo color 1:N
* Telas - Tela-color: Una tela puede existir en varios colores 1:N
* Telas - Colores: Una tela tiene muchos colores, un color puede estar en muchas telas N:M
* Productos - Productos_variante: Un producto puede tener muchas variantes, cada variante pertence a un solo producto 1:N
* Colores - Productos_variante: Un color puede estar en muchas variantes 1:N
* Telas - Productos_variante: Una tela puede usarse en muchas variantes 1:N
* Movimientos - Movimiento_detalle: Un movimiento puede tener muchos detalles 1:N
* Productos_variante - Movimientos_detalle: Una variante puede aparecer muchas veces en movimientos 1:N
