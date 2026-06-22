# Fase 1 - Modelo de Grafos
## Proyecto 2 - Sistema de Recomendación de Restaurantes con Neo4j
### Sistemas de Bases de Datos 2

---

El sistema consiste en una plataforma de recomendación de restaurantes basada en tecnología de grafos utilizando Neo4j.

El modelo permitirá representar usuarios, restaurantes, chefs, tipos de cocina y platillos, así como las relaciones existentes entre ellos para generar recomendaciones inteligentes basadas en patrones de visitas, calificaciones, gustos gastronómicos y conexiones sociales.

---

# 2. Nodos del Sistema

## Usuario

Representa a las personas que utilizan la plataforma.

| Propiedad | Tipo |
|------------|--------|
| idUsuario | Integer |
| nombre | String |
| email | String |
| edad | Integer |
| pais | String |

---

## Restaurante

Representa establecimientos gastronómicos registrados en la plataforma.

| Propiedad | Tipo |
|------------|--------|
| idRestaurante | Integer |
| nombre | String |
| anioApertura | Integer |
| rangoPrecios | String |
| descripcion | String |

---

## TipoCocina

Representa categorías gastronómicas.

| Propiedad | Tipo |
|------------|--------|
| idTipoCocina | Integer |
| nombreTipo | String |
| descripcion | String |

---

## Chef

Representa a los responsables de la preparación culinaria.

| Propiedad | Tipo |
|------------|--------|
| idChef | Integer |
| nombre | String |
| fechaNacimiento | Date |
| nacionalidad | String |

---

## Platillo

Representa los alimentos ofrecidos por los restaurantes.

| Propiedad | Tipo |
|------------|--------|
| idPlatillo | Integer |
| nombre | String |
| precioBase | Decimal |
| descripcion | String |


"precioBase" representa un precio de referencia del platillo.
---

# 3. Relaciones del Sistema

## CALIFICO

**Origen:** Usuario

**Destino:** Restaurante

### Propiedades

| Propiedad | Tipo |
|------------|--------|
| puntuacion | Integer |
| fecha | Date |
| comentario | String |

---

## VISITO

**Origen:** Usuario

**Destino:** Restaurante

### Propiedades

| Propiedad | Tipo |
|------------|--------|
| fechaVisita | Date |
| consumo | Decimal |
| conReserva | Boolean |

---

## ES_AMIGO_DE

**Origen:** Usuario

**Destino:** Usuario

### Propiedades

| Propiedad | Tipo |
|------------|--------|
| fechaAmistad | Date |

---

## PERTENECE_A

**Origen:** Restaurante

**Destino:** TipoCocina

### Propiedades

Sin propiedades.

---

## OFRECE

**Origen:** Restaurante

**Destino:** Platillo

### Propiedades

| Propiedad | Tipo |
|------------|--------|
| precio | Decimal |
| disponible | Boolean |

"precio" representa el precio específico que cada restaurante asigna a ese platillo.
---

## PREPARA

**Origen:** Chef

**Destino:** Platillo

### Propiedades

| Propiedad | Tipo |
|------------|--------|
| estilo | String |
| especialidad | String |

---

## TRABAJA_EN

**Origen:** Chef

**Destino:** Restaurante

### Propiedades

| Propiedad | Tipo |
|------------|--------|
| fechaInicio | Date |
| puesto | String |

---

## LE_GUSTA

**Origen:** Usuario

**Destino:** TipoCocina

### Propiedades

| Propiedad | Tipo |
|------------|--------|
| nivelInteres | Integer |

---

# 4. Cardinalidades

| Relación | Cardinalidad |
|-----------|-------------|
| CALIFICO | N:M |
| VISITO | N:M |
| ES_AMIGO_DE | N:M |
| PERTENECE_A | N:M |
| OFRECE | N:M |
| PREPARA | N:M |
| TRABAJA_EN | N:M |
| LE_GUSTA | N:M |

---

# 5. Reglas de Negocio

1. Un usuario puede calificar múltiples restaurantes.

2. Un usuario puede visitar múltiples restaurantes.

3. Un restaurante puede pertenecer a varios tipos de cocina.

4. Un restaurante puede ofrecer múltiples platillos.

5. Un chef puede trabajar en varios restaurantes a lo largo del tiempo.

6. Un chef puede preparar múltiples platillos.

7. Las calificaciones deben estar en un rango de 1 a 5 estrellas.

8. Un restaurante no puede ofrecer el mismo platillo más de una vez.

9. El sistema debe permitir generar recomendaciones basadas en:
   - Historial de visitas.
   - Calificaciones realizadas.
   - Tipos de cocina preferidos.
   - Chefs compartidos entre restaurantes.

---

# 6. Identificadores Únicos

Cada nodo utilizará un identificador único para facilitar la creación de restricciones (Constraints) en Neo4j.

| Nodo | Identificador |
|--------|---------------|
| Usuario | idUsuario |
| Restaurante | idRestaurante |
| TipoCocina | idTipoCocina |
| Chef | idChef |
| Platillo | idPlatillo |

---

# 7. Convenciones de Nomenclatura

## Nodos

Se utilizarán etiquetas en singular y formato CamelCase.

Ejemplos:

- Usuario
- Restaurante
- TipoCocina
- Chef
- Platillo

## Relaciones

Se utilizarán nombres en mayúsculas y separados por guion bajo.

Ejemplos:

- CALIFICO
- VISITO
- ES_AMIGO_DE
- PERTENECE_A
- OFRECE
- PREPARA
- TRABAJA_EN
- LE_GUSTA

---

# 8. Modelo

## Nodos

- Usuario
- Restaurante
- TipoCocina
- Chef
- Platillo

## Relaciones

- CALIFICO
- VISITO
- ES_AMIGO_DE
- PERTENECE_A
- OFRECE
- PREPARA
- TRABAJA_EN
- LE_GUSTA

## Orden de Creacion

1. TipoCocina
2. Platillo
3. Chef
4. Restaurante
5. Usuario
6. PERTENECE_A
7. OFRECE
8. PREPARA
9. TRABAJA_EN
10. LE_GUSTA
11. ES_AMIGO_DE
12. VISITO
13. CALIFICO

## dependencia logica

PERTENECE_A
↓
LE_GUSTA
↓
TRABAJA_EN
↓
PREPARA
↓
OFRECE
↓
VISITO
↓
CALIFICO