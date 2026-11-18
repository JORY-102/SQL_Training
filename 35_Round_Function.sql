-- Round a price to different decimal places
SELECT
    12.786 AS OriginalPrice,
    ROUND(12.786, 2) AS Round_2,
    ROUND(12.786, 1) AS Round_1,
    ROUND(12.786, 0) AS Round_0;