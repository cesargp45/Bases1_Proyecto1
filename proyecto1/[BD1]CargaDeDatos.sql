--script para llenar las tablas


-- ver todos los triggers de la base de datos------

select trigger_name, trigger_type,
    triggering_event, table_name,
    status, trigger_body
from ALL_TRIGGERS 
----------------------------------------------------

-- eliminar una secuencia----------------------------
DROP SEQUENCE id_tipo;
-----------------------------------------------------

-- crear una secuencia--------------------------------
create sequence  id_tipo minvalue 1 start with 1;
-----------------------------------------------------


-- borrar un trigger----------------------------------
DROP TRIGGER insertar_tipo;
------------------------------------------------------



/****************   INICIO DEL SCRIP PARA LLENAR LAS TABLAS     **************/

--TABLA TIPOS

-- crear una secuencia id tipo--------------------------------
create sequence  id_tipo minvalue 1 start with 1;
-----------------------------------------------------

-- trigger para aumentar el contador del id tipo-----------
CREATE OR REPLACE TRIGGER aum_id_tipo 
BEFORE INSERT ON TIPO 
FOR EACH ROW
BEGIN
  SELECT id_tipo .NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
------------------------------------------------------

-- insertar los datos a la tabla de tipo---------------
INSERT INTO TIPO(nombre)
SELECT  DISTINCT tipo
    FROM TemporalBases1
    WHERE tipo NOT IN (SELECT nombre FROM TIPO);
------------------------------------------------------




--TABLA CATEGORIA

-- crear una secuencia id_ categoria--------------------------------
create sequence  id_categoria minvalue 1 start with 1;
-----------------------------------------------------

-- trigger para aumentar el contador del id_categoria-----------
CREATE OR REPLACE TRIGGER aum_id_categoria 
BEFORE INSERT ON CATEGORIA 
FOR EACH ROW
BEGIN
  SELECT id_categoria.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
------------------------------------------------------

-- insertar los datos a la tabla categoria---------------
INSERT INTO CATEGORIA(nombre)
SELECT  DISTINCT categoria_producto
    FROM TemporalBases1
    WHERE categoria_producto NOT IN (SELECT nombre FROM CATEGORIA);
------------------------------------------------------






--TABLA REGION

-- crear una secuencia id_region--------------------------------
create sequence  id_region minvalue 1 start with 1;
-----------------------------------------------------

-- trigger para aumentar el contador del id_region-----------
CREATE OR REPLACE TRIGGER aum_id_region 
BEFORE INSERT ON REGION 
FOR EACH ROW
BEGIN
  SELECT id_region.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
------------------------------------------------------

-- insertar los datos a la tabla region---------------
INSERT INTO REGION(nombre)
SELECT  DISTINCT region
    FROM TemporalBases1
    WHERE region NOT IN (SELECT nombre FROM REGION);
------------------------------------------------------






--TABLA COMPANIA

-- crear una secuencia id_ compania--------------------------------
create sequence  id_compania minvalue 1 start with 1;
-----------------------------------------------------

-- trigger para aumentar el contador del id_comapania-----------
CREATE OR REPLACE TRIGGER aum_id_compania 
BEFORE INSERT ON COMPANIA 
FOR EACH ROW
BEGIN
  SELECT id_compania.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
------------------------------------------------------

-- insertar los datos a la tabla compania---------------
INSERT INTO REGION(nombre,contacto,correo,telefono)
SELECT  DISTINCT nombre_compania,contacto_compania,correo_compania,telefono_compania
    FROM TemporalBases1
    WHERE nombre_compania NOT IN (SELECT nombre FROM COMPANIA);
------------------------------------------------------



--TABLA CIUDAD

-- crear una secuencia id_ ciudad--------------------------------
create sequence  id_ciudad minvalue 1 start with 1;
-----------------------------------------------------

-- trigger para aumentar el contador del id_ciudad-----------
CREATE OR REPLACE TRIGGER aum_id_ciudad 
BEFORE INSERT ON CIUDAD 
FOR EACH ROW
BEGIN
  SELECT id_ciudad.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
