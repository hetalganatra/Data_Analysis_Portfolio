-- =====================================================
-- Ride Sharing Database Schema
-- =====================================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(80),
    date_joined DATE,
    is_driver INT NOT NULL DEFAULT 0,
    PRIMARY KEY (user_id),
    UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS riders (
    rider_id INT NOT NULL,
    user_id INT NOT NULL,
    rating DOUBLE,
    total_trips INT NOT NULL DEFAULT 0,
    created_at DATETIME,
    PRIMARY KEY (rider_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS drivers (
    driver_id INT NOT NULL,
    user_id INT NOT NULL,
    vehicle_make VARCHAR(50),
    vehicle_model VARCHAR(50),
    vehicle_year INT,
    license_plate VARCHAR(20),
    rating DOUBLE,
    join_date DATE,
    is_active INT NOT NULL DEFAULT 1,
    PRIMARY KEY (driver_id),
    UNIQUE (license_plate),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS locations (
    location_id INT NOT NULL,
    zone_name VARCHAR(100),
    city VARCHAR(80),
    latitude DOUBLE,
    longitude DOUBLE,
    zone_type VARCHAR(50),
    PRIMARY KEY (location_id)
);

CREATE TABLE IF NOT EXISTS trips (
    trip_id INT NOT NULL,
    rider_id INT NOT NULL,
    driver_id INT NOT NULL,
    pickup_location_id INT NOT NULL,
    dropoff_location_id INT NOT NULL,
    requested_at DATETIME,
    started_at DATETIME,
    completed_at DATETIME,
    status VARCHAR(20),
    distance_km DOUBLE,
    duration_mins INT,
    base_fare DOUBLE,
    surge_multiplier DOUBLE,
    total_fare DOUBLE,
    payment_method VARCHAR(20),
    PRIMARY KEY (trip_id),
    FOREIGN KEY (rider_id) REFERENCES riders(rider_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (pickup_location_id) REFERENCES locations(location_id),
    FOREIGN KEY (dropoff_location_id) REFERENCES locations(location_id)
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id INT NOT NULL,
    trip_id INT NOT NULL,
    amount DOUBLE,
    method VARCHAR(20),
    status VARCHAR(20),
    paid_at DATETIME,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
);

CREATE TABLE IF NOT EXISTS reviews (
    review_id INT NOT NULL,
    trip_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    reviewee_id INT NOT NULL,
    rating INT,
    comment TEXT,
    reviewed_at DATETIME,
    PRIMARY KEY (review_id),
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
);

CREATE TABLE IF NOT EXISTS cancellations (
    cancel_id INT NOT NULL,
    trip_id INT NOT NULL,
    cancelled_by VARCHAR(10),
    reason VARCHAR(100),
    cancelled_at DATETIME,
    PRIMARY KEY (cancel_id),
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
);