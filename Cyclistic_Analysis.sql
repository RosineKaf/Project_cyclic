-- Ajout de la durée du trajet (ride_length_min)
-- Création d'une nouvelle version de la table avec une colonne ride_length_min
-- Pour convertir les timestamps en durée (minutes)
-- Evite les erreurs d'UPDATE
CREATE OR REPLACE TABLE `cyclisticproject-451118.cyclic_data.all_trips_cleaned` AS 
SELECT *,
TIMESTAMP_DIFF(ended_at, started_at, SECOND) / 60 AS ride_length_min 
FROM `cyclisticproject-451118.cyclic_data.all_trips_cleaned`

-- Ajout du jour de la semaine (day_of_week)
-- Facilite l'analyse des tendances en semaine vs week-end 
-- 1= semaine , 7= Samedi
CREATE OR REPLACE TABLE `cyclisticproject-451118.cyclic_data.all_trips_cleaned` AS 
SELECT *, 
EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week
FROM `cyclisticproject-451118.cyclic_data.all_trips_cleaned`;

-- Ajout de l'heure de Départ
-- On extrait l'heure de départ pour analyser les heures
-- Permet d'anlyser les pics d'utlisation matin/soir
CREATE OR REPLACE TABLE 
`cyclisticproject-451118.cyclic_data.all_trips_cleaned` AS 
SELECT *, 
  EXTRACT(HOUR FROM started_at) AS start_hour 
FROM `cyclisticproject-451118.cyclic_data.all_trips_cleaned`;

-- Ajout de la distance entre stations 
-- Si les coordonnées GPS sont disponibles,on peut calculer la distancve des trajets en utlisant ST_DISTANCE
-- Mesure la distance des trajets en kilomètres
-- Permet d'analyser si les membres font des trajets plus courts que les occasionnels
CREATE OR REPLACE TABLE `cyclisticproject-451118.cyclic_data.all_trips_cleaned` AS 
SELECT *, 
ST_DISTANCE(
  ST_GEOGPOINT(start_lng, start_lat), 
  ST_GEOGPOINT(end_lng, end_lat)) / 1000 AS trip_distance_km 
  FROM `cyclisticproject-451118.cyclic_data.all_trips_cleaned`;