------------------------------------------------------

-- insertar los datos a la tabla ciudad---------------
INSERT INTO CIUDAD(nombre,region)
SELECT DISTINCT ciudad, Region.id
From TemporalBases1, REGION
Where REGION.nombre = TemporalBases1.region

------------------------------------------------------


--TABLA CODIGO_POSTAL

-- crear una secuencia id_ ciudad--------------------------------
create sequence  id_codigo_postal minvalue 1 start with 1;
-----------------------------------------------------

-- trigger para aumentar el contador del id_ciudad-----------
CREATE OR REPLACE TRIGGER aum_id_codigo_postal 
BEFORE INSERT ON CODIGO_POSTAL 
FOR EACH ROW
BEGIN
  SELECT id_codigo_postal.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
------------------------------------------------------

-- insertar los datos a la tabla ciudad---------------
INSERT INTO CODIGO_POSTAL(numero,ciudad)
SELECT DISTINCT codigo_postal,CIUDAD.id
From TemporalBases1,CIUDAD
Where CIUDAD.nombre = TemporalBases1.ciudad

------------------------------------------------------





--TABLA PERSONA

-- crear una secuencia id_ persona--------------------------------
create sequence  id_persona minvalue 1 start with 1;
-----------------------------------------------------

-- trigger para aumentar el contador del id_ciudad-----------
CREATE OR REPLACE TRIGGER aum_id_persona 
BEFORE INSERT ON PERSONA 
FOR EACH ROW
BEGIN
  SELECT id_persona.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
------------------------------------------------------

-- insertar los datos a la tabla ciudad---------------
INSERT INTO PERSONA(nombre,correo,telefono,fecha_registro,direccion,tipo,cod_postal)
SELECT DISTINCT TemporalBases1.nombre,TemporalBases1.correo,TemporalBases1.telefono,TemporalBases1.fecha_registro,TemporalBases1.direccion,TIPO.id,CODIGO_POSTAL.id
From TemporalBases1,TIPO,CODIGO_POSTAL
Where TIPO.nombre = TemporalBases1.tipo AND
CODIGO_POSTAL.numero = TemporalBases1.codigo_postal
------------------------------------------------------




--TABLA Producto

-- crear una secuencia id_ persona--------------------------------
create sequence  id_producto minvalue 1 start with 1;
-----------------------------------------------------

-- trigger para aumentar el contador del id_ciudad-----------
CREATE OR REPLACE TRIGGER aum_id_producto 
BEFORE INSERT ON PRODUCTO
FOR EACH ROW
BEGIN
  SELECT id_producto.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
------------------------------------------------------

-- insertar los datos a la tabla ciudad---------------
INSERT INTO PRODUCTO(nombre,precio,categoria)
SELECT DISTINCT TemporalBases1.producto ,TemporalBases1.precio_unitario,CATEGORIA.id
From TemporalBases1,CATEGORIA
Where CATEGORIA.nombre = TemporalBases1.categoria_producto
------------------------------------------------------




--TABLA TRANSACCION

-- crear una secuencia id_ persona--------------------------------
create sequence  id_transaccion minvalue 1 start with 1;
-----------------------------------------------------

-- trigger para aumentar el contador del id_ciudad-----------
CREATE OR REPLACE TRIGGER aum_id_transaccion 
BEFORE INSERT ON TRANSACCION
FOR EACH ROW
BEGIN
  SELECT id_transaccion.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
------------------------------------------------------

-- insertar los datos a la tabla ciudad---------------
INSERT INTO TRANSACCION(cantidad,precio_total,producto,compania,persona)
SELECT DISTINCT TemporalBases1.cantidad ,TemporalBases1.precio_unitario*TemporalBases1.cantidad ,PRODUCTO.id,COMPANIA.id,
PERSONA.id
From TemporalBases1,PRODUCTO,COMPANIA,PERSONA
Where PRODUCTO.nombre = TemporalBases1.producto AND
COMPANIA.nombre = TemporalBases1.nombre_compania AND
PERSONA.nombre = TemporalBases1.nombre
------------------------------------------------------