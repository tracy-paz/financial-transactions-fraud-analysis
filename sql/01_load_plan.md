# Data Load Plan

## Source Files
- users_data.csv → dim_users
- cards_data.csv → dim_cards
- transactions_data.csv → fact_transactions
- train_fraud_labels.json → fact_fraud_labels
- mcc_codes.json → dim_mcc

## Notes
- card_number and cvv will NOT be loaded
- transactions_data contains ~13.5M rows
- Data will be loaded using PostgreSQL COPY
- JSON files will be preprocessed into CSV via Python

## Load Order
1. dim_users
2. dim_cards
3. dim_mcc
4. fact_transactions
5. fact_fraud_labels