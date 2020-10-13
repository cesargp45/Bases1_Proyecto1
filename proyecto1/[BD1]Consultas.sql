
-- Reporte 1
SELECT PERSONA.nombre,PERSONA.telefono ,TRANSACCION.id ,TRANSACCION.precio_total 
FROM TRANSACCION,PERSONA
WHERE precio_total = (SELECT MAX(precio_total) FROM TRANSACCION) AND
TRANSACCION.persona = PERSONA.id AND
PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'P')
ORDER BY id


--Reporte 2

SELECT 
PERSONA.id as numCliente,
PERSONA.nombre as nombre,
sum(TRANSACCION.cantidad) as Total
FROM
TRANSACCION,
PERSONA,
TIPO
WHERE 
PERSONA.id = TRANSACCION.persona AND
TIPO.id = PERSONA.tipo AND
TIPO.nombre = 'C'
GROUP BY PERSONA.id, PERSONA.nombre
ORDER BY Total DESC
FETCH FIRST 1 ROW ONLY


--Reporte 3
SELECT direccion,region,ciudad,cod FROM
(SELECT  direccion, REGION.nombre as region,CIUDAD.nombre as ciudad,CODIGO_POSTAL.numero as cod,
   COUNT(*) as solicitudes
 FROM TRANSACCION,PERSONA,CODIGO_POSTAL,CIUDAD,REGION,TIPO
 WHERE
    PERSONA.id = TRANSACCION.id AND
    CODIGO_POSTAL.id = PERSONA.cod_postal AND
    CIUDAD.id = CODIGO_POSTAL.ciudad AND
    REGION.id = CIUDAD.region AND
    TIPO.id = PERSONA.tipo AND
    TIPO.nombre = 'P'
    GROUP BY direccion,CODIGO_POSTAL.numero,CIUDAD.nombre,REGION.nombre
    ORDER BY solicitudes DESC
    FETCH FIRST 1 ROWS ONLY)
    
 UNION
 
 SELECT direccion,region,ciudad,cod FROM
(SELECT  direccion, REGION.nombre as region,CIUDAD.nombre as ciudad,CODIGO_POSTAL.numero as cod,
   COUNT(*) as solicitudes
 FROM TRANSACCION,PERSONA,CODIGO_POSTAL,CIUDAD,REGION,TIPO
 WHERE
    PERSONA.id = TRANSACCION.id AND
    CODIGO_POSTAL.id = PERSONA.cod_postal AND
    CIUDAD.id = CODIGO_POSTAL.ciudad AND
    REGION.id = CIUDAD.region AND
    TIPO.id = PERSONA.tipo AND
    TIPO.nombre = 'P'
    GROUP BY direccion,CODIGO_POSTAL.numero,CIUDAD.nombre,REGION.nombre
    ORDER BY solicitudes ASC
    FETCH FIRST 1 ROWS ONLY)



-- Reporte 4
      

SELECT idp as num_cliente,nom AS CLIENTE,veces as NO_ORDENES ,total as TOTAL FROM(
 SELECT nombre as nom ,idper as idp,COUNT(*) as veces,SUM(tot) as total,SUM(cant) as canti FROM
(SELECT TRANSACCION.persona as idper,PERSONA.nombre as nombre,PRODUCTO.nombre as producto,CATEGORIA.nombre as categoria, transaccion.precio_total as tot,transaccion.cantidad as cant
FROM TRANSACCION,PRODUCTO,CATEGORIA,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'C')AND
      TRANSACCION.producto = PRODUCTO.id AND
      PRODUCTO.categoria = CATEGORIA.id AND
      CATEGORIA.nombre = 'Cheese'
       )
      
  GROUP BY nombre, idper  
  ORDER BY canti DESC
  FETCH FIRST 5 ROWS ONLY)

      


--Reporte 5


SELECT nomb AS NOMBRE,to_char(fech,'MM')as MES,total as TOTAL FROM(
 SELECT nombre as nomb ,fecha as fech,sum(tot) as total FROM
(SELECT TRANSACCION.persona as idper,PERSONA.nombre as nombre,PERSONA.fecha_registro as fecha, transaccion.precio_total as tot
FROM TRANSACCION,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'C') )    
  GROUP BY  nombre,fecha 
  ORDER BY total DESC
  FETCH FIRST 1 ROWS ONLY)


UNION

SELECT nomb AS NOMBRE,to_char(fech,'MM')as MES,total as TOTAL FROM(
 SELECT nombre as nomb ,fecha as fech,sum(tot) as total FROM
(SELECT TRANSACCION.persona as idper,PERSONA.nombre as nombre,PERSONA.fecha_registro as fecha, transaccion.precio_total as tot
FROM TRANSACCION,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'C') )    
  GROUP BY  nombre,fecha 
  ORDER BY total asc
  FETCH FIRST 1 ROWS ONLY)



--Reporte 6
SELECT cat AS CATEGORIA,total as TOTAL FROM(
 SELECT categoria as cat ,sum(tot) as total FROM
(SELECT TRANSACCION.persona as idper,PERSONA.nombre as nombre,PRODUCTO.nombre as producto,CATEGORIA.nombre as categoria, transaccion.precio_total as tot
FROM TRANSACCION,PRODUCTO,CATEGORIA,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'C')AND
      TRANSACCION.producto = PRODUCTO.id AND
      PRODUCTO.categoria = CATEGORIA.id )
      
  GROUP BY categoria   
  ORDER BY total DESC
  FETCH FIRST 1 ROWS ONLY)
      
  UNION      

