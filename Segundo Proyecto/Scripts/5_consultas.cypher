/////////////////////////////////////////////////////////
//tipos de cocina por restaurante

MATCH (r:Restaurante)-[:PERTENECE_A]->(t:TipoCocina)

RETURN
r.nombre AS Restaurante,
COUNT(t) AS CantidadTiposCocina

ORDER BY CantidadTiposCocina DESC;

/////////////////////////////////////////////////////////
//Tasa de reservas por restaurante

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
// Gasto promedio por visita

MATCH (:Usuario)-[v:VISITO]->(r:Restaurante)

RETURN
r.nombre AS Restaurante,
ROUND(
AVG(v.consumo),
2
) AS GastoPromedio

ORDER BY GastoPromedio DESC;

//////////////////////////////////////////////////////////
// Frecuencia de visitas por mes

MATCH (:Usuario)-[v:VISITO]->(:Restaurante)

RETURN
v.fechaVisita.year AS Anio,
v.fechaVisita.month AS Mes,
COUNT(*) AS TotalVisitas

ORDER BY Anio, Mes;

//////////////////////////////////////////////////////////
//Restaurante sin visitas recientes - 30 dias

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
// Movilidad de chefs

MATCH (c:Chef)-[:TRABAJA_EN]->(r:Restaurante)

RETURN
c.idChef AS ID,
c.nombre AS Chef,
COUNT(DISTINCT r) AS RestaurantesTrabajados

ORDER BY RestaurantesTrabajados DESC;

//////////////////////////////////////////////////////////
// Variación de precio de platillos

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
// Visitas por tipo de cocina


MATCH (:Usuario)-[:VISITO]->(r:Restaurante)
MATCH (r)-[:PERTENECE_A]->(t:TipoCocina)

RETURN
t.nombreTipo AS TipoCocina,
COUNT(*) AS TotalVisitas

ORDER BY TotalVisitas DESC;

//////////////////////////////////////////////////////////////////////////
// Consulta 9a
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
// Consulta 9B
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
// Consulta 9C
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

//last

MATCH (u:Usuario)
RETURN COUNT(u);
//////////////////////////////////////
//////////////////////////////////////
MATCH (r:Restaurante)
RETURN COUNT(r);
//////////////////////////////////////
//////////////////////////////////////
MATCH (c:Chef)
RETURN COUNT(c);
//////////////////////////////////////
//////////////////////////////////////
MATCH (p:Platillo)
RETURN COUNT(p);
//////////////////////////////////////
//////////////////////////////////////
MATCH (t:TipoCocina)
RETURN COUNT(t);
//////////////////////////////////////
//////////////////////////////////////
MATCH ()-[r]->()
RETURN type(r), COUNT(r);  