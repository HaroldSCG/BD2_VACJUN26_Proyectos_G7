// =====================================================
// Dataset de Prueba -- Neo4j + Cypher
// =====================================================

// =====================================================
// TIPOCOCINA
// =====================================================

CREATE
(tc1:TipoCocina {
    idTipoCocina: 1,
    nombreTipo: "Italiana",
    descripcion: "Pasta, pizza y cocina mediterránea"
}),

(tc2:TipoCocina {
    idTipoCocina: 2,
    nombreTipo: "Mexicana",
    descripcion: "Tacos, burritos y comida tradicional mexicana"
}),


(tc3:TipoCocina {
    idTipoCocina: 3,
    nombreTipo: "Japonesa",
    descripcion: "Sushi, ramen y cocina oriental"
});

// =====================================================
// PLATILLOS
// =====================================================

CREATE
(p1:Platillo {
    idPlatillo: 1,
    nombre: "Pizza Margarita",
    precioBase: 90.00,
    descripcion: "Pizza tradicional italiana"
}),

(p2:Platillo {
    idPlatillo: 2,
    nombre: "Lasagna",
    precioBase: 95.00,
    descripcion: "Lasagna de carne"
}),

(p3:Platillo {
    idPlatillo: 3,
    nombre: "Tacos al Pastor",
    precioBase: 45.00,
    descripcion: "Tacos tradicionales mexicanos"
}),

(p4:Platillo {
    idPlatillo: 4,
    nombre: "Sushi Roll",
    precioBase: 120.00,
    descripcion: "Sushi variado"
}),

(p5:Platillo {
    idPlatillo: 5,
    nombre: "Ramen",
    precioBase: 110.00,
    descripcion: "Sopa japonesa"
});

// =====================================================
// CHEFS
// =====================================================

CREATE
(c1:Chef {
    idChef: 1,
    nombre: "Harold C",
    fechaNacimiento: date("2003-07-13"),
    nacionalidad: "Guatemalteco"
}),

(c2:Chef {
    idChef: 2,
    nombre: "Giulia Bianchi",
    fechaNacimiento: date("1985-09-12"),
    nacionalidad: "Italia"
}),

(c3:Chef {
    idChef: 3,
    nombre: "Carlos Hernandez",
    fechaNacimiento: date("1978-03-20"),
    nacionalidad: "Mexico"
}),

(c4:Chef {
    idChef: 4,
    nombre: "Kenji Tanaka",
    fechaNacimiento: date("1982-07-18"),
    nacionalidad: "Japon"
}),

(c5:Chef {
    idChef: 5,
    nombre: "Aiko Yamamoto",
    fechaNacimiento: date("1988-11-22"),
    nacionalidad: "Japon"
});

// =====================================================
// RESTAURANTES
// =====================================================

CREATE
(r1:Restaurante {
    idRestaurante: 1,
    nombre: "Bella Italia",
    anioApertura: 2010,
    rangoPrecios: "$$",
    descripcion: "Comida italiana tradicional"
}),

(r2:Restaurante {
    idRestaurante: 2,
    nombre: "Roma Express",
    anioApertura: 2015,
    rangoPrecios: "$$",
    descripcion: "Pizzas y pastas"
}),

(r3:Restaurante {
    idRestaurante: 3,
    nombre: "El Mariachi",
    anioApertura: 2012,
    rangoPrecios: "$",
    descripcion: "Comida mexicana"
}),

(r4:Restaurante {
    idRestaurante: 4,
    nombre: "Azteca Grill",
    anioApertura: 2018,
    rangoPrecios: "$$",
    descripcion: "Especialidades mexicanas"
}),

(r5:Restaurante {
    idRestaurante: 5,
    nombre: "Tokyo Sushi",
    anioApertura: 2016,
    rangoPrecios: "$$$",
    descripcion: "Sushi premium"
});

// =====================================================
// USUARIOS
// =====================================================

CREATE
(u1:Usuario {
    idUsuario: 1,
    nombre: "Juan Juan",
    email: "juanjuan@email.com",
    edad: 25,
    pais: "Guatemala"
}),

(u2:Usuario {
    idUsuario: 2,
    nombre: "Ana Lopez",
    email: "ana@email.com",
    edad: 30,
    pais: "Guatemala"
}),

