
-- ** Trigger de Auditoria **
CREATE OR REPLACE FUNCTION log_auditoria_producto()
RETURNS TRIGGER
AS
$$
DECLARE
	-- Variables para almacenar valores antiguos.
	v_codigo INTEGER;
	v_usuario VARCHAR;
	v_nombre VARCHAR;
	v_precio NUMERIC;
	v_stock INTEGER;
	v_rut_proveedor VARCHAR(12);
	v_id_categoria INTEGER;
BEGIN
	-- Almacenamos los valores antiguos en las variables.
	SELECT USER INTO v_usuario;
	v_codigo = OLD.codigo_producto;
	v_nombre = OLD.nombre;
	v_precio = OLD.precio;
	v_stock = OLD.stock;
	v_rut_proveedor = OLD.rut_proveedor;
	v_id_categoria = OLD.id_categoria;
	
	-- Insertamos los valores anteriores en la tabla de Auditoria (auditoria_productos).
	INSERT INTO auditoria_productos(codigo, nombre, precio, stock, rut_proveedor, id_categoria, fecha_modificacion, usuario)
			VALUES(v_codigo, v_nombre, v_precio, v_stock, v_rut_proveedor, v_id_categoria, now(), v_usuario);
	RETURN NEW;
	
END;
$$
LANGUAGE plpgsql;

-- Trigger/Disparador
CREATE TRIGGER trg_auditoria_producto
BEFORE UPDATE
ON productos
FOR EACH ROW
EXECUTE FUNCTION log_auditoria_producto();