# Fraud Transaction Analytics (PostgreSQL + Python)

## Dataset
Kaggle: Financial Transactions Dataset for Fraud Analytics

## Goal
Explore transaction behavior and identify patterns associated with fraudulent activity
using SQL (PostgreSQL) and Python.

## Tools
- PostgreSQL
- Python (pandas, matplotlib, scikit-learn)
- Docker (later)

## Key Findings

### 1. Transaction Method Is a Strong Fraud Risk Indicator
Analysis of over 8.9 million labeled transactions shows that online (card-not-present) transactions have a significantly higher fraud rate compared to in-person payment methods. Online transactions exhibit a fraud rate of approximately **0.84%**, compared to **0.10%** for chip-based transactions and **0.03%** for swipe-based transactions. This represents an **8× higher fraud risk than chip transactions** and **over 25× higher risk than swipe transactions**, highlighting transaction method as a critical signal for fraud detection systems.

## Status
🚧 In progress
