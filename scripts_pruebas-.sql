-- Llamadas a los procedimietos y Funciones

-- Procediminetos (Inserción)
CALL ingresar_cliente('24.152.564-1', 'Alejandro Castro', 'RM Santiago', 'Santiago', 'Matta');
CALL ingresar_contacto_cliente('24.152.564-1','9 4665 5963');
CALL ingresar_proveedor('24.152.564-1', 'Distribuidora LTDA', 'Santiago, La Florida 1566', '+56 9 6942 6235', 'www.sitio.com');
CALL crear_categoria('Premiun', 'La mejor calidad');
CALL ingresar_producto(101, 'Maiz Pop Corn', 1250, 100, '24.152.564-1', 1);

-- Procediminetos (Actualización)
CALL actualizar_precio_producto(101, 1300);
CALL actualizar_stock_producto(101, 250);
CALL actualizar_direccion_cliente('24.152.564-1', 'Santiado', 'Ñuñoa', 'Pasaje San Fernando');
CALL actualizar_contacto_cliente('24.152.564-1', 1, '+56 9 4675 4965');
CALL actualizar_descripcion_categoria(1, 'Mejor calidad');

-- Funciones (Leecturas)
SELECT existencia_producto(101::INTEGER);
SELECT existencia_cliente('24.152.564-1'::VARCHAR);
SELECT existencia_proveedor('24.152.564-1'::VARCHAR);

-- Procediminetos (Eliminación)
CALL eliminar_cliente('24.152.564-1');
CALL eliminar_producto(101);
CALL eliminar_categoria(1);
CALL eliminar_proveedor('24.152.564-1');