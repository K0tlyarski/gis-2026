from pathlib import Path

import duckdb


ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "lab3" / "lab3.duckdb"
SQL_PATH = ROOT / "lab3" / "03_classify_sources.sql"


def main():
    con = duckdb.connect(str(DB_PATH))
    try:
        con.execute(SQL_PATH.read_text(encoding="utf-8"))

        print(f"DuckDB database: {DB_PATH}")
        print("View: overture_buildings_classified")
        print("Columns:")
        for name, column_type, *_ in con.execute(
            "DESCRIBE SELECT * FROM overture_buildings_classified"
        ).fetchall():
            print(f"  {name}: {column_type}")
    finally:
        con.close()


if __name__ == "__main__":
    main()
