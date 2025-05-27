UPDATE products SET stock_count = CASE
    WHEN id = 1 THEN 100
    WHEN id = 2 THEN 100
    WHEN id = 3 THEN 100
    WHEN id = 4 THEN 100
    WHEN id = 5 THEN 100
    WHEN id = 6 THEN 100
    WHEN id = 7 THEN 100
    WHEN id = 8 THEN 100
    WHEN id = 9 THEN 100
    WHEN id = 10 THEN 100
    WHEN id = 11 THEN 100
    WHEN id = 12 THEN 100
    WHEN id = 13 THEN 100
    WHEN id = 14 THEN 100
    WHEN id = 15 THEN 100
END
WHERE id BETWEEN 1 AND 15;