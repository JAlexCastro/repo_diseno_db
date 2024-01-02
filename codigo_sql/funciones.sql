
-- ** Existencia de Producto **

--DROP FUNCTION IF EXISTS existencia_producto;

CREATE OR REPLACE FUNCTION existencia_producto(arg_codigo INTEGER)
RETURNS integer AS $$
DECLARE
    v_existencia_producto integer;
BEGIN
    -- Realizar una consulta para verificar la existencia del producto con el código especificado.
    SELECT 1 INTO v_existencia_producto
    FROM productos
    WHERE codigo_producto = arg_codigo
    LIMIT 1;
    
    -- Verificar si se encontró el producto en la base de datos.
    IF FOUND THEN -- Verifica si la última operación de búsqueda encontró al menos una fila.
        RAISE NOTICE 'El producto con código % existe', arg_codigo;
        RETURN 1; -- EL producto existe en la base de datos.
    ELSE
        RAISE NOTICE 'El producto con código % NO existe', arg_codigo;
        RETURN 0; -- Producto no existe en la base de datos.
    END IF;
END;
$$
LANGUAGE plpgsql;

--SELECT existencia_producto(100::INTEGER);




-- ** Existencia de Cliente **

--DROP FUNCTION IF EXISTS existencia_cliente;

CREATE OR REPLACE FUNCTION existencia_cliente(arg_rut VARCHAR(12))
RETURNS integer AS $$
DECLARE
    v_existencia_cliente integer;
BEGIN
    -- Realizar una consulta para verificar la existencia de un cliente con el rut especificado.
    SELECT 1 INTO v_existencia_cliente
    	FROM clientes
    		WHERE rut_cliente = arg_rut
    			LIMIT 1;
    
    -- Verificar si se encontró el cliente en la base de datos.
    IF FOUND THEN -- Verifica si la última operación de búsqueda encontró al menos una fila.
        RAISE NOTICE 'El cliente existe en la base de datos';
        RETURN 1; --Devuelve 1 si el cliente existe.
    ELSE
        RAISE NOTICE 'El rut % NO existe', arg_rut;
        RETURN 0; --Devuelve 0 si el cliente NO existe..
    END IF;
END;
$$
LANGUAGE plpgsql;

--SELECT existencia_cliente('27.132.764-1'::VARCHAR);




-- ** Existencia  de Proveedor **

--DROP FUNCTION IF EXISTS existencia_proveedor;

CREATE OR REPLACE FUNCTION existencia_proveedor(arg_rut VARCHAR(12))
RETURNS integer AS $$
DECLARE
    v_existencia_proveedor integer;
BEGIN
    -- Realizar una consulta para verificar la existencia de un cliente con el rut especificado.
    SELECT 1 INTO v_existencia_proveedor
    	FROM proveedores
    		WHERE rut_proveedor = arg_rut
    			LIMIT 1;
    
    -- Verificar si se encontró el proveedor en la base de datos.
    IF FOUND THEN -- Verifica si la última operación de búsqueda encontró al menos una fila.
        RAISE NOTICE 'El proveedor existe en la base de datos';
        RETURN 1; --Devuelve 1 si el proveedor existe.
    ELSE
        RAISE NOTICE 'El proveedor con rut % NO existe', arg_rut;
        RETURN 0; --Devuelve 0 si el proveedor NO existe..
    END IF;
END;
$$
LANGUAGE plpgsql;

--SELECT existencia_proveedor('27.132.764-1'::VARCHAR);