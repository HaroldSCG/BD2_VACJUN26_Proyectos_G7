// =====================================================
// CARGA MASIV
// =====================================================

// =====================================================
// USUARIO
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///usuarios.csv' AS row

MERGE (u:Usuario {
    idUsuario: toInteger(row.idUsuario)
})

SET
u.nombre = row.nombre,
u.email = row.email,
u.edad = toInteger(row.edad),
u.pais = row.pais;

// =====================================================
// RESTAURANTE
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///restaurantes.csv' AS row

MERGE (r:Restaurante {
    idRestaurante: toInteger(row.idRestaurante)
})

SET
r.nombre = row.nombre,
r.anioApertura = toInteger(row.anioApertura),
r.rangoPrecios = row.rangoPrecios,
r.descripcion = row.descripcion;

// =====================================================
// CHEF
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///chefs.csv' AS row

MERGE (c:Chef {
    idChef: toInteger(row.idChef)
})

SET
c.nombre = row.nombre,
c.fechaNacimiento = date(row.fechaNacimiento),
c.nacionalidad = row.nacionalidad;

// =====================================================
// PLATILLO
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///platillos.csv' AS row

MERGE (p:Platillo {
    idPlatillo: toInteger(row.idPlatillo)
})

SET
p.nombre = row.nombre,
p.precioBase = toFloat(row.precioBase),
p.descripcion = row.descripcion;

// =====================================================
// TIPOCOCINA
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///tiposcocina.csv' AS row

MERGE (t:TipoCocina {
    idTipoCocina: toInteger(row.idTipoCocina)
})

SET
t.nombreTipo = row.nombreTipo,
t.descripcion = row.descripcion;

// #################################################### #
// ==================================================== #
// #################################################### #

// =====================================================
// PERTENECE_A
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///pertenece_a.csv' AS row

MATCH (r:Restaurante {
    idRestaurante: toInteger(row.idRestaurante)
})

MATCH (t:TipoCocina {
    idTipoCocina: toInteger(row.idTipoCocina)
})

MERGE (r)-[:PERTENECE_A]->(t);

// =====================================================
// LE_GUSTA
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///le_gusta.csv' AS row

MATCH (u:Usuario {
    idUsuario: toInteger(row.idUsuario)
})

MATCH (t:TipoCocina {
    idTipoCocina: toInteger(row.idTipoCocina)
})

MERGE (u)-[rel:LE_GUSTA]->(t)

SET
rel.nivelInteres = toInteger(row.nivelInteres);

// =====================================================
// TRABAJA_EN
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///trabaja_en.csv' AS row

MATCH (c:Chef {
    idChef: toInteger(row.idChef)
})

MATCH (r:Restaurante {
    idRestaurante: toInteger(row.idRestaurante)
})

MERGE (c)-[rel:TRABAJA_EN]->(r)

SET
rel.fechaInicio = date(row.fechaInicio),
rel.puesto = row.puesto;

// =====================================================
// PREPARA
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///prepara.csv' AS row

MATCH (c:Chef {
    idChef: toInteger(row.idChef)
})

MATCH (p:Platillo {
    idPlatillo: toInteger(row.idPlatillo)
})

MERGE (c)-[rel:PREPARA]->(p)

SET
rel.estilo = row.estilo,
rel.especialidad = row.especialidad;

// =====================================================
// OFRECE
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///ofrece.csv' AS row

MATCH (r:Restaurante {
    idRestaurante: toInteger(row.idRestaurante)
})

MATCH (p:Platillo {
    idPlatillo: toInteger(row.idPlatillo)
})

MERGE (r)-[rel:OFRECE]->(p)

SET
rel.precio = toFloat(row.precio),
rel.disponible = (
    row.disponible = "true"
);

// =====================================================
// ES_AMIGO_DE
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///es_amigo_de.csv' AS row

MATCH (u1:Usuario {
    idUsuario: toInteger(row.idUsuario1)
})

MATCH (u2:Usuario {
    idUsuario: toInteger(row.idUsuario2)
})

MERGE (u1)-[rel:ES_AMIGO_DE]->(u2)

SET
rel.fechaAmistad = date(row.fechaAmistad);

// =====================================================
// VISITO
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///visito.csv' AS row

MATCH (u:Usuario {
    idUsuario: toInteger(row.idUsuario)
})

MATCH (r:Restaurante {
    idRestaurante: toInteger(row.idRestaurante)
})

MERGE (u)-[rel:VISITO {
    fechaVisita: date(row.fechaVisita)
}]->(r)

SET
rel.consumo = toFloat(row.consumo),
rel.conReserva = (
    row.conReserva = "true"
);

// =====================================================
// CALIFICO
// =====================================================

LOAD CSV WITH HEADERS
FROM 'file:///califico.csv' AS row

MATCH (u:Usuario {
    idUsuario: toInteger(row.idUsuario)
})

MATCH (r:Restaurante {
    idRestaurante: toInteger(row.idRestaurante)
})

MERGE (u)-[rel:CALIFICO {
    fecha: date(row.fecha)
}]->(r)

SET
rel.puntuacion = toInteger(row.puntuacion),
rel.comentario = row.comentario;

// =====================================================
// VALIDACIONES RELATION
// =====================================================
// verificar si funciona
MATCH ()-[r]->()
RETURN type(r), COUNT(r);


// =====================================================
// VALIDACIONES NODOS
// =====================================================

MATCH (u:Usuario)
RETURN COUNT(u) AS Usuarios;

MATCH (r:Restaurante)
RETURN COUNT(r) AS Restaurantes;

MATCH (c:Chef)
RETURN COUNT(c) AS Chefs;

MATCH (p:Platillo)
RETURN COUNT(p) AS Platillos;

MATCH (t:TipoCocina)
RETURN COUNT(t) AS TiposCocina;