// =====================================================
// INDICES
// =====================================================

// -----------------------------------------------------
// USUARIO
// -----------------------------------------------------

CREATE INDEX usuario_nombre IF NOT EXISTS
FOR (u:Usuario)
ON (u.nombre);

CREATE INDEX usuario_pais IF NOT EXISTS
FOR (u:Usuario)
ON (u.pais);

// -----------------------------------------------------
// RESTAURANTE
// -----------------------------------------------------

CREATE INDEX restaurante_nombre IF NOT EXISTS
FOR (r:Restaurante)
ON (r.nombre);

CREATE INDEX restaurante_rangoPrecios IF NOT EXISTS
FOR (r:Restaurante)
ON (r.rangoPrecios);

// -----------------------------------------------------
// CHEF
// -----------------------------------------------------

CREATE INDEX chef_nombre IF NOT EXISTS
FOR (c:Chef)
ON (c.nombre);

CREATE INDEX chef_nacionalidad IF NOT EXISTS
FOR (c:Chef)
ON (c.nacionalidad);

// -----------------------------------------------------
// PLATILLO
// -----------------------------------------------------

CREATE INDEX platillo_nombre IF NOT EXISTS
FOR (p:Platillo)
ON (p.nombre);

// -----------------------------------------------------
// TIPO COCINA
// -----------------------------------------------------

CREATE INDEX tipococina_nombre IF NOT EXISTS
FOR (t:TipoCocina)
ON (t.nombreTipo);