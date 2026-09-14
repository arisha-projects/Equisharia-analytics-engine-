CREATE DATABASE EquiShariaDB;
USE EquiShariaDB;
CREATE TABLE CompanyFinancials (
    CompanyID INT AUTO_INCREMENT PRIMARY KEY,
    StockTicker VARCHAR(20) NOT NULL,
    FiscalYear VARCHAR(10) NOT NULL,
    TotalAssets DECIMAL(15, 2) NOT NULL,
    TotalDebt DECIMAL(15, 2) NOT NULL,
    CashAndBank DECIMAL(15, 2) NOT NULL,
    InterestIncome DECIMAL(15, 2) NOT NULL,
    TotalRevenue DECIMAL(15, 2) NOT NULL
);
SELECT StockTicker, FiscalYear, TotalAssets, TotalDebt 
FROM CompanyFinancials;
USE EquiShariaDB;

INSERT INTO CompanyFinancials (StockTicker, FiscalYear, TotalAssets, TotalDebt, CashAndBank, InterestIncome, TotalRevenue) VALUES
-- 1. Bharti Airtel
('BHARTIARTL', 2024, 461168.10, 209503.70, 16936.50, 1530.10, 150122.90),

-- 2. Cipla
('CIPLA', 2024, 29845.62, 853.86, 7598.66, 486.27, 25774.06),

-- 3. Infosys
('INFY', 2024, 137887.00, 8933.00, 14723.00, 1135.00, 153670.00),

-- 4. ITC
('ITC', 2024, 91520.10, 305.27, 10582.49, 903.04, 76840.49),

-- 5. Maruti Suzuki
('MARUTI', 2024, 95932.10, 1195.90, 3326.10, 290.70, 141863.10),

-- 6. Reliance Industries
('RELIANCE', 2024, 1713292.00, 344845.00, 93427.00, 4887.00, 1000122.00),

-- 7. Sun Pharma
('SUNPHARMA', 2024, 85698.81, 3217.18, 14476.35, 1269.83, 48496.85),

-- 8. Tata Motors
('TATAMOTORS', 2024, 376046.21, 106720.59, 41040.67, 1980.25, 437927.77),

-- 9. TCS
('TCS', 2024, 153087.00, 7780.00, 11779.00, 1375.00, 240893.00),

-- 10. Wipro
('WIPRO', 2024, 114675.20, 15467.50, 9760.30, 1478.70, 89760.30);
CREATE VIEW View_ShariahComplianceEngine AS
SELECT 
    CompanyID,
    StockTicker,
    FiscalYear,
    TotalAssets,
    TotalDebt,
    CashAndBank,
    InterestIncome,
    TotalRevenue,
    
    -- AAOIFI Financial Ratios (%)
    ROUND((TotalDebt / TotalAssets) * 100, 2) AS Debt_To_Assets_Pct,
    ROUND((CashAndBank / TotalAssets) * 100, 2) AS Cash_To_Assets_Pct,
    ROUND((InterestIncome / TotalRevenue) * 100, 2) AS Purification_Ratio_Pct,
    
    -- Dynamic Compliance Logic (33% Rule)
    CASE 
        WHEN (TotalDebt / TotalAssets) < 0.33 
             AND (CashAndBank / TotalAssets) < 0.33 
        THEN 'Shariah Compliant'
        ELSE 'Non-Compliant'
    END AS Compliance_Status
FROM CompanyFinancials;
SELECT 
    StockTicker, 
    Debt_To_Assets_Pct, 
    Cash_To_Assets_Pct, 
    Purification_Ratio_Pct,
    Compliance_Status
FROM View_ShariahComplianceEngine
WHERE Compliance_Status = 'Shariah Compliant';
SELECT 
    StockTicker,
    Purification_Ratio_Pct,
    10000 AS Sample_Dividend_Received,
    ROUND((10000 * (Purification_Ratio_Pct / 100)), 2) AS Purification_Amount_Deduction
FROM View_ShariahComplianceEngine
WHERE Compliance_Status = 'Shariah Compliant';



