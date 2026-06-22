// =====================================================
// CONSTRAINTS
// Proyecto 2 - Sistema de Recomendación de Restaurantes
// =====================================================

// -----------------------------------------------------
// USUARIO
// -----------------------------------------------------

CREATE CONSTRAINT usuario_id IF NOT EXISTS
FOR (u:Usuario)
REQUIRE u.idUsuario IS UNIQUE;

// -----------------------------------------------------
// RESTAURANTE
// -----------------------------------------------------

CREATE CONSTRAINT restaurante_id IF NOT EXISTS
FOR (r:Restaurante)
REQUIRE r.idRestaurante IS UNIQUE;

// -----------------------------------------------------
// CHEF
// -----------------------------------------------------

CREATE CONSTRAINT chef_id IF NOT EXISTS
FOR (c:Chef)
REQUIRE c.idChef IS UNIQUE;

// -----------------------------------------------------
// PLATILLO
// -----------------------------------------------------

CREATE CONSTRAINT platillo_id IF NOT EXISTS
FOR (p:Platillo)
REQUIRE p.idPlatillo IS UNIQUE;

// -----------------------------------------------------
// TIPOCOCINA
// -----------------------------------------------------

CREATE CONSTRAINT tipococina_id IF NOT EXISTS
FOR (t:TipoCocina)
REQUIRE t.idTipoCocina IS UNIQUE;