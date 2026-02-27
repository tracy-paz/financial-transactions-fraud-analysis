-- View: public.v_mcc_fraud_rate_raw

-- DROP VIEW public.v_mcc_fraud_rate_raw;

CREATE OR REPLACE VIEW public.v_mcc_fraud_rate_raw
 AS
 SELECT t.mcc,
    m.mcc_description,
    count(*) AS labeled_tx,
    count(*) FILTER (WHERE l.is_fraud) AS fraud_tx,
    round(100.0 * count(*) FILTER (WHERE l.is_fraud)::numeric / NULLIF(count(*), 0)::numeric, 2) AS fraud_rate_pct
   FROM fact_transactions t
     JOIN fact_fraud_labels l ON l.transaction_id = t.transaction_id
     LEFT JOIN dim_mcc m ON m.mcc = t.mcc
  GROUP BY t.mcc, m.mcc_description;

  -- View: public.v_fraud_rate_by_transaction_method

-- DROP VIEW public.v_fraud_rate_by_transaction_method;

CREATE OR REPLACE VIEW public.v_fraud_rate_by_transaction_method
 AS
 SELECT t.use_chip AS transaction_method,
    count(*) AS labeled_tx,
    count(*) FILTER (WHERE l.is_fraud) AS fraud_tx,
    round(100.0 * count(*) FILTER (WHERE l.is_fraud)::numeric / count(*)::numeric, 2) AS fraud_rate_pct
   FROM fact_transactions t
     JOIN fact_fraud_labels l ON l.transaction_id = t.transaction_id
  GROUP BY t.use_chip;

-- View: public.v_fraud_errors_rate_labled

-- DROP VIEW public.v_fraud_errors_rate_labled;

CREATE OR REPLACE VIEW public.v_fraud_errors_rate_labled
 AS
 SELECT TRIM(BOTH FROM unnest(string_to_array(t.errors, ','::text))) AS error_type,
    count(*) AS transactions,
    count(*) FILTER (WHERE l.is_fraud) AS fraud_tx,
    round(100.0 * count(*) FILTER (WHERE l.is_fraud)::numeric / count(*)::numeric, 2) AS fraud_pct
   FROM fact_transactions t
     JOIN fact_fraud_labels l ON t.transaction_id = l.transaction_id
  WHERE t.errors IS NOT NULL
  GROUP BY (TRIM(BOTH FROM unnest(string_to_array(t.errors, ','::text))))
  ORDER BY (count(*)) DESC;

-- View: public.v_fraud_amount_bins

-- DROP VIEW public.v_fraud_amount_bins;

CREATE OR REPLACE VIEW public.v_fraud_amount_bins
 AS
 SELECT count(*) AS transactions,
        CASE
            WHEN t.amount <= 10::numeric THEN 'A. <$10'::text
            WHEN t.amount >= 10.01 AND t.amount <= 50::numeric THEN 'B. $10-$50'::text
            WHEN t.amount >= 50.01 AND t.amount <= 200::numeric THEN 'C. $50-$200'::text
            ELSE 'D. >$200'::text
        END AS amount_bin,
    count(*) FILTER (WHERE l.is_fraud) AS fraud_tx,
    round(100.0 * count(*) FILTER (WHERE l.is_fraud)::numeric / count(*)::numeric, 2) AS fraud_pct
   FROM fact_transactions t
     JOIN fact_fraud_labels l ON t.transaction_id = l.transaction_id
  GROUP BY (
        CASE
            WHEN t.amount <= 10::numeric THEN 'A. <$10'::text
            WHEN t.amount >= 10.01 AND t.amount <= 50::numeric THEN 'B. $10-$50'::text
            WHEN t.amount >= 50.01 AND t.amount <= 200::numeric THEN 'C. $50-$200'::text
            ELSE 'D. >$200'::text
        END)
  ORDER BY (
        CASE
            WHEN t.amount <= 10::numeric THEN 'A. <$10'::text
            WHEN t.amount >= 10.01 AND t.amount <= 50::numeric THEN 'B. $10-$50'::text
            WHEN t.amount >= 50.01 AND t.amount <= 200::numeric THEN 'C. $50-$200'::text
            ELSE 'D. >$200'::text
        END);





