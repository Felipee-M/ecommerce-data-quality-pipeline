import pandas as pd
from sqlalchemy import create_engine, text

from src.config.settings import DATABASE_URL, RAW_DATA_DIR
from src.load.load_raw_data import RAW_TABLES


def count_csv_rows(file_name: str) -> int:
    file_path = RAW_DATA_DIR / file_name
    df = pd.read_csv(file_path)
    return len(df)


def count_database_rows(table_name: str, engine) -> int:
    query = text(f"SELECT COUNT(*) FROM raw.{table_name};")

    with engine.connect() as connection:
        result = connection.execute(query)
        return result.scalar_one()


def main() -> None:
    engine = create_engine(DATABASE_URL)

    print("Validating raw table row counts...\n")

    validation_results = []

    for file_name, table_name in RAW_TABLES.items():
        file_path = RAW_DATA_DIR / file_name

        if not file_path.exists():
            print(f"[SKIPPED] File not found: {file_name}")
            continue

        csv_count = count_csv_rows(file_name)
        database_count = count_database_rows(table_name, engine)
        status = "PASS" if csv_count == database_count else "FAIL"

        validation_results.append(
            {
                "file_name": file_name,
                "table_name": f"raw.{table_name}",
                "csv_count": csv_count,
                "database_count": database_count,
                "status": status,
            }
        )

        print(
            f"[{status}] {file_name} -> raw.{table_name} | "
            f"csv: {csv_count} | db: {database_count}"
        )

    failed_validations = [
        result for result in validation_results if result["status"] == "FAIL"
    ]

    print("\nValidation completed.")

    if failed_validations:
        raise ValueError("Some raw table count validations failed.")

    print("All raw table count validations passed.")


if __name__ == "__main__":
    main()