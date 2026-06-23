/////////////////////////////////////////////////////////
// Consulta 1: tipos de cocina por restaurante

MATCH (r:Restaurante)-[:PERTENECE_A]->(t:TipoCocina)

RETURN
r.nombre AS Restaurante,
COUNT(t) AS CantidadTiposCocina

ORDER BY CantidadTiposCocina DESC;

/////////////////////////////////////////////////////////
// Consulta 2: Tasa de reservas por restaurante

MATCH (r:Restaurante)<-[v:VISITO]-(:Usuario)

RETURN
r.nombre AS Restaurante,
COUNT(v) AS TotalVisitas,

SUM(
CASE
WHEN v.conReserva THEN 1
ELSE 0
END
) AS VisitasConReserva,

ROUND(
100.0 *
SUM(
CASE
WHEN v.conReserva THEN 1
ELSE 0
END
) / COUNT(v),
2
) AS PorcentajeReservas

ORDER BY PorcentajeReservas DESC;

//////////////////////////////////////////////////////////
// Consulta 3: Gasto promedio por visita

MATCH (:Usuario)-[v:VISITO]->(r:Restaurante)

RETURN
r.nombre AS Restaurante,
ROUND(
AVG(v.consumo),
2
) AS GastoPromedio

ORDER BY GastoPromedio DESC;

//////////////////////////////////////////////////////////
// Consulta 4: Frecuencia de visitas por mes

MATCH (:Usuario)-[v:VISITO]->(:Restaurante)

RETURN
v.fechaVisita.year AS Anio,
v.fechaVisita.month AS Mes,
COUNT(*) AS TotalVisitas

ORDER BY Anio, Mes;

//////////////////////////////////////////////////////////
// Consulta 5: Restaurante sin visitas recientes - 30 dias

MATCH (r:Restaurante)

OPTIONAL MATCH (:Usuario)-[v:VISITO]->(r)

WITH
r,
MAX(v.fechaVisita) AS UltimaVisita

WHERE
UltimaVisita IS NULL
OR
UltimaVisita < date() - duration('P30D')

RETURN
r.nombre AS Restaurante,
UltimaVisita

ORDER BY UltimaVisita;

//////////////////////////////////////////////////////////
// Consulta 6: Movilidad de chefs

MATCH (c:Chef)-[:TRABAJA_EN]->(r:Restaurante)

RETURN
c.idChef AS ID,
c.nombre AS Chef,
COUNT(DISTINCT r) AS RestaurantesTrabajados

ORDER BY RestaurantesTrabajados DESC;

//////////////////////////////////////////////////////////
// Consulta 7: Variación de precio de platillos

MATCH (r:Restaurante)-[o:OFRECE]->(p:Platillo)

RETURN
p.nombre AS Platillo,

MIN(o.precio) AS PrecioMinimo,
MAX(o.precio) AS PrecioMaximo,

ROUND(
MAX(o.precio) - MIN(o.precio),
2
) AS Diferencia

ORDER BY Diferencia DESC;

//////////////////////////////////////////////////////////
// Consulta 8: Visitas por tipo de cocina


MATCH (:Usuario)-[:VISITO]->(r:Restaurante)
MATCH (r)-[:PERTENECE_A]->(t:TipoCocina)

RETURN
t.nombreTipo AS TipoCocina,
COUNT(*) AS TotalVisitas

ORDER BY TotalVisitas DESC;

//////////////////////////////////////////////////////////
// Consulta 9: Restaurantes populares entre amigos (Graph Social VISUALIZABLE)

MATCH (u:Usuario {idUsuario: 1})-[:ES_AMIGO_DE]-(amigo:Usuario)
MATCH (amigo)-[v:VISITO]->(r:Restaurante)
WHERE NOT EXISTS { MATCH (u)-[:VISITO]->(r) }
RETURN u, amigo, v, r
LIMIT 20;

//////////////////////////////////////////////////////////////////////////
// Consulta 10A
// Recomendación basada en chefs compartidos con restaurantes visitados
// =====================================================

MATCH (u:Usuario {idUsuario: 1})
      -[:VISITO]->(r1:Restaurante)

