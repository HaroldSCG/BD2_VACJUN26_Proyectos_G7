import csv
import random
from sendCSVs import sendCSVs
from faker import Faker
from pathlib import Path
from datetime import datetime, timedelta

BASE_DIR = Path(__file__).resolve().parent
CSV_DIR = BASE_DIR.parent / "CSV"

CSV_DIR.mkdir(exist_ok=True)

print("CSV_DIR =", CSV_DIR)
print(f"Los archivos se guardarán en: {CSV_DIR}")

fake = Faker()



#TOTAL_TIPOS_COCINA = 15

print("Generando CSVs...")


#tiposCocina - hardodeados

tipos_cocina = [
    "Italiana",
    "Mexicana",
    "Japonesa",
    "China",
    "Francesa",
    "Española",
    "India",
    "Coreana",
    "Mediterranea",
    "Argentina",
    "Peruana",
    "Tailandesa",
    "Vegetariana",
    "Vegana",
    "Internacional"
]

#variables
TOTAL_USUARIOS = 500
TOTAL_RESTAURANTES = 200
TOTAL_CHEFS = 100
TOTAL_PLATILLOS = 50

#valieron papoi las variables pero luego las implemento
TOTAL_PERTENECE = 400
TOTAL_OFRECE = 800
TOTAL_PREPARA = 300
TOTAL_TRABAJA = 250
TOTAL_GUSTA = 1200
#luego

TOTAL_AMISTADES = 2000
TOTAL_VISITAS = 5000
TOTAL_CALIFICACIONES = 3500
TOTAL_TIPOS_COCINA = len(tipos_cocina)


# LISTAS DE IDS VALIDOS
# ==========================================

usuarios = list(range(1, TOTAL_USUARIOS + 1))
restaurantes = list(range(1, TOTAL_RESTAURANTES + 1))
chefs = list(range(1, TOTAL_CHEFS + 1))
platillos = list(range(1, TOTAL_PLATILLOS + 1))
tipos = list(range(1, TOTAL_TIPOS_COCINA + 1))


# //////////////////////////////////////////////////////////////////////////////////////////7
# Usuarios

