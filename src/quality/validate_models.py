from decimal import Decimal

from sqlalchemy import create_engine, text

from src.config.settings import DATABASE_URL


VALIDATIONS = [
    {
        "name": "stg_orders_count_matches_raw_orders",
        "actual_sql": "SELECT COUNT(*) FROM staging.stg_orders;",
        "expected_sql": "SELECT COUNT(*) FROM raw.orders;",
        "type": "exact",
    },
    {
        "name": "stg_customers_count_matches_raw_customers",
        "actual_sql": "SELECT COUNT(*) FROM staging.stg_customers;",
        "expected_sql": "SELECT COUNT(*) FROM raw.customers;",
        "type": "exact",
    },
    {
        "name": "mart_sales_order_count_matches_stg_orders",
        "actual_sql": "SELECT COUNT(*) FROM marts.mart_sales;",
        "expected_sql": "SELECT COUNT(*) FROM staging.stg_orders;",
        "type": "exact",
    },
    {
        "name": "mart_sales_payment_total_matches_stg_payments",
        "actual_sql": "SELECT ROUND(SUM(total_payment_value)::numeric, 2) FROM marts.mart_sales;",
        "expected_sql": "SELECT ROUND(SUM(payment_value)::numeric, 2) FROM staging.stg_payments;",
        "type": "numeric_tolerance",
        "tolerance": Decimal("0.01"),
    },
    {
        "name": "mart_delivery_count_matches_stg_orders",
        "actual_sql": "SELECT COUNT(*) FROM marts.mart_delivery_performance;",
        "expected_sql": "SELECT COUNT(*) FROM staging.stg_orders;",
        "type": "exact",
    },
]


def fetch_scalar(connection, sql: str):
    return connection.execute(text(sql)).scalar_one()


def validate_exact(actual, expected) -> bool:
    return actual == expected


def validate_numeric_tolerance(actual, expected, tolerance: Decimal) -> bool:
    if actual is None or expected is None:
        return False

    return abs(Decimal(str(actual)) - Decimal(str(expected))) <= tolerance


def main() -> None:
    engine = create_engine(DATABASE_URL)

    print("Validating analytical models...\n")

    failed_validations = []

    with engine.connect() as connection:
        for validation in VALIDATIONS:
            actual = fetch_scalar(connection, validation["actual_sql"])
            expected = fetch_scalar(connection, validation["expected_sql"])

            if validation["type"] == "exact":
                passed = validate_exact(actual, expected)
            elif validation["type"] == "numeric_tolerance":
                passed = validate_numeric_tolerance(
                    actual,
                    expected,
                    validation["tolerance"],
                )
            else:
                raise ValueError(f"Unknown validation type: {validation['type']}")

            status = "PASS" if passed else "FAIL"

            print(
                f"[{status}] {validation['name']} | "
                f"actual: {actual} | expected: {expected}"
            )

            if not passed:
                failed_validations.append(validation["name"])

    print("\nValidation completed.")

    if failed_validations:
        raise ValueError(
            "Some analytical model validations failed: "
            + ", ".join(failed_validations)
        )

    print("All analytical model validations passed.")


if __name__ == "__main__":
    main()