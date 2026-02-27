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

### 2. Fraud Risk Is Concentrated in Specific Merchant Categories

Fraud risk is not evenly distributed across merchant categories. Analysis of merchant category codes (MCCs) with sufficient labeled volume (≥1,000 transactions) shows that certain categories exhibit fraud rates **an order of magnitude higher than the overall baseline**. The highest-risk categories include merchants selling high-value or easily resellable goods—such as computers, electronics, and precious metals—as well as digital or ticket-based services with rapid fulfillment.

These categories demonstrate fraud rates ranging from approximately **2% to over 10%**, compared to a sub-1% rate across all labeled transactions. This concentration suggests that merchant category is a critical contextual signal for fraud detection and highlights the importance of incorporating MCC-level features into risk scoring, monitoring, and model development.

### 3. — Error signals: frequency ≠ fraud risk
Among labeled transactions with errors, Insufficient Balance is the most common error (~88k), but has a low fraud rate (~0.20%). In contrast, authentication-related errors show higher fraud association—Bad CVV has the highest fraud rate (~3.39%; 142 fraud out of ~4.2k labeled error transactions). This suggests error type is a useful feature for fraud detection, with Bad CVV in particular warranting stronger review or step-up authentication.

### 4. — Fraud risk rises with transaction amount
Across labeled transactions, fraud rates increase as amounts get larger. Transactions >$200 show the highest fraud rate (~1.03%) compared with $50–$200 (0.21%), <$10 (0.11%), and $10–$50 (0.08%). This suggests high-dollar transactions warrant stronger monitoring or step-up verification.

## Status
🚧 In progress
