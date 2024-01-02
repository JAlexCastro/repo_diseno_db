-- ** Ingresar Cliente **

CREATE OR REPLACE PROCEDURE ingresar_cliente(
    IN arg_rut VARCHAR,
    IN arg_nombre VARCHAR,
    IN arg_ciudad VARCHAR,
    IN arg_comuna VARCHAR,
    IN arg_calle VARCHAR
)

AS $$

DECLARE
	var_existencia_cliente INTEGER;
BEGIN
	-- Comprobamos la existencia del cliente con nuestra función.
	SELECT existencia_cliente(arg_rut::VARCHAR) INTO var_existencia_cliente;
	
	-- Si el cliente NO existe, lo insertamos.
	IF var_existencia_cliente = 0 THEN
		INSERT INTO clientes(rut_cliente, nombre, ciudad, comuna, calle)
			VALUES(arg_rut, arg_nombre, arg_ciudad, arg_comuna, arg_calle);	
		RAISE NOTICE 'Cliente % ingresado.', arg_rut;
	
	ELSE
		RAISE NOTICE 'Cliente con rut % ya existe.', arg_rut;
	END IF;

END;

$$ LANGUAGE 'plpgsql';

--CALL ingresar_cliente('27.132.765-8', 'Alejandro Castro', 'Santiago', 'Quilicura', 'Matta');


-- ** 1.1 Ingresar Contacto del clientes **
CREATE OR REPLACE PROCEDURE ingresar_contacto_cliente(
    IN arg_rut VARCHAR,
    IN arg_contacto VARCHAR
)
AS
$$

DECLARE
	var_existencia_cliente INTEGER;
	var_existencia_contacto INTEGER;
BEGIN
	-- Comprobamos la existencia del cliente con nuestra función.
	SELECT existencia_cliente(arg_rut) INTO var_existencia_cliente;
	
	-- Si el cliente existe, comprobamos que los datos de contactos del cliente no existan.
	IF var_existencia_cliente = 1 THEN
	
		SELECT COUNT(*) INTO var_existencia_contacto  
			FROM contactos_clientes 
				WHERE telefono = arg_contacto;
				
		-- Si el contacto NO existe, lo insertamos en la tabla.
		IF var_existencia_contacto = 0 THEN
		
			INSERT INTO contactos_clientes( rut_cliente, telefono)
				VALUES(arg_rut, arg_contacto);
			RAISE NOTICE 'Contactos del cliente % ingresado.', arg_rut;
		ELSE
			RAISE NOTICE 'El contactos del cliente % ya existe.', arg_rut;
		END IF;
	ELSE
		RAISE NOTICE 'Cliente con rut % NO existe.', arg_rut;
	END IF;
END;

$$ LANGUAGE 'plpgsql';

--CALL ingresar_contacto_cliente('27.132.765-9','9 4645 5963');




-- ** 2. Ingresar Proveedores **
CREATE OR REPLACE PROCEDURE ingresar_proveedor(
    IN arg_rut VARCHAR,
    IN arg_nombre VARCHAR,
    IN arg_direccion VARCHAR,
    IN arg_telefono VARCHAR,
    IN arg_pagina_web TEXT
)

AS $$

DECLARE
	var_existencia_proveedor INTEGER;
BEGIN
	-- Comprobamos la existencia del proveedor con nuestra función.
	SELECT existencia_proveedor(arg_rut::VARCHAR) INTO var_existencia_proveedor;
	
	-- Si el proveedor NO existe, lo insertamos.
	IF var_existencia_proveedor = 0 THEN
		INSERT INTO proveedores(rut_proveedor, nombre, direccion, telefono, pagina_web)
			VALUES(arg_rut, arg_nombre, arg_direccion, arg_telefono, arg_pagina_web);	
		RAISE NOTICE 'Proveedor % ingresado.', arg_rut;
	
	ELSE
		RAISE NOTICE 'Proveedor con rut % ya existe.', arg_rut;
	END IF;

END;

$$ LANGUAGE plpgsql;

--CALL ingresar_proveedor('27.132.765-8', 'Distribuidora LTDA', 'Santiago Quilicura 1566', '+56 9 4658 6235', 'www.sitio.com');



-- ** 3. Crear Categorias **
CREATE OR REPLACE PROCEDURE crear_categoria(
    IN arg_nombre VARCHAR,
    IN arg_descripcion TEXT
)

AS $$

DECLARE
	var_existencia_categoria INTEGER;
BEGIN
	-- Comprobamos la existencia del proveedor con nuestra función.
	SELECT * INTO var_existencia_categoria FROM categoria
		WHERE nombre_categoria = arg_nombre;
	
	-- Si la categoria NO existe, la insertamos.
	IF FOUND THEN
		RAISE NOTICE 'La categoría % ya existe.', arg_nombre;
	
	ELSE
		INSERT INTO categoria(nombre_categoria, descripcion)
			VALUES(arg_nombre, arg_descripcion);
			
		RAISE NOTICE 'La categoría % ha sido creada.', arg_nombre;
	END IF;

END;

$$ LANGUAGE plpgsql;

--CALL crear_categoria('Premiun', 'La mejor calidad');





-- ** 4. Ingresar producto **
CREATE OR REPLACE PROCEDURE ingresar_producto(
	IN arg_codigo_producto INTEGER,
  	IN arg_nombre VARCHAR,
	IN arg_precio NUMERIC,
	IN arg_stock INTEGER,
	IN arg_rut_proveedor VARCHAR(12), 
	IN arg_id_categoria INTEGER )

AS 
$$

DECLARE
	var_existencia_producto INTEGER;
	var_existencia_categoria INTEGER;
	var_existencia_proveedor INTEGER;
	
BEGIN
	-- Comprobamos la existencia del proveedor con nuestra función.
	SELECT INTO var_existencia_proveedor 
		existencia_proveedor(arg_rut_proveedor);
		
	-- Comprobamos la existencia de la categoría.
	SELECT COUNT(*) INTO var_existencia_categoria 
		FROM categoria
			WHERE id_categoria = arg_id_categoria;
	
	-- Comprobamos la existencia del codigo con nuestra función.
	SELECT INTO var_existencia_producto 
		existencia_producto(arg_codigo_producto);
	
	
	-- Condicionales
	
	IF var_existencia_proveedor >= 1 THEN -- Si el preveedor existe.
		RAISE NOTICE 'El prooveedor (%) existe.', arg_rut_proveedor;
		
		IF var_existencia_categoria >= 1 THEN -- Si la categoría existe.
			RAISE NOTICE 'La categoria (%) existe.', arg_id_categoria;
			
			IF var_existencia_producto = 0 THEN -- Si NO existe un producto con el mismo codigo.
				INSERT INTO productos(codigo_producto, nombre, precio, stock, rut_proveedor, id_categoria)
							VALUES (arg_codigo_producto, arg_nombre, arg_precio,
									arg_stock, arg_rut_proveedor, arg_id_categoria);
				RAISE NOTICE 'El producto (%, %) ha sido agregado', arg_codigo_producto, arg_nombre;
			ELSE
				RAISE NOTICE 'El producto (%) NO fue agregado', arg_codigo_producto;
			END IF;
			
		ELSE
			RAISE NOTICE 'La categoria (%) NO existe.', arg_id_categoria;
		END IF;
	ELSE
		RAISE NOTICE 'El proveedor (%) NO existe.', arg_rut_proveedor;
	END IF;
END;

$$
LANGUAGE 'plpgsql';

--CALL ingresar_producto(101, 'Maiz Pop Corn', 1250, 100, '27.132.765-8', 1);
