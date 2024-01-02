CREATE TABLE "clientes" (
  "rut_cliente" VARCHAR(12) PRIMARY KEY,
  "nombre" VARCHAR NOT NULL,
  "ciudad" VARCHAR NOT NULL,
  "comuna" VARCHAR NOT NULL,
  "calle" VARCHAR NOT NULL
);

CREATE TABLE "contactos_clientes" (
  "id_contacto" SERIAL,
  "rut_cliente" VARCHAR(12) NOT NULL,
  "telefono" VARCHAR NOT NULL
);

CREATE TABLE "productos" (
  "codigo_producto" INTEGER PRIMARY KEY,
  "nombre" VARCHAR NOT NULL,
  "precio" FLOAT NOT NULL,
  "stock" FLOAT NOT NULL,
  "rut_proveedor" VARCHAR(12),
  "id_categoria" INTEGER NOT NULL
);

CREATE TABLE "proveedores" (
  "rut_proveedor" VARCHAR(12) PRIMARY KEY,
  "nombre" VARCHAR,
  "direccion" VARCHAR,
  "telefono" VARCHAR,
  "pagina_web" TEXT
);

CREATE TABLE "categoria" (
  "id_categoria" SERIAL PRIMARY KEY,
  "nombre_categoria" VARCHAR NOT NULL,
  "descripcion" VARCHAR NOT NULL
);

CREATE TABLE "ventas" (
  "factura" SERIAL PRIMARY KEY,
  "fecha" TIMESTAMP NOT NULL,
  "rut_cliente" VARCHAR(12) NOT NULL,
  "descuento" NUMERIC NOT NULL,
  "monto_total" NUMERIC NOT NULL
);

CREATE TABLE "ventas_detalle" (
  "factura" INTEGER PRIMARY KEY,
  "monto_total" NUMERIC NOT NULL
);


CREATE TABLE "productos_vendidos" (
  "id_venta" SERIAL PRIMARY KEY,
  "factura" INTEGER NOT NULL,
  "codigo_producto" INTEGER NOT NULL,
  "cantidad" DECIMAL,
  "precio" DECIMAL
);

CREATE TABLE "auditoria_productos" (
  "id_auditoria" SERIAL PRIMARY KEY,
  "codigo" INTEGER NOT NULL,
  "nombre" VARCHAR NOT NULL,
  "precio" DECIMAL NOT NULL,
  "stock" DECIMAL NOT NULL,
  "rut_proveedor" VARCHAR(12) NOT NULL,
  "id_categoria" INTEGER NOT NULL,
  "fecha_modificacion" TIMESTAMP NOT NULL,
  "usuario" VARCHAR NOT NULL
);

ALTER TABLE "productos" ADD FOREIGN KEY ("id_categoria") REFERENCES "categoria" ("id_categoria");

ALTER TABLE "ventas" ADD FOREIGN KEY ("rut_cliente") REFERENCES "clientes" ("rut_cliente");

ALTER TABLE "contactos_clientes" ADD FOREIGN KEY ("rut_cliente") REFERENCES "clientes" ("rut_cliente");

ALTER TABLE "productos" ADD FOREIGN KEY ("rut_proveedor") REFERENCES "proveedores" ("rut_proveedor");

ALTER TABLE "productos_vendidos" ADD FOREIGN KEY ("codigo_producto") REFERENCES "productos" ("codigo_producto");

ALTER TABLE "productos_vendidos" ADD FOREIGN KEY ("factura") REFERENCES "ventas" ("factura");

ALTER TABLE "ventas_detalle" ADD FOREIGN KEY ("factura") REFERENCES "ventas" ("factura");