with open(CSV_DIR / "usuarios.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)

    writer.writerow([
        "idUsuario",
        "nombre",
        "email",
        "edad",
        "pais"
    ])

    for i in range(1, TOTAL_USUARIOS + 1):
        writer.writerow([
            i,
            fake.name(),
            fake.unique.email(),
            random.randint(18, 70),
            fake.country()
        ])

print("usuarios.csv generado")

# Restaurantes

with open(CSV_DIR / "restaurantes.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)

    writer.writerow([
        "idRestaurante",
        "nombre",
        "anioApertura",
        "rangoPrecios",
        "descripcion"
    ])

    for i in range(1, TOTAL_RESTAURANTES + 1):

        writer.writerow([
            i,
            f"Restaurante {i}",
            random.randint(1990, 2025),
            random.choice(["$", "$$", "$$$"]),
            fake.sentence(nb_words=6)
        ])

print("restaurantes.csv generado")


# Chefs

with open(CSV_DIR / "chefs.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)

    writer.writerow([
        "idChef",
        "nombre",
        "fechaNacimiento",
        "nacionalidad"
    ])

    for i in range(1, TOTAL_CHEFS + 1):

        writer.writerow([
            i,
            fake.name(),
            fake.date_between(
                start_date="-60y",
                end_date="-25y"
            ).strftime("%Y-%m-%d"),
            fake.country()
        ])

print("chefs.csv generado")

# Platillos

with open(CSV_DIR / "platillos.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)

    writer.writerow([
        "idPlatillo",
        "nombre",
        "precioBase",
        "descripcion"
    ])

    for i in range(1, TOTAL_PLATILLOS + 1):

        writer.writerow([
            i,
            f"Platillo {i}",
            round(random.uniform(25, 250), 2),
            fake.sentence(nb_words=5)
        ])

print("platillos.csv generado")

# Tipos de Cocina

with open(CSV_DIR / "tiposcocina.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)

    writer.writerow([
        "idTipoCocina",
        "nombreTipo",
        "descripcion"
    ])

    for i, nombre in enumerate(tipos_cocina, start=1):

        writer.writerow([
            i,
            nombre,
            f"Cocina tipo {nombre}"
        ])

print("tiposcocina.csv generado")

print("\nTodos los CSV de nodos fueron creados correctamente.")

# //////////////////////////////////////////////////////////////////////////////////////////

# ==========================================
# PERTENECE_A
# ==========================================

relaciones_pertenece = set()

for restaurante in restaurantes:

    cantidad = random.randint(1, 3)

    cocinas = random.sample(
        tipos,
        k=cantidad
    )

    for cocina in cocinas:

        relaciones_pertenece.add(
            (restaurante, cocina)
        )

with open(CSV_DIR / "pertenece_a.csv", "w", newline="", encoding="utf-8") as f:

    writer = csv.writer(f)

    writer.writerow([
        "idRestaurante",
        "idTipoCocina"
    ])

    for restaurante, cocina in sorted(relaciones_pertenece):

        writer.writerow([
            restaurante,
            cocina
        ])

print("pertenece_a.csv generado")

# ==========================================
# Restaurantes por Tipo de Cocina
# ==========================================

restaurantes_por_cocina = {}

for restaurante, cocina in relaciones_pertenece:

    if cocina not in restaurantes_por_cocina:

        restaurantes_por_cocina[cocina] = []

    restaurantes_por_cocina[cocina].append(
        restaurante
    )

# ==========================================
# LE_GUSTA
# ==========================================


preferencias_usuario = {}

with open(CSV_DIR / "le_gusta.csv", "w", newline="", encoding="utf-8") as f:

    writer = csv.writer(f)

    writer.writerow([
        "idUsuario",
        "idTipoCocina",
        "nivelInteres"
    ])

    for usuario in usuarios:

        gustos = random.sample(
            tipos,
            k=random.randint(1, 4)
        )

        preferencias_usuario[usuario] = gustos

        for cocina in gustos:

            writer.writerow([
                usuario,
                cocina,
                random.randint(3, 5)
            ])

print("le_gusta.csv generado")


# ==========================================
# TRABAJA_EN
# ==========================================

relaciones_trabaja = set()

chef_restaurantes = {}

puestos = [
    "Chef Principal",
    "Sous Chef",
    "Chef Ejecutivo",
    "Chef de Linea"
]

for chef in chefs:

    cantidad = random.randint(1, 3)

    destinos = random.sample(
        restaurantes,
        k=cantidad
    )

    chef_restaurantes[chef] = destinos

    for restaurante in destinos:

        relaciones_trabaja.add(
            (chef, restaurante)
        )

with open(CSV_DIR / "trabaja_en.csv", "w", newline="", encoding="utf-8") as f:

    writer = csv.writer(f)

    writer.writerow([
        "idChef",
        "idRestaurante",
        "fechaInicio",
        "puesto"
    ])

    for chef, restaurante in sorted(relaciones_trabaja):

        writer.writerow([
            chef,
            restaurante,
            fake.date_between(
                start_date="-10y",
                end_date="today"
            ).strftime("%Y-%m-%d"),
            random.choice(puestos)
        ])

print("trabaja_en.csv generado")

# ==========================================
# PREPARA
# ==========================================

relaciones_prepara = set()

chef_platillos = {}

estilos = [
    "Tradicional",
    "Moderno",
    "Fusion",
    "Gourmet"
]

for chef in chefs:

    cantidad = random.randint(3, 8)

    seleccion = random.sample(
        platillos,
        k=cantidad
    )

    chef_platillos[chef] = seleccion

    for platillo in seleccion:

        relaciones_prepara.add(
            (chef, platillo)
        )

with open(CSV_DIR / "prepara.csv", "w", newline="", encoding="utf-8") as f:

    writer = csv.writer(f)

    writer.writerow([
        "idChef",
        "idPlatillo",
        "estilo",
        "especialidad"
    ])

    for chef, platillo in sorted(relaciones_prepara):

        writer.writerow([
            chef,
            platillo,
            random.choice(estilos),
            fake.word().capitalize()
        ])

print("prepara.csv generado")

# ==========================================
# OFRECE
# ==========================================

relaciones_ofrece = set()

for chef in chefs:

    restaurantes_chef = chef_restaurantes.get(
        chef,
        []
    )

    platillos_chef = chef_platillos.get(
        chef,
        []
    )

    for restaurante in restaurantes_chef:

        for platillo in platillos_chef:

            relaciones_ofrece.add(
                (
                    restaurante,
                    platillo
                )
            )

with open(CSV_DIR / "ofrece.csv", "w", newline="", encoding="utf-8") as f:

    writer = csv.writer(f)

    writer.writerow([
        "idRestaurante",
        "idPlatillo",
        "precio",
        "disponible"
    ])

    for restaurante, platillo in sorted(relaciones_ofrece):

        writer.writerow([
            restaurante,
            platillo,
            round(random.uniform(25, 300), 2),
            random.choice(["true", "false"])
        ])

print("ofrece.csv generado")

# ///////////////////////////////////////////////////////////////////////////////////////////
# ==========================================
# VISITO
# ==========================================

visitas = []

for _ in range(TOTAL_VISITAS):

    usuario = random.choice(usuarios)

    gustos = preferencias_usuario.get(
        usuario,
        []
    )

    if not gustos:
        continue

    cocina = random.choice(gustos)

    restaurantes_posibles = restaurantes_por_cocina.get(
        cocina,
        []
    )

    if not restaurantes_posibles:
        continue

    restaurante = random.choice(
        restaurantes_posibles
    )

    visitas.append(
        (
            usuario,
            restaurante,
            fake.date_between(
                start_date="-3y",
                end_date="today"
            ).strftime("%Y-%m-%d"),
            round(
                random.uniform(25, 350),
                2
            ),
            random.choice([
                "true",
                "false"
            ])
        )
    )

with open(CSV_DIR / "visito.csv", "w", newline="", encoding="utf-8") as f:

    writer = csv.writer(f)

    writer.writerow([
        "idUsuario",
        "idRestaurante",
        "fechaVisita",
        "consumo",
        "conReserva"
    ])

    writer.writerows(visitas)

print("visito.csv generado")

# ==========================================
# CALIFICO
# ==========================================

calificaciones = []

for visita in random.sample(
    visitas,
    min(
        TOTAL_CALIFICACIONES,
        len(visitas)
    )
):

    usuario = visita[0]
    restaurante = visita[1]

    fecha_visita = datetime.strptime(
        visita[2],
        "%Y-%m-%d"
    )

    # La calificación ocurre entre 0 y 30 días
    # después de la visita

    fecha_calificacion = fecha_visita + timedelta(
        days=random.randint(0, 30)
    )

    puntuacion = random.randint(
        1,
        5
    )

    calificaciones.append(
        (
            usuario,
            restaurante,
            puntuacion,
            fecha_calificacion.strftime(
                "%Y-%m-%d"
            ),
            fake.sentence(
                nb_words=6
            )
        )
    )

with open(
    CSV_DIR / "califico.csv",
    "w",
    newline="",
    encoding="utf-8"
) as f:

    writer = csv.writer(f)

    writer.writerow([
        "idUsuario",
        "idRestaurante",
        "puntuacion",
        "fecha",
        "comentario"
    ])

    writer.writerows(
        calificaciones
    )

print("califico.csv generado")

# ==========================================
# ES_AMIGO_DE
# ==========================================

amistades = set()

while len(amistades) < TOTAL_AMISTADES:

    u1 = random.choice(usuarios)
    u2 = random.choice(usuarios)

    if u1 == u2:
        continue

    amistad = tuple(sorted((u1, u2)))

    amistades.add(amistad)

with open(CSV_DIR / "es_amigo_de.csv", "w", newline="", encoding="utf-8") as f:

    writer = csv.writer(f)

    writer.writerow([
        "idUsuario1",
        "idUsuario2",
        "fechaAmistad"
    ])

    for u1, u2 in sorted(amistades):

        writer.writerow([
            u1,
            u2,
            fake.date_between(
                start_date="-10y",
                end_date="today"
            ).strftime("%Y-%m-%d")
        ])

print("es_amigo_de.csv generado")

print("\nTodos los CSV de relaciones fueron creados correctamente.")
print("\n Manda datos a import de Neo4j...")
sendCSVs()
print("Listo para ejecutar 4_loadCSV.cypher")

