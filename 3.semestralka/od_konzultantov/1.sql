-- 1
SELECT spz, count(*)
    FROM historia_parkovania
        WHERE odkedy >= add_months(sysdate, -12) OR
        NVL(dokedy, sysdate) >= add_months(sysdate, -12)
        GROUP BY spz
        HAVING COUNT(*) > 5;
        