-- Suprression des doublons/Eviter d'analyser plusieurs fois le même trajet
CREATE OR REPLACE TABLE `cyclisticproject-451118.cyclic_data.all_trips_cleaned` AS
SELECT DISTINCT *
FROM `cyclisticproject-451118.cyclic_data.all`;

-- Gestion des valeurs manquantes
SELECT
COUNT(*) AS total_rows,
SUM(CASE WHEN start_station_name IS NULL THEN 1 ELSE 0 END) AS missing_start_station,
SUM(CASE WHEN end_station_name IS NULL THEN 1 ELSE 0 END) AS missing_end_station,
SUM(CASE WHEN start_lat IS NULL OR start_lng IS NULL THEN 1 ELSE 0 END) AS missing_start_coords,
SUM(CASE WHEN end_lat IS NULL OR end_lng IS NULL THEN 1 ELSE 0 END) AS missing_end_coords
FROM `cyclisticproject-451118.cyclic_data.all_trips_cleaned`;

-- Filtrage des trajets anormaux
-- Les trajets de moins d'une minute (probablement une erreur ou un test)
-- Les trajets de plus de 24 heures (problème de plus de retour du vélo)
CREATE OR REPLACE TABLE `cyclisticproject-451118.cyclic_data.all_trips_cleaned` AS
SELECT *
FROM `cyclisticproject-451118.cyclic_data.all_trips_cleaned`
WHERE TIMESTAMP_DIFF(ended_at, started_at, MINUTE) BETWEEN 1 AND 1440;
