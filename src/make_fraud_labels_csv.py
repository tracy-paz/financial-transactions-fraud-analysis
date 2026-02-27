import json
import csv
from pathlib import Path

JSON_PATH = Path.home() / "Documents" / "Kaggle" / "kaggle_fraud_raw" / "train_fraud_labels.json"
OUT_CSV   = Path.home() / "Documents" / "Kaggle" / "kaggle_fraud_raw" / "train_fraud_labels.csv"

def main():
    with open(JSON_PATH, "r", encoding="utf-8") as f:
        data = json.load(f)

    # Your structure: { "target": { "transaction_id": "Yes"/"No", ... } }
    target = data.get("target", {})

    rows = []
    for k, v in target.items():
        rows.append((int(k), v))

    rows.sort(key=lambda x: x[0])

    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["transaction_id", "is_fraud"])
        w.writerows(rows)

    print(f"Wrote {len(rows)} rows to {OUT_CSV}")

if __name__ == "__main__":
    main()