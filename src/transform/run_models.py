from pathlib import Path

from sqlalchemy import create_engine, text

from src.config.settings import BASE_DIR, DATABASE_URL


SQL_FILES = [
    BASE_DIR / "sql" / "staging" / "01_create_staging_schema.sql",
    BASE_DIR / "sql" / "staging" / "02_create_staging_models.sql",
    BASE_DIR / "sql" / "marts" / "01_create_marts_schema.sql",
    BASE_DIR / "sql" / "marts" / "02_create_marts.sql",
]


def run_sql_file(file_path: Path, engine) -> None:
    sql = file_path.read_text(encoding="utf-8")

    with engine.begin() as connection:
        connection.execute(text(sql))

    print(f"[OK] Executed: {file_path.relative_to(BASE_DIR)}")


def main() -> None:
    engine = create_engine(DATABASE_URL)

    print("Starting analytical model creation...\n")

    for sql_file in SQL_FILES:
        if not sql_file.exists():
            raise FileNotFoundError(f"SQL file not found: {sql_file}")

        run_sql_file(sql_file, engine)

    print("\nAnalytical models created successfully.")


if __name__ == "__main__":
    main()