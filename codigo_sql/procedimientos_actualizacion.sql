
-- ** Actualizar Precio ** 
CREATE OR REPLACE PROCEDURE actualizar_precio_producto(
		IN arg_codigo INTEGER,
		IN arg_precio NUMERIC)

AS $$
DECLARE
	existencia_productos INTEGER;
BEGIN

	SELECT INTO existencia_productos
		existencia_producto(arg_codigo);
	
	IF existencia_productos = 1 THEN
		UPDATE productos SET precio = arg_precio
			WHERE codigo_producto = arg_codigo;
		RAISE NOTICE 'El precio del producto (%) ha sido actualizado.', arg_codigo;
	ELSE
		RAISE NOTICE 'El producto % NO existe.', arg_codigo;
	END IF;
END;

$$ LANGUAGE 'plpgsql';

--CALL actualizar_precio_producto(101, 1300);




-- ** Actualizar Producto **
CREATE OR REPLACE PROCEDURE actualizar_stock_producto(
		IN arg_codigo INTEGER,
		IN arg_stock INTEGER)

AS $$
DECLARE
	existencia_productos INTEGER;
BEGIN

	SELECT INTO existencia_productos
		existencia_producto(arg_codigo);
	
	IF existencia_productos = 1 THEN
		UPDATE productos SET stock = arg_stock
			WHERE codigo_producto = arg_codigo;
		RAISE NOTICE 'El stock del producto (%) ha sido actualizado a (%).', arg_codigo, arg_stock;
	ELSE
		RAISE NOTICE 'El producto % NO existe.', arg_codigo;
	END IF;
END;

$$ LANGUAGE 'plpgsql';

--CALL actualizar_stock_producto(101, 250);



-- ** Actualizar Direccion **
CREATE OR REPLACE PROCEDURE actualizar_direccion_cliente(
		IN arg_rut VARCHAR(12),
		IN arg_ciudad VARCHAR,
		IN arg_comuna VARCHAR,
		IN arg_calle VARCHAR)

AS 
$$
DECLARE
	existencia_cliente INTEGER;
BEGIN

	SELECT INTO existencia_cliente
		existencia_cliente(arg_rut);
	
	IF existencia_cliente = 1 THEN
		UPDATE clientes
			SET ciudad = arg_ciudad,
				comuna = arg_comuna,
				calle = arg_calle
			WHERE rut_cliente = arg_rut;
		RAISE NOTICE 'La dirección del cliente (%) ha sido actualizado.', arg_rut;
	ELSE
		RAISE NOTICE 'El cliente (%) NO existe.', arg_rut;
	END IF;
END;

$$ LANGUAGE 'plpgsql';

--CALL actualizar_direccion_cliente('27.132.765-8', 'Santiado', 'Quilicura', 'Pasaje Fernando');



-- ** Actualizar Contactos **
CREATE OR REPLACE PROCEDURE actualizar_contacto_cliente(
		IN arg_rut VARCHAR(12),
		IN arg_id_contacto INTEGER,
		IN arg_telefono VARCHAR
		)
AS $$
DECLARE
	existencia_cliente INTEGER;
	existencia_contacto_cliente INTEGER;
BEGIN

	SELECT INTO existencia_cliente
		existencia_cliente(arg_rut);
	
	IF existencia_cliente = 1 THEN
		
		-- Comprobamos que el cliente tengo el id_contacto indicado.
		SELECT COUNT(*) INTO existencia_contacto_cliente FROM contactos_clientes
			WHERE id_contacto = arg_id_contacto;
			
		IF existencia_contacto_cliente = 1 THEN
			UPDATE contactos_clientes
				SET telefono = arg_telefono
				WHERE id_contacto = arg_id_contacto AND rut_cliente = arg_rut;
			RAISE NOTICE 'El contacto del cliente (%) ha sido actualizado.', arg_rut;
		ELSE
			RAISE NOTICE 'El cliente (%) NO tiene el id de contacto (%).', arg_rut, arg_id_contacto;
		END IF;
	ELSE
		RAISE NOTICE 'El cliente (%) NO existe.', arg_rut;
	END IF;
END;

$$ LANGUAGE 'plpgsql';

--CALL actualizar_contacto_cliente('27.132.765-8', 1, '+56 9 4645 4965');


-- ** Actualizar Descripcion **
CREATE OR REPLACE PROCEDURE actualizar_descripcion_categoria(
		IN arg_id_categoria INTEGER,
		IN arg_descripcion TEXT
		)
AS $$
DECLARE
	existencia_categoria INTEGER;
BEGIN
	-- Comprobamos que el cliente tengo el id_contacto indicado.
	SELECT COUNT(*) INTO existencia_categoria
		FROM categoria
			WHERE id_categoria = arg_id_categoria;

	IF existencia_categoria = 1 THEN
		UPDATE categoria
			SET descripcion = arg_descripcion
				WHERE id_categoria = arg_id_categoria;
		RAISE NOTICE 'La categoria (%) ha sido actualizado.', arg_id_categoria;
	ELSE
		RAISE NOTICE 'La categoria (%) NO existe.', arg_id_categoria;
	END IF;
	
END;

$$ LANGUAGE 'plpgsql';

--CALL actualizar_descripcion_categoria(1, 'Mejor calidad');