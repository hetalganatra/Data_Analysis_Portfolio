-- =========================
-- Email Cleaning
-- =========================

-- Identify duplicate users based on email
SELECT email, COUNT(*) AS duplicate_count
FROM mydb.users
GROUP BY email
HAVING COUNT(*) > 1;

-- Check missing or empty email values
SELECT *
FROM mydb.users
WHERE email IS NULL
   OR TRIM(email) = '';

-- Check if duplicate emails exist
SELECT EXISTS (
    SELECT 1
    FROM mydb.users
    WHERE email IS NOT NULL
      AND TRIM(email) <> ''
    GROUP BY email
    HAVING COUNT(*) > 1
) AS has_duplicate_emails;

-- Identify duplicate emails after normalizing case and spaces
SELECT LOWER(TRIM(email)) AS normalized_email,
       COUNT(*) AS duplicate_count
FROM mydb.users
WHERE email IS NOT NULL
  AND TRIM(email) <> ''
GROUP BY LOWER(TRIM(email))
HAVING COUNT(*) > 1;

-- Check invalid email formats
SELECT EXISTS (
    SELECT 1
    FROM mydb.users
    WHERE email IS NOT NULL
      AND TRIM(email) <> ''
      AND NOT (
          TRIM(email) REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
      )
) AS has_invalid_emails;

-- Standardize email format
UPDATE mydb.users
SET email = LOWER(TRIM(email))
WHERE email IS NOT NULL;

-- Set invalid emails to NULL
UPDATE mydb.users
SET email = NULL
WHERE email IS NOT NULL
  AND NOT (
      TRIM(email) REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
  );

-- Validate cleaned emails
SELECT COUNT(*) AS invalid_email_count
FROM mydb.users
WHERE email IS NOT NULL
  AND TRIM(email) <> ''
  AND NOT (
      TRIM(email) REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
  );

  -- =========================
-- Phone Cleaning
-- =========================

-- Check missing or empty phone values
SELECT *
FROM mydb.users
WHERE phone IS NULL
   OR TRIM(phone) = '';

-- Identify invalid phone numbers
SELECT *
FROM mydb.users
WHERE phone IS NULL
   OR TRIM(phone) = ''
   OR NOT (TRIM(phone) REGEXP '^[0-9]{10}$');


-- Standardize Phone Numbers by Removing Spaces and Dashes
UPDATE mydb.users
SET phone = REPLACE(REPLACE(phone, '-', ''), ' ', '')
WHERE phone IS NOT NULL;

-- Set invalid phone numbers to NULL
UPDATE mydb.users
SET phone = NULL
WHERE phone IS NULL
   OR TRIM(phone) = ''
   OR NOT (TRIM(phone) REGEXP '^[0-9]{10}$');

-- Count NULL phone values after cleaning
SELECT COUNT(*) AS null_phone_count
FROM mydb.users
WHERE phone IS NULL;

-- Count wrongly formatted non-null phone values after cleaning
SELECT COUNT(*) AS wrong_format_count
FROM mydb.users
WHERE phone IS NOT NULL
  AND TRIM(phone) <> ''
  AND NOT (TRIM(phone) REGEXP '^[0-9]{10}$');

-- =========================
-- Rider Reference Validation
-- =========================
-- Check trips with invalid or missing rider references
SELECT COUNT(*) AS invalid_rider_trips
FROM mydb.trips t
LEFT JOIN mydb.riders r
  ON t.rider_id = r.rider_id
WHERE t.rider_id IS NULL
   OR r.rider_id IS NULL;

   -- Show trips with invalid rider references
SELECT t.*
FROM mydb.trips t
LEFT JOIN mydb.riders r
  ON t.rider_id = r.rider_id
WHERE t.rider_id IS NULL
   OR r.rider_id IS NULL;

-- Validate rider references after cleaning
   SELECT COUNT(*) AS invalid_rider_trips_after_fix
FROM mydb.trips t
LEFT JOIN mydb.riders r
  ON t.rider_id = r.rider_id
WHERE t.rider_id IS NOT NULL
  AND r.rider_id IS NULL;

-- =========================
-- Payment Validation
-- =========================
-- Identify invalid payment amounts
SELECT *
FROM mydb.payments
WHERE amount <= 0;

-- Fix invalid payment amounts by setting them to NULL
UPDATE mydb.payments
SET amount = NULL
WHERE amount <= 0;

-- Validate payment amounts after cleaning
SELECT COUNT(*) AS invalid_payment_count
FROM mydb.payments
WHERE amount <= 0;

-- =========================
-- Review Validation
-- =========================

-- Identify invalid ratings
SELECT *
FROM mydb.reviews
WHERE rating < 1 OR rating > 5;

-- Fix invalid ratings by setting them to NULL
UPDATE mydb.reviews
SET rating = NULL
WHERE rating < 1 OR rating > 5;

-- Validate ratings after cleaning
SELECT COUNT(*) AS invalid_rating_count
FROM mydb.reviews
WHERE rating < 1 OR rating > 5;

-- =========================
-- Trip Timestamp Validation
-- =========================

-- Check missing requested timestamps
SELECT *
FROM mydb.trips
WHERE requested_at IS NULL;

-- Check missing completed timestamps
SELECT *
FROM mydb.trips
WHERE completed_at IS NULL;

-- Count missing timestamps
SELECT
    COUNT(CASE WHEN requested_at IS NULL THEN 1 END) AS missing_requested_at,
    COUNT(CASE WHEN started_at IS NULL THEN 1 END) AS missing_started_at,
    COUNT(CASE WHEN completed_at IS NULL THEN 1 END) AS missing_completed_at
FROM mydb.trips;

-- Review trip statuses to confirm whether missing completed_at values are valid
SELECT status, COUNT(*) AS trip_count
FROM mydb.trips
GROUP BY status;

-- Identify trips with invalid time logic
SELECT *
FROM mydb.trips
WHERE completed_at < started_at;

-- Fix invalid completed timestamps
UPDATE mydb.trips
SET completed_at = NULL
WHERE completed_at < started_at;

-- Validate timestamp logic after cleaning
SELECT COUNT(*) AS invalid_timestamp_count
FROM mydb.trips
WHERE completed_at < started_at;

-- =========================
-- Driver Reference Validation
-- =========================
   SELECT COUNT(*) AS invalid_driver_trips
FROM mydb.trips t
LEFT JOIN mydb.drivers d
  ON t.driver_id = d.driver_id
WHERE t.driver_id IS NULL
   OR d.driver_id IS NULL;

-- =========================
-- Fare Validation
-- =========================
SELECT *
FROM mydb.trips
WHERE total_fare IS NULL
   OR total_fare < 0;

-- =========================
-- Distance and Duration Validation
-- =========================
SELECT *
FROM mydb.trips
WHERE distance_km <= 0
   OR duration_mins <= 0;


