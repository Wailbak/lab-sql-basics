USE bank;

SELECT
  client_id
FROM
  client
WHERE
  district_id = 1
ORDER BY
  client_id
LIMIT
  5;
  
  
SELECT
  client_id
FROM
  client
WHERE
  district_id = 72
ORDER BY
  client_id DESC
LIMIT
  1;
  
  
  SELECT
  amount
FROM
  loan
ORDER BY
  amount
LIMIT
  3;
  
  SELECT DISTINCT status FROM loan ORDER BY status ASC;


SELECT loan_id FROM bank.loan ORDER BY payments ASC LIMIT 1;


SELECT account_id, amount
FROM bank.loan
ORDER BY account_id
LIMIT 5;

SELECT account_id
FROM bank.loan
WHERE duration = 60
ORDER BY amount
LIMIT 5;

SELECT DISTINCT k_symbol
FROM `bank`.`order`
WHERE k_symbol IS NOT NULL AND k_symbol != ''
ORDER BY k_symbol;

SELECT order_id
FROM `bank`.`order`
WHERE account_id = 34;

SELECT DISTINCT account_id
FROM `bank`.`order`
WHERE order_id BETWEEN 29540 AND 29560;

SELECT amount
FROM `bank`.`order`
WHERE account_to = 30067122;

SELECT trans_id, date, type, amount
FROM `bank`.`trans`
WHERE account_id = 793
ORDER BY date DESC
LIMIT 10;

SELECT district_id, COUNT(*) AS num_clients
FROM `bank`.`client`
WHERE district_id < 10
GROUP BY district_id
ORDER BY district_id ASC;

SELECT type, COUNT(*) AS num_cards
FROM `bank`.`card`
GROUP BY type
ORDER BY num_cards DESC;

SELECT account_id, SUM(amount) AS total_loan_amount
FROM `bank`.`loan`
GROUP BY account_id
ORDER BY total_loan_amount DESC
LIMIT 10;

SELECT date, COUNT(*) AS num_loans
FROM `bank`.`loan`
WHERE date < 930907
GROUP BY date
ORDER BY date DESC;

SELECT date, duration, COUNT(*) AS num_loans
FROM `bank`.`loan`
WHERE date >= 971201 AND date < 980101
GROUP BY date, duration
ORDER BY date ASC, duration ASC;

SELECT account_id, type, SUM(amount) AS total_amount
FROM `bank`.`trans`
WHERE account_id = 396
GROUP BY account_id, type
ORDER BY type ASC;

SELECT account_id,
       CASE
           WHEN type = 'PRIJEM' THEN 'Incoming'
           WHEN type = 'VYDAJ' THEN 'Outgoing'
           ELSE 'Unknown'
       END AS transaction_type,
       ROUND(SUM(amount), 0) AS total_amount
FROM `bank`.`trans`
WHERE account_id = 396
GROUP BY account_id, type
ORDER BY transaction_type ASC;

SELECT
    account_id,
    CAST(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END) AS UNSIGNED) AS incoming_amount,
    CAST(SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END) AS UNSIGNED) AS outgoing_amount,
    CAST(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END) - SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END) AS SIGNED) AS difference
FROM `bank`.`trans`
WHERE account_id = 396;

SELECT
    account_id,
    CAST(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END) - SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END) AS SIGNED) AS difference,
    RANK() OVER (ORDER BY CAST(SUM(CASE WHEN type = 'PRIJEM' THEN amount ELSE 0 END) - SUM(CASE WHEN type = 'VYDAJ' THEN amount ELSE 0 END) AS SIGNED) DESC) AS rank_number
FROM `bank`.`trans`
GROUP BY account_id
ORDER BY difference DESC
LIMIT 10;