SELECT cat AS CATEGORIA,total as TOTAL FROM(
 SELECT categoria as cat ,sum(tot) as total FROM
(SELECT TRANSACCION.persona as idper,PERSONA.nombre as nombre,PRODUCTO.nombre as producto,CATEGORIA.nombre as categoria, transaccion.precio_total as tot
FROM TRANSACCION,PRODUCTO,CATEGORIA,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'C')AND
      TRANSACCION.producto = PRODUCTO.id AND
      PRODUCTO.categoria = CATEGORIA.id )
      
  GROUP BY categoria   
  ORDER BY total asc
  FETCH FIRST 1 ROWS ONLY)



--Reporte 7

SELECT nom AS PROVEEDOR FROM(
 SELECT nombre as nom ,sum(tot) as total FROM
(SELECT TRANSACCION.persona as idper,PERSONA.nombre as nombre,PRODUCTO.nombre as producto,CATEGORIA.nombre as categoria, transaccion.precio_total as tot
FROM TRANSACCION,PRODUCTO,CATEGORIA,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'P')AND
      TRANSACCION.producto = PRODUCTO.id AND
      PRODUCTO.categoria = CATEGORIA.id AND
      CATEGORIA.nombre = 'Fresh Vegetables'
       )
      
  GROUP BY nombre   
  ORDER BY total DESC
  FETCH FIRST 5 ROWS ONLY)


--Reporte 8

SELECT nomb AS NOMBRE,direc as DIRECCION, reg as REGION, ciu as CIUDAD,cod as CP,total as TOTAL FROM(
SELECT nombre as nomb ,direccion as direc,region as reg,ciudad as ciu,cp as cod,sum(tot) as total FROM
(
SELECT 
TRANSACCION.persona as idper,
PERSONA.nombre as nombre,
transaccion.precio_total as tot,
CODIGO_POSTAL.numero as cp,
CIUDAD.nombre as ciudad,
REGION.nombre as region,
PERSONA.direccion as direccion

FROM TRANSACCION,PERSONA,CIUDAD,REGION,CODIGO_POSTAL
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'C') AND
      CODIGO_POSTAL.id = PERSONA.cod_postal AND
      CIUDAD.id = CODIGO_POSTAL.ciudad AND
      REGION.id = CIUDAD.REGION)
      
  GROUP BY  nombre,direccion,region,ciudad,cp 
  ORDER BY total DESC
  FETCH FIRST 1 ROWS ONLY)


UNION


SELECT nomb AS NOMBRE,direc as DIRECCION, reg as REGION, ciu as CIUDAD,cod as CP,total as TOTAL FROM(
SELECT nombre as nomb ,direccion as direc,region as reg,ciudad as ciu,cp as cod,sum(tot) as total FROM
(
SELECT 
TRANSACCION.persona as idper,
PERSONA.nombre as nombre,
transaccion.precio_total as tot,
CODIGO_POSTAL.numero as cp,
CIUDAD.nombre as ciudad,
REGION.nombre as region,
PERSONA.direccion as direccion

FROM TRANSACCION,PERSONA,CIUDAD,REGION,CODIGO_POSTAL
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'C') AND
      CODIGO_POSTAL.id = PERSONA.cod_postal AND
      CIUDAD.id = CODIGO_POSTAL.ciudad AND
      REGION.id = CIUDAD.REGION)
      
  GROUP BY  nombre,direccion,region,ciudad,cp 
  ORDER BY total asc
  FETCH FIRST 1 ROWS ONLY)


--Reporte 9

SELECT PERSONA.nombre as nombre,PERSONA.telefono as telefono,TRANSACCION.id as orden, transaccion.precio_total as tot
FROM TRANSACCION,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'P') AND
      TRANSACCION.precio_total = 
 (SELECT MIN(tot) FROM
(SELECT TRANSACCION.persona as idper,PERSONA.nombre as nombre,PERSONA.telefono as telefono,TRANSACCION.id as orden, transaccion.precio_total as tot
FROM TRANSACCION,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'P')
)
)



--Reporte 10
      



SELECT nom AS CLIENTE FROM(
 SELECT nombre as nom ,sum(tot) as total FROM
(SELECT TRANSACCION.persona as idper,PERSONA.nombre as nombre,PRODUCTO.nombre as producto,CATEGORIA.nombre as categoria, transaccion.precio_total as tot
FROM TRANSACCION,PRODUCTO,CATEGORIA,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'C')AND
      TRANSACCION.producto = PRODUCTO.id AND
      PRODUCTO.categoria = CATEGORIA.id AND
      CATEGORIA.nombre = 'Seafood'
       )
      
  GROUP BY nombre   
  ORDER BY total DESC
  FETCH FIRST 10 ROWS ONLY)



SELECT nom AS CLIENTE FROM(
 SELECT nombre as nom ,sum(tot) as total FROM
(SELECT TRANSACCION.persona as idper,PERSONA.nombre as nombre,PRODUCTO.nombre as producto,CATEGORIA.nombre as categoria, transaccion.cantidad as tot
FROM TRANSACCION,PRODUCTO,CATEGORIA,PERSONA
WHERE TRANSACCION.persona = PERSONA.id AND
      PERSONA.tipo = (SELECT id FROM TIPO WHERE TIPO.nombre = 'C')AND
      TRANSACCION.producto = PRODUCTO.id AND
      PRODUCTO.categoria = CATEGORIA.id AND
      CATEGORIA.nombre = 'Seafood'
       )
      
  GROUP BY nombre   
  ORDER BY total DESC
  FETCH FIRST 10 ROWS ONLY)


