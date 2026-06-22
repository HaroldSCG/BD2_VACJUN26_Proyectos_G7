# Proyecto 2 - Sistema de Recomendación de Restaurantes con Neo4j

## Descripción General

Este proyecto implementa un sistema de recomendación de restaurantes utilizando bases de datos orientadas a grafos con Neo4j.

El sistema modela las relaciones entre:

* Usuarios
* Restaurantes
* Tipos de Cocina
* Chefs
* Platillos

permitiendo realizar análisis de redes, recomendaciones y consultas complejas basadas en relaciones entre entidades.

---

# Estructura del Proyecto

```text
Segundo Proyecto/
│
├── CSV/
│
├── Documentacion/
│
├── Evidencias/
│
├── ManualUsuario/
│
├── Python/
│
└── Scripts/
```

---

# Descripción de Carpetas

## CSV

Contiene todos los archivos CSV generados automáticamente para la carga masiva de datos.

Archivos:

```text
usuarios.csv
restaurantes.csv
chefs.csv
platillos.csv
tiposcocina.csv

pertenece_a.csv
le_gusta.csv
trabaja_en.csv
prepara.csv
ofrece.csv
es_amigo_de.csv
visito.csv
califico.csv
```

Estos archivos son utilizados por Neo4j mediante LOAD CSV.

---

## Documentacion

Contiene toda la documentación técnica del proyecto.

Ejemplos:

```text
Modelo.md
Diagrama.pdf
GuiaProyecto.md
```

---

## Evidencias

Contiene capturas de pantalla y evidencia de ejecución.

Ejemplos:

```text
CargaMasiva/
Consultas/
AnalisisRedes/
```

---

## ManualUsuario

Contiene el manual de instalación y uso del sistema.

---

## Python

Contiene los scripts utilizados para automatizar la generación y transferencia de datos.

### generatorCSV.py

Genera todos los archivos CSV requeridos por el proyecto.

Genera:

* 500 usuarios
* 200 restaurantes
* 100 chefs
* 50 platillos
* 15 tipos de cocina

junto con todas las relaciones del modelo.

### sendCSVs.py

Copia automáticamente todos los archivos CSV generados hacia la carpeta import de Neo4j.

La ubicación de la carpeta import se configura mediante un archivo .env.

-- Al hacer pull, cambiar el .env para hacer match con la carpeta de la instancia en neo4j

---

## Scripts

Contiene todos los scripts Cypher utilizados por Neo4j.

### 1_Constraints.cypher

Crea restricciones de unicidad para los identificadores principales.

Ejemplos:

```text
Usuario.idUsuario
Restaurante.idRestaurante
Chef.idChef
Platillo.idPlatillo
TipoCocina.idTipoCocina
```

---

### 1b_Indices.cypher

Crea índices para mejorar el rendimiento de búsqueda.

---

### 3_Datas.cypher

Contiene un dataset pequeño de prueba utilizado durante el desarrollo inicial.

Este archivo no es necesario para la carga masiva final.

---

### 4_loadCSV.cypher

Carga todos los datos masivos desde los archivos CSV utilizando:

* LOAD CSV
* MERGE
* MATCH
* SET

Además incluye consultas de validación.

---

### 5_consultas.cypher

Contiene todas las consultas requeridas por el proyecto.

Incluye:

1. Diversidad de tipos de cocina.
2. Tasa de reservas.
3. Gasto promedio.
4. Frecuencia de visitas.
5. Restaurantes sin visitas recientes.
6. Movilidad de chefs.
7. Variación de precios.
8. Visitas por tipo de cocina.
9. Recomendación de restaurantes.

También incluye:

* shortestPath()
* Restaurantes altamente conectados.

---

# Modelo de Datos

## Nodos

### Usuario

```text
idUsuario
nombre
email
edad
pais
```

### Restaurante

```text
idRestaurante
nombre
anioApertura
rangoPrecios
descripcion
```

### TipoCocina

```text
idTipoCocina
nombreTipo
descripcion
```

### Chef

```text
idChef
nombre
fechaNacimiento
nacionalidad
```

### Platillo

```text
idPlatillo
nombre
precioBase
descripcion
```

---

# Relaciones

## CALIFICO

```text
puntuacion
fecha
comentario
```

## VISITO

```text
fechaVisita
consumo
conReserva
```

## ES_AMIGO_DE

```text
fechaAmistad
```

## LE_GUSTA

```text
nivelInteres
```

## PERTENECE_A

Sin propiedades.

## OFRECE

```text
precio
disponible
```

## PREPARA

```text
estilo
especialidad
```

## TRABAJA_EN

```text
fechaInicio
puesto
```

---

# Flujo de Ejecución del Proyecto

## Primera Ejecución

### Paso 1

Crear la base de datos en Neo4j.

Ejemplo:

```text
restaurantes
```

---

### Paso 2

Ejecutar:

```text
1_Constraints.cypher
```

---

### Paso 3

Ejecutar:

```text
1b_Indices.cypher
```

---

### Paso 4

Ejecutar:

```text
generatorCSV.py
```

Esto genera todos los archivos CSV.

---

### Paso 5

Ejecutar:

```text
sendCSVs.py
```

Esto copia los CSV a la carpeta import de Neo4j.

---

### Paso 6

Ejecutar:

```text
4_loadCSV.cypher
```

Esto carga todos los nodos y relaciones.

---

### Paso 7

Ejecutar las consultas de validación.

Ejemplo:

```cypher
MATCH (u:Usuario)
RETURN COUNT(u);
```

---

### Paso 8

Ejecutar:

```text
5_consultas.cypher
```

para realizar los análisis del sistema.

---

# Flujo de Regeneración de Datos

Cuando se desee generar un nuevo conjunto de datos:

### 1

Ejecutar:

```text
generatorCSV.py
```

### 2

Ejecutar:

```text
sendCSVs.py
```

### 3

Vaciar la base:

```cypher
reset.py
```

### 4

Volver a ejecutar:

```text
4_loadCSV.cypher
```

---

# Tecnologías Utilizadas

* Neo4j Desktop
* Cypher
* Python
* Faker
* CSV
* dotenv

---

# Resultado Final

El sistema permite:

* Gestionar usuarios y restaurantes.
* Analizar patrones de visitas.
* Analizar movilidad de chefs.
* Calcular rutas más cortas entre usuarios.
* Identificar restaurantes altamente conectados.
* Generar recomendaciones basadas en historial y chefs compartidos.
* Realizar carga masiva de datos mediante CSV.
* Ejecutar consultas complejas utilizando grafos.
