CREATE TABLE TIPO(
    id number CONSTRAINT pk_tipo PRIMARY KEY NOT NULL,
    nombre varchar(50) NOT NULL
);

CREATE TABLE REGION(
    id number CONSTRAINT pk_region PRIMARY KEY NOT NULL,
    nombre varchar(150) NOT NULL
);

CREATE TABLE COMPANIA(
    id number CONSTRAINT pk_compania PRIMARY KEY NOT NULL,
    nombre varchar(150) NOT NULL,
    contacto varchar(150) NOT NULL,
    correo varchar(150) NOT NULL,
    telefono varchar(20) NOT NULL
);

CREATE TABLE CATEGORIA(
    id number CONSTRAINT pk_categoria PRIMARY KEY NOT NULL,
    nombre varchar(150) NOT NULL
);




CREATE TABLE PRODUCTO(
    id number CONSTRAINT pk_producto PRIMARY KEY NOT NULL,
    nombre varchar(150) NOT NULL,
    precio number(12,2) NOT NULL,
    categoria number NOT NULL,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria) REFERENCES CATEGORIA(id)
);



CREATE TABLE CIUDAD(
    id number CONSTRAINT pk_ciudad PRIMARY KEY NOT NULL,
    nombre varchar(150) NOT NULL,
    region number NOT NULL,
    CONSTRAINT fk_ciudad_region FOREIGN KEY (region) REFERENCES REGION(id)
);


CREATE TABLE CODIGO_POSTAL(
    id number CONSTRAINT pk_codigo_postal PRIMARY KEY NOT NULL,
    numero number NOT NULL,
    ciudad number NOT NULL,
    CONSTRAINT fk_postal_ciudad FOREIGN KEY (ciudad) REFERENCES CIUDAD(id)
);

CREATE TABLE PERSONA(
    id number CONSTRAINT pk_persona PRIMARY KEY NOT NULL,
    nombre varchar(150) NOT NULL,
    correo varchar(150) NOT NULL,
    telefono varchar(20) NOT NULL,
    fecha_registro date NOT NULL,
    direccion varchar(300) NOT NULL,
    tipo number NOT NULL,
    cod_postal number NOT NULL,
    CONSTRAINT fk_persona_tipo FOREIGN KEY (tipo) REFERENCES TIPO(id),
    CONSTRAINT fk_persona_postal FOREIGN KEY (cod_postal) REFERENCES CODIGO_POSTAL(id) 
);


CREATE TABLE TRANSACCION(
    id number NOT NULL,
    cantidad number NOT NULL,
    precio_total number(12,2) NOT NULL,
    producto number NOT NULL,
    compania number NOT NULL, 
    persona number NOT NULL,
    CONSTRAINT fk_transaccion_producto FOREIGN KEY (producto) REFERENCES PRODUCTO(id),
    CONSTRAINT fk_transaccion_compania FOREIGN KEY (compania) REFERENCES COMPANIA(id),
    CONSTRAINT fk_transaccion_persona FOREIGN KEY (persona) REFERENCES PERSONA(id),
    CONSTRAINT pk_transaccion PRIMARY KEY(id, producto, compania, persona)
);