(u3:Usuario {
    idUsuario: 3,
    nombre: "Luis Garcia",
    email: "luis@email.com",
    edad: 28,
    pais: "Mexico"
}),

(u4:Usuario {
    idUsuario: 4,
    nombre: "Maria Diaz",
    email: "maria@email.com",
    edad: 35,
    pais: "El Salvador"
}),

(u5:Usuario {
    idUsuario: 5,
    nombre: "Pedro Castillo",
    email: "pedro@email.com",
    edad: 40,
    pais: "Honduras"
});




// =====================================================
// =====================================================
// RELACIONES:
// =====================================================
// =====================================================

// ====================================
// PERTENECE_A
// =====================================================

MATCH (r:Restaurante {idRestaurante:1}),(tc:TipoCocina {idTipoCocina:1})
CREATE (r)-[:PERTENECE_A]->(tc);

MATCH (r:Restaurante {idRestaurante:1}),(tc:TipoCocina {idTipoCocina:2})
CREATE (r)-[:PERTENECE_A]->(tc);

MATCH (r:Restaurante {idRestaurante:2}),(tc:TipoCocina {idTipoCocina:1})
CREATE (r)-[:PERTENECE_A]->(tc);

MATCH (r:Restaurante {idRestaurante:3}),(tc:TipoCocina {idTipoCocina:2})
CREATE (r)-[:PERTENECE_A]->(tc);

MATCH (r:Restaurante {idRestaurante:4}),(tc:TipoCocina {idTipoCocina:2})
CREATE (r)-[:PERTENECE_A]->(tc);

MATCH (r:Restaurante {idRestaurante:5}),(tc:TipoCocina {idTipoCocina:3})
CREATE (r)-[:PERTENECE_A]->(tc);

MATCH (r:Restaurante {idRestaurante:5}),(tc:TipoCocina {idTipoCocina:1})
CREATE (r)-[:PERTENECE_A]->(tc);

// =====================================================
// OFRECE
// =====================================================

MATCH (r:Restaurante {idRestaurante:1}),(p:Platillo {idPlatillo:1})
CREATE (r)-[:OFRECE {precio:85.00, disponible:true}]->(p);

MATCH (r:Restaurante {idRestaurante:1}),(p:Platillo {idPlatillo:2})
CREATE (r)-[:OFRECE {precio:95.00, disponible:true}]->(p);

MATCH (r:Restaurante {idRestaurante:2}),(p:Platillo {idPlatillo:1})
CREATE (r)-[:OFRECE {precio:105.00, disponible:true}]->(p);

MATCH (r:Restaurante {idRestaurante:2}),(p:Platillo {idPlatillo:2})
CREATE (r)-[:OFRECE {precio:98.00, disponible:true}]->(p);

MATCH (r:Restaurante {idRestaurante:3}),(p:Platillo {idPlatillo:3})
CREATE (r)-[:OFRECE {precio:42.00, disponible:true}]->(p);

MATCH (r:Restaurante {idRestaurante:4}),(p:Platillo {idPlatillo:3})
CREATE (r)-[:OFRECE {precio:55.00, disponible:true}]->(p);

MATCH (r:Restaurante {idRestaurante:5}),(p:Platillo {idPlatillo:4})
CREATE (r)-[:OFRECE {precio:120.00, disponible:true}]->(p);

MATCH (r:Restaurante {idRestaurante:5}),(p:Platillo {idPlatillo:5})
CREATE (r)-[:OFRECE {precio:115.00, disponible:true}]->(p);

// =====================================================
// PREPARA
// =====================================================

MATCH (c:Chef {idChef:1}),(p:Platillo {idPlatillo:1})
CREATE (c)-[:PREPARA {estilo:"Tradicional", especialidad:"Pizza"}]->(p);

MATCH (c:Chef {idChef:2}),(p:Platillo {idPlatillo:2})
CREATE (c)-[:PREPARA {estilo:"Casero", especialidad:"Lasagna"}]->(p);

MATCH (c:Chef {idChef:3}),(p:Platillo {idPlatillo:3})
CREATE (c)-[:PREPARA {estilo:"Regional", especialidad:"Tacos"}]->(p);

