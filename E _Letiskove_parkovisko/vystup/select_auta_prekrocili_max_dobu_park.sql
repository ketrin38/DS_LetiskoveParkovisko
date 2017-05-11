-- vyh¾adavanie aut a kde parkuje, ktoré prevyšili maximálnu dobu parkovania a na danom parkovacom mieste
        SELECT HP.SPZ, PM.ID_MIESTA, ZONA.ID_ZONA, HP.ODKEDY
          FROM HISTORIA_PARKOVANIA  HP
    INNER JOIN PARKOVACIE_MIESTO PM
            ON PM.ID_MIESTA = HP.ID_MIESTA
    INNER JOIN ZONA 
            ON ZONA.ID_ZONA = PM.ID_ZONA
         WHERE ((NVL(HP.DOKEDY,SYSDATE) - HP.ODKEDY)*24) > ZONA.MAXIMALNA_DOBA;
         