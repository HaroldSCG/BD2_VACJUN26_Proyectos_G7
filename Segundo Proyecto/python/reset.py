import csv
import random

from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
CSV_DIR = BASE_DIR.parent / "CSV"

CSV_DIR.mkdir(exist_ok=True)

print("CSV_DIR =", CSV_DIR)
print(f"Los archivos se guardarán en: {CSV_DIR}")

archivos_csv = [
    "califico.csv",
    "chefs.csv",
    "es_amigo_de.csv",
    "le_gusta.csv",
    "ofrece.csv",
    "pertenece_a.csv",
    "platillos.csv",
    "prepara.csv",
    "restaurantes.csv",
    "tiposcocina.csv",
    "trabaja_en.csv",
    "usuarios.csv",
    "visito.csv"
]

for nombre_archivo in archivos_csv:
    ruta = CSV_DIR / nombre_archivo

    # Crea el archivo si no existe y elimina todo su contenido
    with open(ruta, "w", newline="", encoding="utf-8"):
        pass

    print(f"Vaciado: {nombre_archivo}")

print("Todos los archivos CSV han sido vaciados.")