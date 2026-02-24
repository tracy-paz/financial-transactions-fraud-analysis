-- sql/00_schema.sql
-- Fraud Transaction Analytics - PostgreSQL schema
-- Note: We intentionally do NOT store card_number or cvv.

BEGIN;

-- Drop in dependency order (safe for rebuilds)
DROP TABLE IF EXISTS fact_fraud_labels;
DROP TABLE IF EXISTS fact_transactions;
DROP TABLE IF EXISTS dim_cards;
DROP TABLE IF EXISTS dim_users;
DROP TABLE IF EXISTS dim_mcc;

-- -------------------------
-- Dimensions
-- -------------------------

CREATE TABLE dim_users (
  user_id            BIGINT PRIMARY KEY,
  current_age        INTEGER,
  retirement_age     INTEGER,
  birth_year         INTEGER,
  birth_month        INTEGER,
  gender             TEXT,
  address            TEXT,
  latitude           DOUBLE PRECISION,
  longitude          DOUBLE PRECISION,
  per_capita_income  NUMERIC(12,2),
  yearly_income      NUMERIC(14,2),
  total_debt         NUMERIC(14,2),
  credit_score       INTEGER,
  num_credit_cards   INTEGER
);

CREATE TABLE dim_cards (
  card_id                BIGINT PRIMARY KEY,
  user_id                BIGINT NOT NULL REFERENCES dim_users(user_id),
  card_brand             TEXT,
  card_type              TEXT,
  expires                TEXT,
  has_chip               BOOLEAN,
  num_cards_issued       INTEGER,
  credit_limit           NUMERIC(14,2),
  acct_open_date         DATE,
  year_pin_last_changed  INTEGER,
  card_on_dark_web       BOOLEAN
);

CREATE TABLE dim_mcc (
  mcc              INTEGER PRIMARY KEY,
  mcc_description  TEXT
);

-- -------------------------
-- Facts
-- -------------------------

CREATE TABLE fact_transactions (
  transaction_id   BIGINT PRIMARY KEY,
  transaction_ts   TIMESTAMP NOT NULL,
  user_id          BIGINT NOT NULL REFERENCES dim_users(user_id),
  card_id          BIGINT NOT NULL REFERENCES dim_cards(card_id),
  amount           NUMERIC(14,2) NOT NULL,
  use_chip         BOOLEAN,
  merchant_id      BIGINT,
  merchant_city    TEXT,
  merchant_state   TEXT,
  zip              TEXT,
  mcc              INTEGER REFERENCES dim_mcc(mcc),
  errors           TEXT
);

CREATE TABLE fact_fraud_labels (
  transaction_id   BIGINT PRIMARY KEY REFERENCES fact_transactions(transaction_id),
  is_fraud         BOOLEAN NOT NULL
);

-- -------------------------
-- Indexes (important for 13.5M rows)
-- -------------------------

CREATE INDEX IF NOT EXISTS idx_txn_user_ts
  ON fact_transactions (user_id, transaction_ts);

CREATE INDEX IF NOT EXISTS idx_txn_card_ts
  ON fact_transactions (card_id, transaction_ts);

CREATE INDEX IF NOT EXISTS idx_txn_mcc
  ON fact_transactions (mcc);

CREATE INDEX IF NOT EXISTS idx_txn_merchant
  ON fact_transactions (merchant_id);

COMMIT;