OPTIONS (SKIP=1)
    LOAD DATA
    INFILE '/Proyecto1/DataCenterData.csv'
    INTO TABLE TemporalBases1  
    FIELDS TERMINATED BY ";"
    (
	nombre_compania    ,
	contacto_compania  ,
	correo_compania    ,  
	telefono_compania  "REPLACE(:telefono_compania,'-','')",
	tipo               ,
	nombre             ,
	correo             ,
	telefono           "REPLACE(:telefono,'-','')",
	fecha_registro     "TO_DATE(:fecha_registro,'DD/MM/YYYY','NLS_DATE_LANGUAGE=ENGLISH')",
	direccion          ,
	ciudad             ,
	codigo_postal      ,
	region             ,
	producto           ,
	categoria_producto ,
	cantidad           ,
	precio_unitario    INTEGER EXTERNAL Terminated by Whitespace
    )