MATCH (c:Chef {idChef:4}),(p:Platillo {idPlatillo:4})
CREATE (c)-[:PREPARA {estilo:"Moderno", especialidad:"Sushi"}]->(p);

MATCH (c:Chef {idChef:5}),(p:Platillo {idPlatillo:5})
CREATE (c)-[:PREPARA {estilo:"Tradicional", especialidad:"Ramen"}]->(p);

// =====================================================
// TRABAJA_EN
// =====================================================

MATCH (c:Chef {idChef:1}),(r:Restaurante {idRestaurante:1})
CREATE (c)-[:TRABAJA_EN {
    fechaInicio: date("2022-01-01"),
    puesto:"Chef Principal"
}]->(r);

MATCH (c:Chef {idChef:1}),(r:Restaurante {idRestaurante:2})
CREATE (c)-[:TRABAJA_EN {
    fechaInicio: date("2024-01-01"),
    puesto:"Consultor"
}]->(r);

MATCH (c:Chef {idChef:2}),(r:Restaurante {idRestaurante:2})
CREATE (c)-[:TRABAJA_EN {
    fechaInicio: date("2021-05-01"),
    puesto:"Chef Ejecutivo"
}]->(r);

MATCH (c:Chef {idChef:3}),(r:Restaurante {idRestaurante:3})
CREATE (c)-[:TRABAJA_EN {
    fechaInicio: date("2020-08-15"),
    puesto:"Chef Principal"
}]->(r);

MATCH (c:Chef {idChef:4}),(r:Restaurante {idRestaurante:5})
CREATE (c)-[:TRABAJA_EN {
    fechaInicio: date("2023-02-01"),
    puesto:"Chef Sushi"
}]->(r);

MATCH (c:Chef {idChef:5}),(r:Restaurante {idRestaurante:5})
CREATE (c)-[:TRABAJA_EN {
    fechaInicio: date("2023-06-01"),
    puesto:"Chef Ramen"
}]->(r);

// =====================================================
// LE_GUSTA
// =====================================================

MATCH (u:Usuario {idUsuario:1}),(tc:TipoCocina {idTipoCocina:1})
CREATE (u)-[:LE_GUSTA {nivelInteres:5}]->(tc);

MATCH (u:Usuario {idUsuario:2}),(tc:TipoCocina {idTipoCocina:2})
CREATE (u)-[:LE_GUSTA {nivelInteres:5}]->(tc);

MATCH (u:Usuario {idUsuario:3}),(tc:TipoCocina {idTipoCocina:1})
CREATE (u)-[:LE_GUSTA {nivelInteres:4}]->(tc);

MATCH (u:Usuario {idUsuario:4}),(tc:TipoCocina {idTipoCocina:3})
CREATE (u)-[:LE_GUSTA {nivelInteres:5}]->(tc);

MATCH (u:Usuario {idUsuario:5}),(tc:TipoCocina {idTipoCocina:2})
CREATE (u)-[:LE_GUSTA {nivelInteres:4}]->(tc);

// =====================================================
// ES_AMIGO_DE
// =====================================================

MATCH (u1:Usuario {idUsuario:1}),(u2:Usuario {idUsuario:2})
CREATE (u1)-[:ES_AMIGO_DE {
    fechaAmistad: date("2022-01-10")
}]->(u2);

MATCH (u2:Usuario {idUsuario:2}),(u3:Usuario {idUsuario:3})
CREATE (u2)-[:ES_AMIGO_DE {
    fechaAmistad: date("2022-03-15")
}]->(u3);

MATCH (u3:Usuario {idUsuario:3}),(u4:Usuario {idUsuario:4})
CREATE (u3)-[:ES_AMIGO_DE {
    fechaAmistad: date("2023-01-01")
}]->(u4);

MATCH (u4:Usuario {idUsuario:4}),(u5:Usuario {idUsuario:5})
CREATE (u4)-[:ES_AMIGO_DE {
    fechaAmistad: date("2023-07-20")
}]->(u5);

// =====================================================
// VISITO
// =====================================================

MATCH (u:Usuario {idUsuario:1}),(r:Restaurante {idRestaurante:1})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-01-10"),
    consumo: 150.00,
    conReserva: true
}]->(r);

