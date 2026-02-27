import json
import csv
from pathlib import Path

# Update these paths as needed
JSON_PATH = Path.home() / "Documents" / "Kaggle" / "kaggle_fraud_raw" / "mcc_codes.json"
OUT_CSV  = Path.home() / "Documents" / "Kaggle" / "kaggle_fraud_raw" / "mcc_codes.csv"

def main():
    with open(JSON_PATH, "r", encoding="utf-8") as f:
        data = json.load(f)

    # Many MCC JSON files are a dict like {"5411": "Grocery Stores", ...}
    rows = []
    if isinstance(data, dict):
        for k, v in data.items():
            rows.append((int(k), str(v)))
    else:
        raise ValueError("Unexpected JSON structure for mcc_codes.json")

    rows.sort(key=lambda x: x[0])

    with open(OUT_CSV, "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["mcc", "mcc_description"])
        w.writerows(rows)

    print(f"Wrote {len(rows)} rows to {OUT_CSV}")

if __name__ == "__main__":
    main()