MATCH (r1)<-[:TRABAJA_EN]-(c:Chef)
      -[:TRABAJA_EN]->(r2:Restaurante)

WHERE r1 <> r2

AND NOT EXISTS {
    MATCH (u)-[:VISITO]->(r2)
}

RETURN
r2.idRestaurante AS ID,
r2.nombre AS RestauranteRecomendado,
COUNT(DISTINCT c) AS ChefsCompartidos

ORDER BY ChefsCompartidos DESC,
         RestauranteRecomendado

LIMIT 10;



///////////////////////////////////////////////////
// Consulta 10B
// Recomendación basada en restaurantes bien valorados por el usuario
// =====================================================

MATCH (u:Usuario {idUsuario: 1})
      -[cal:CALIFICO]->(r1:Restaurante)

WHERE cal.puntuacion >= 4

MATCH (r1)<-[:TRABAJA_EN]-(c:Chef)
      -[:TRABAJA_EN]->(r2:Restaurante)

WHERE r1 <> r2

AND NOT EXISTS {
    MATCH (u)-[:VISITO]->(r2)
}

RETURN
r2.idRestaurante AS ID,
r2.nombre AS RestauranteRecomendado,
COUNT(DISTINCT c) AS ChefsCompartidos

ORDER BY ChefsCompartidos DESC,
         RestauranteRecomendado

LIMIT 10;

///////////////////////////////////////////////////////
// Consulta 10C
// Recomendación avanzada - combinacion historial de visitas, calificaciones positivas y chefs compartidos
// =====================================================

MATCH (u:Usuario {idUsuario: 1})

MATCH (u)-[cal:CALIFICO]->(r1:Restaurante)

WHERE cal.puntuacion >= 4

MATCH (r1)<-[:TRABAJA_EN]-(c:Chef)
      -[:TRABAJA_EN]->(r2:Restaurante)

WHERE r1 <> r2

AND NOT EXISTS {
    MATCH (u)-[:VISITO]->(r2)
}

RETURN
r2.idRestaurante AS ID,
r2.nombre AS RestauranteRecomendado,
COUNT(DISTINCT c) AS ChefsCompartidos,
AVG(cal.puntuacion) AS PromedioCalificacionOrigen

ORDER BY
ChefsCompartidos DESC,
PromedioCalificacionOrigen DESC

LIMIT 10;

//////////////////////////////////////////////////////////
// Análisis de Redes 1: Grados de Separación (Shortest Path)
// =====================================================

MATCH p = shortestPath((u1:Usuario {idUsuario: 1})-[:ES_AMIGO_DE*..5]-(u2:Usuario {idUsuario: 10}))
RETURN p;

//////////////////////////////////////////////////////////
// Análisis de Redes 2: Restaurantes Altamente Conectados (VISUALIZABLE)
// =====================================================

MATCH (r:Restaurante)<-[rel]-(nodoExterno)
WITH r, COUNT(rel) as Conexiones
ORDER BY Conexiones DESC LIMIT 5
MATCH (r)<-[rel]-(nodoExterno)
RETURN r, rel, nodoExterno LIMIT 150;

//////////////////////////////////////////////////////////
// Validacion 1: Cantidad de Usuarios
MATCH (u:Usuario)
RETURN COUNT(u);
//////////////////////////////////////
//////////////////////////////////////
// Validacion 2: Cantidad de Restaurantes
MATCH (r:Restaurante)
RETURN COUNT(r);
//////////////////////////////////////
//////////////////////////////////////
// Validacion 3: Cantidad de Chefs
MATCH (c:Chef)
RETURN COUNT(c);
//////////////////////////////////////
//////////////////////////////////////
// Validacion 4: Cantidad de Platillos
MATCH (p:Platillo)
RETURN COUNT(p);
//////////////////////////////////////
//////////////////////////////////////
// Validacion 5: Cantidad de Tipos de Cocina
MATCH (t:TipoCocina)
RETURN COUNT(t);
//////////////////////////////////////
//////////////////////////////////////
// Validacion 6: Cantidad y Tipo de Relaciones
MATCH ()-[r]->()
RETURN type(r), COUNT(r);  