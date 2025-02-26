-- Stations les plus utlisées par type d'utlisateur
SELECT 
  member_casual, 
  start_station_name, 
  COUNT(ride_id) AS total_trips 
FROM `cyclisticproject-451118.cyclic_data.all_trips_cleaned` 
WHERE start_station_name IS NOT NULL 
GROUP BY member_casual, start_station_name 
ORDER BY total_trips DESC 
LIMIT 10;

-- Distance moyenne des trajets
SELECT 
  member_casual,  
  ROUND(AVG(ride_length_min), 2) AS avg_duration_min,  
FROM `cyclisticproject-451118.cyclic_data.all_trips_cleaned` 
WHERE ride_length_min > 0
GROUP BY member_casual

-- Heures de pointes des trajets 
SELECT 
  member_casual, 
  start_hour, 
  COUNT(ride_id) AS total_trips
FROM `cyclisticproject-451118.cyclic_data.all_trips_cleaned` 
GROUP BY member_casual, start_hour 
ORDER BY member_casual, start_hour;