MATCH (u:Usuario {idUsuario:1}),(r:Restaurante {idRestaurante:2})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-02-15"),
    consumo: 120.00,
    conReserva: false
}]->(r);

MATCH (u:Usuario {idUsuario:2}),(r:Restaurante {idRestaurante:3})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-03-05"),
    consumo: 90.00,
    conReserva: true
}]->(r);

MATCH (u:Usuario {idUsuario:2}),(r:Restaurante {idRestaurante:4})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-04-01"),
    consumo: 110.00,
    conReserva: true
}]->(r);

MATCH (u:Usuario {idUsuario:3}),(r:Restaurante {idRestaurante:1})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-02-20"),
    consumo: 180.00,
    conReserva: true
}]->(r);

MATCH (u:Usuario {idUsuario:3}),(r:Restaurante {idRestaurante:2})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-03-10"),
    consumo: 95.00,
    conReserva: false
}]->(r);

MATCH (u:Usuario {idUsuario:4}),(r:Restaurante {idRestaurante:5})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-01-25"),
    consumo: 250.00,
    conReserva: true
}]->(r);

MATCH (u:Usuario {idUsuario:4}),(r:Restaurante {idRestaurante:5})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-04-20"),
    consumo: 275.00,
    conReserva: true
}]->(r);

MATCH (u:Usuario {idUsuario:5}),(r:Restaurante {idRestaurante:3})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-02-12"),
    consumo: 80.00,
    conReserva: false
}]->(r);

MATCH (u:Usuario {idUsuario:5}),(r:Restaurante {idRestaurante:4})
CREATE (u)-[:VISITO {
    fechaVisita: date("2026-05-01"),
    consumo: 130.00,
    conReserva: true
}]->(r);

// =====================================================
// CALIFICO
// =====================================================

MATCH (u:Usuario {idUsuario:1}),(r:Restaurante {idRestaurante:1})
CREATE (u)-[:CALIFICO {
    puntuacion: 5,
    fecha: date("2026-01-11"),
    comentario: "Excelente servicio"
}]->(r);

MATCH (u:Usuario {idUsuario:1}),(r:Restaurante {idRestaurante:2})
CREATE (u)-[:CALIFICO {
    puntuacion: 4,
    fecha: date("2026-02-16"),
    comentario: "Muy buena comida"
}]->(r);

MATCH (u:Usuario {idUsuario:2}),(r:Restaurante {idRestaurante:3})
CREATE (u)-[:CALIFICO {
    puntuacion: 5,
    fecha: date("2026-03-06"),
    comentario: "Los mejores tacos"
}]->(r);

MATCH (u:Usuario {idUsuario:2}),(r:Restaurante {idRestaurante:4})
CREATE (u)-[:CALIFICO {
    puntuacion: 4,
    fecha: date("2026-04-02"),
    comentario: "Muy recomendado"
}]->(r);

MATCH (u:Usuario {idUsuario:3}),(r:Restaurante {idRestaurante:1})
CREATE (u)-[:CALIFICO {
    puntuacion: 5,
    fecha: date("2026-02-21"),
    comentario: "Pizza excelente"
}]->(r);

MATCH (u:Usuario {idUsuario:3}),(r:Restaurante {idRestaurante:2})
CREATE (u)-[:CALIFICO {
    puntuacion: 3,
    fecha: date("2026-03-11"),
    comentario: "Regular"
}]->(r);

MATCH (u:Usuario {idUsuario:4}),(r:Restaurante {idRestaurante:5})
CREATE (u)-[:CALIFICO {
    puntuacion: 5,
    fecha: date("2026-04-21"),
    comentario: "Increíble sushi"
}]->(r);

MATCH (u:Usuario {idUsuario:5}),(r:Restaurante {idRestaurante:3})
CREATE (u)-[:CALIFICO {
    puntuacion: 4,
    fecha: date("2026-02-13"),
    comentario: "Muy bueno"
}]->(r);

MATCH (u:Usuario {idUsuario:5}),(r:Restaurante {idRestaurante:4})
CREATE (u)-[:CALIFICO {
    puntuacion: 5,
    fecha: date("2026-05-02"),
    comentario: "Excelente atención"
}]->(r);