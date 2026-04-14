-- Total trips
SELECT COUNT(*) AS total_trips
FROM mydb.trips;

-- Total revenue
SELECT SUM(total_fare) AS total_revenue
FROM mydb.trips;

-- Average fare
SELECT AVG(total_fare) AS avg_fare
FROM mydb.trips;

-- Average trip duration
SELECT AVG(duration_mins)
FROM mydb.trips;

-- Average distance
SELECT AVG(distance_km)
FROM mydb.trips;

-- Top 5 drivers
SELECT d.driver_id,
       u.name AS driver_name,
       COUNT(*) AS trip_count
FROM mydb.trips t
JOIN mydb.drivers d
  ON d.driver_id = t.driver_id
JOIN mydb.users u
  ON u.user_id = d.user_id
GROUP BY d.driver_id, u.name
ORDER BY trip_count DESC
LIMIT 5;

-- Top 5 riders
SELECT r.rider_id,
       u.name AS rider_name,
       COUNT(*) AS trip_count
FROM mydb.trips t
JOIN mydb.riders r
  ON r.rider_id = t.rider_id
JOIN mydb.users u
  ON u.user_id = r.user_id
GROUP BY r.rider_id, u.name
ORDER BY trip_count DESC
LIMIT 5;


-- Most popular pickup locations
SELECT l.location_id,
       l.zone_name AS pickup_location_name,
       l.city,
       COUNT(*) AS trips
FROM mydb.trips t
JOIN mydb.locations l
  ON l.location_id = t.pickup_location_id
GROUP BY l.location_id, l.zone_name, l.city
ORDER BY trips DESC
LIMIT 10;


-- Most popular drop locations
SELECT l.location_id,
       l.zone_name AS dropoff_location_name,
       l.city,
       COUNT(*) AS trips
FROM mydb.trips t
JOIN mydb.locations l
  ON l.location_id = t.dropoff_location_id
GROUP BY l.location_id, l.zone_name, l.city
ORDER BY trips DESC
LIMIT 10;

-- Revenue by payment method
SELECT payment_method, SUM(total_fare)
FROM mydb.trips
GROUP BY payment_method;

-- Trip status distribution
SELECT status, COUNT(*) 
FROM mydb.trips
GROUP BY status;

-- Surge pricing analysis
SELECT
  CASE
    WHEN surge_multiplier = 1 THEN 'No Surge'
    WHEN surge_multiplier <= 1.5 THEN 'Low'
    WHEN surge_multiplier <= 2 THEN 'Medium'
    ELSE 'High'
  END AS surge_band,
  COUNT(*) AS trips,
  AVG(total_fare) AS avg_fare
FROM mydb.trips
GROUP BY surge_band;

-- Trips per day
SELECT DATE(requested_at) AS trip_date,
       COUNT(*) AS trip_count
FROM mydb.trips
GROUP BY DATE(requested_at)
ORDER BY trip_count DESC;

-- Peak hour analysis
SELECT HOUR(requested_at) AS hour,
       COUNT(*) AS trips
FROM mydb.trips
GROUP BY hour
ORDER BY trips DESC;

-- Highest fare trips
SELECT *
FROM mydb.trips
ORDER BY total_fare DESC
LIMIT 10;

-- Cancelled trip percentage
SELECT
  ROUND(
    100.0 * SUM(CASE WHEN LOWER(status) = 'cancelled' THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS cancelled_percentage
FROM mydb.trips;