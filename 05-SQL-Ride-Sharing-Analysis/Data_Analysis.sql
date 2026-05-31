-- =====================================================
-- Basic KPI Analysis
-- =====================================================

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

-- =====================================================
-- Driver & Rider Analysis
-- =====================================================
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

-- =====================================================
-- Location Analysis
-- =====================================================
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

-- =====================================================
-- Most popular drop locations
-- =====================================================
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


-- Highest fare trips
SELECT *
FROM mydb.trips
ORDER BY total_fare DESC
LIMIT 10;


-- =====================================================
-- Advanced Business Analysis Queries
-- =====================================================

-- =====================================================
-- Revenue Analysis
-- =====================================================
-- Revenue by payment method
SELECT payment_method, SUM(total_fare)
FROM mydb.trips
GROUP BY payment_method;

-- Revenue by city
SELECT l.city,
       SUM(t.total_fare) AS total_revenue
FROM mydb.trips t
JOIN mydb.locations l
  ON l.location_id = t.pickup_location_id
GROUP BY l.city
ORDER BY total_revenue DESC;

-- Evaluate High-Demand Pickup Locations to Support Operational Planning
SELECT l.zone_name AS pickup_zone,
       l.city,
       COUNT(*) AS trip_count
FROM mydb.trips t
JOIN mydb.locations l
  ON l.location_id = t.pickup_location_id
GROUP BY l.zone_name, l.city
ORDER BY trip_count DESC
LIMIT 10;

-- Peak hour analysis
SELECT HOUR(requested_at) AS hour,
       COUNT(*) AS trips
FROM mydb.trips
GROUP BY hour
ORDER BY trips DESC;

-- Cancelled trip percentage

SELECT
  ROUND(
    100.0 * SUM(CASE WHEN LOWER(status) = 'cancelled' THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS cancelled_percentage
FROM mydb.trips;

-- Compare Average Fare and Base Fare Across Surge Pricing Levels
SELECT
  CASE
    WHEN surge_multiplier = 1 THEN 'No Surge'
    WHEN surge_multiplier <= 1.5 THEN 'Low'
    WHEN surge_multiplier <= 2 THEN 'Medium'
    ELSE 'High'
  END AS surge_band,
  COUNT(*) AS trips,
  AVG(total_fare) AS avg_fare,
  AVG(total_fare / surge_multiplier) AS avg_base_fare
FROM mydb.trips
GROUP BY surge_band
ORDER BY avg_fare DESC;

-- Monthly revenue trend
SELECT
  DATE_FORMAT(requested_at, '%Y-%m-01') AS month,
  SUM(total_fare) AS monthly_revenue
FROM mydb.trips
GROUP BY month
ORDER BY month;

-- Analyze Driver Performance by Trip Volume, Revenue Generation, and Average Fare
SELECT d.driver_id,
       u.name AS driver_name,
       COUNT(*) AS trip_count,
       SUM(total_fare) AS total_revenue,
       AVG(total_fare) AS avg_fare
FROM mydb.trips t
JOIN mydb.drivers d
  ON d.driver_id = t.driver_id
JOIN mydb.users u
  ON u.user_id = d.user_id
GROUP BY d.driver_id, u.name
ORDER BY total_revenue DESC;

-- Analyze the Impact of Surge Pricing on Trip Volume, Revenue, and Fare Performance
SELECT
  CASE
    WHEN surge_multiplier = 1 THEN 'No Surge'
    WHEN surge_multiplier <= 1.5 THEN 'Low'
    WHEN surge_multiplier <= 2 THEN 'Medium'
    ELSE 'High'
  END AS surge_band,
  COUNT(*) AS trips,
  SUM(total_fare) AS total_revenue,
  AVG(total_fare) AS avg_fare,
  ROUND(100.0 * SUM(total_fare) / SUM(SUM(total_fare)) OVER (), 2) AS revenue_share_pct
FROM mydb.trips
GROUP BY surge_band
ORDER BY total_revenue DESC;

-- Analyze Rider Behavior: Trip Frequency, Total Spend, and Average Fare
SELECT r.rider_id,
       u.name AS rider_name,
       COUNT(*) AS trip_count,
       SUM(total_fare) AS total_spend,
       AVG(total_fare) AS avg_fare
FROM mydb.trips t
JOIN mydb.riders r
  ON r.rider_id = t.rider_id
JOIN mydb.users u
  ON u.user_id = r.user_id
GROUP BY r.rider_id, u.name
ORDER BY trip_count DESC;

-- Rank Drivers by Revenue Performance

SELECT
    driver_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM (
    SELECT
        u.name AS driver_name,
        SUM(t.total_fare) AS total_revenue
    FROM mydb.trips t
    JOIN mydb.drivers d
        ON t.driver_id = d.driver_id
    JOIN mydb.users u
        ON d.user_id = u.user_id
    GROUP BY u.name
) driver_revenue;