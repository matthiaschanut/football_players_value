SELECT 
    *EXCEPT(season,date),
    CAST(date AS DATE) as date,
    CONCAT(ROUND(season,0),"/",ROUND(season,0)+1) as season
FROM `transfermarkt-391212.kaggle_data.games` 