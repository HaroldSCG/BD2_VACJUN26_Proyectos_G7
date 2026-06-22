# Este script se encarga de copiar los archivos CSV generados a la carpeta de importación de Neo4j.

import shutil
from pathlib import Path
from dotenv import load_dotenv
import os


def sendCSVs():
    # ==========================================
    # CARGAR VARIABLES .ENV
    # ==========================================

    load_dotenv()

    IMPORT_DIR = Path(
        os.getenv("NEO4J_IMPORT_DIR")
    )

    BASE_DIR = Path(__file__).resolve().parent

    CSV_DIR = BASE_DIR.parent / "CSV"

    # ==========================================
    # VALIDACIONES
    # ==========================================

    if not IMPORT_DIR.exists():
        raise Exception(
            f"No existe carpeta import: {IMPORT_DIR}"
        )

    if not CSV_DIR.exists():
        raise Exception(
            f"No existe carpeta CSV: {CSV_DIR}"
        )

    # ==========================================
    # COPIAR CSV
    # ==========================================

    cantidad = 0

    for archivo in CSV_DIR.glob("*.csv"):

        destino = IMPORT_DIR / archivo.name

        shutil.copy2(
            archivo,
            destino
        )

        cantidad += 1

        print(
            f"Copiado: {archivo.name}"
        )

    print(
        f"\nSe copiaron {cantidad} archivos CSV."
    )