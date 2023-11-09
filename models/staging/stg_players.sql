SELECT 
    *EXCEPT(date_of_birth),
    CAST(date_of_birth AS DATE) as date_of_birth
FROM `transfermarkt-391212.kaggle_data.players` 
