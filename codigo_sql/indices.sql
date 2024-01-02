-- Índice para la tabla contactos_clientes
CREATE INDEX idx_contactos_clientes_rut_cliente ON contactos_clientes(rut_cliente);

-- Índice para la tabla productos
CREATE INDEX idx_productos_rut_proveedor ON productos(rut_proveedor);

-- Índice para la tabla ventas
CREATE INDEX idx_ventas_rut_cliente ON ventas(rut_cliente);

-- Índice para la tabla auditoria_productos
CREATE INDEX idx_auditoria_productos_rut_proveedor ON auditoria_productos(rut_proveedor);

-- Índice para la tabla auditoria_productos
CREATE INDEX idx_auditoria_productos_id_categoria ON auditoria_productos(id_categoria);
