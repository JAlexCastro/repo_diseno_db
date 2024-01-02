-- ** Elminar Clientes **
CREATE OR REPLACE PROCEDURE eliminar_cliente(arg_rut VARCHAR(12))
AS
$$
DECLARE
	var_existencia_cliente INTEGER;
BEGIN
	-- Comprobamos la existencia del cliente con nuestra función.
	SELECT existencia_cliente(arg_rut) INTO var_existencia_cliente;
	
	-- Eliminamos el cliente si ya existe.
	IF var_existencia_cliente = 1 THEN
		--Primero Eliminamos los datos de contactos del clientes en la tabla 'contactos_clientes'.
		DELETE FROM contactos_clientes WHERE rut_cliente = arg_rut;
		DELETE FROM clientes WHERE rut_cliente = arg_rut;
		RAISE NOTICE 'El cliente con rut % ha sido eliminado', arg_rut;
	ELSE
		RAISE NOTICE 'El cliente con rut % NO existe.', arg_rut;
	END IF;
END;
$$
LANGUAGE plpgsql;

--CALL eliminar_cliente('27.132.765-8');



-- ** Eliminar Productos **
CREATE OR REPLACE PROCEDURE eliminar_producto(arg_codigo_producto INTEGER)
AS
$$
DECLARE
	var_existencia_producto INTEGER;
BEGIN

	SELECT existencia_producto(arg_codigo_producto) INTO var_existencia_producto;
	
	IF var_existencia_producto = 1 THEN
		DELETE FROM productos
			WHERE codigo_producto = arg_codigo_producto;
		RAISE NOTICE 'El producto (%) ha sido eliminado.', arg_codigo_producto;
	
	ELSE
		RAISE NOTICE 'El producto (%) no existe.', arg_codigo_producto;
	END IF;
END;
$$
LANGUAGE plpgsql;


--CALL eliminar_producto(100);

-- ** Eliminar Categorías **
CREATE OR REPLACE PROCEDURE eliminar_categoria(arg_id_categoria INTEGER)
AS
$$
DECLARE
	var_existencia_categoria INTEGER;
	var_asociacion_categoria INTEGER;
BEGIN
	-- Consultamos por la existencia de la categoría.
	SELECT COUNT(*) INTO var_existencia_categoria
		FROM categoria
			WHERE id_categoria = arg_id_categoria;

	IF var_existencia_categoria >= 1 THEN
		-- Corroboramos la asosiación de la categoría con algún producto.
		SELECT COUNT(*) INTO var_asociacion_categoria
			FROM productos
				WHERE id_categoria = arg_id_categoria;
				
		-- Si la categoría esta asociada algún producto, NO la eliminamos.
		IF var_asociacion_categoria >= 1 THEN
			RAISE NOTICE 'La categoría está asociada a (%) productos. No puede ser eliminada.', var_asociacion_categoria;
		ELSE
			DELETE FROM categoria
				WHERE id_categoria = arg_id_categoria;
			RAISE NOTICE 'La categoria (%) ha sido eliminado.', arg_id_categoria;
		END IF;
	ELSE
		RAISE NOTICE 'La categoria (%) no existe.', arg_id_categoria;
	END IF;
END;
$$
LANGUAGE plpgsql;

--CALL eliminar_categoria(2);


-- **Eliminar Proveedores**
CREATE OR REPLACE PROCEDURE eliminar_proveedor(arg_rut VARCHAR(12))
AS
$$
DECLARE
	var_existencia_proveedor INTEGER;
	var_asociacion_producto INTEGER;
BEGIN
	-- Comprobamos la existencia del proveedor con nuestra función.
	SELECT existencia_proveedor(arg_rut) INTO var_existencia_proveedor;
	
	SELECT COUNT(*) INTO var_asociacion_producto 
		FROM productos
			WHERE rut_proveedor = arg_rut;
	
	-- Eliminamos el proveedor si ya existe.
	IF var_existencia_proveedor = 1 THEN
		-- Comprobamos si el rut del proveedor está asociado algún producto.
		IF var_asociacion_producto >= 1 THEN
			RAISE NOTICE 'El rut del proveedor esta asociado a (%) producto, no puede ser eliminada.', var_asociacion_producto;
		ELSE
			DELETE FROM proveedores WHERE rut_proveedor = arg_rut;
			RAISE NOTICE 'El proveedor con rut % ha sido eliminado', arg_rut;
		END IF;
	ELSE
		RAISE NOTICE 'El proveedor con rut (%) NO existe.', arg_rut;
	END IF;
END;
$$
LANGUAGE plpgsql;

--CALL eliminar_proveedor('27.132.765-9');