create database OLA

CREATE TABLE bookings (
    date TIMESTAMP,                        
    time TIME,                            
    booking_id TEXT,                      
    booking_status TEXT,                   
    customer_id TEXT,                     
    vehicle_type TEXT,                     
    pickup_location TEXT,                  
    drop_location TEXT,                    
    v_tat BIGINT,                          
    c_tat BIGINT,                          
    canceled_rides_by_customer TEXT,       
    canceled_rides_by_driver TEXT,         
    incomplete_rides TEXT,                 
    incomplete_rides_reason TEXT,          
    booking_value BIGINT,                  
    payment_method TEXT,                   
    ride_distance BIGINT,                  
    driver_ratings NUMERIC(3,1),           
    customer_rating NUMERIC(3,1),          
    vehicle_images TEXT                    
);

ALTER TABLE cab_bookings RENAME TO bookings;

-- 🔍 1. View all records
SELECT * FROM bookings;

-- 📊 2. Get total number of rows (total rides)
SELECT COUNT(*) FROM bookings;

-- ✅ 3. Retrieve all successful bookings
SELECT * FROM bookings
WHERE booking_status = 'Success';

-- ✅ 4. Count of successful bookings
SELECT COUNT(*) FROM bookings
WHERE booking_status = 'Success';

-- 📏 5. Average ride distance per vehicle type
SELECT vehicle_type, AVG(ride_distance) AS average_distance
FROM bookings
GROUP BY vehicle_type;

-- ❌ 6. Total rides canceled by customers
SELECT COUNT(*) FROM bookings
WHERE booking_status = 'Canceled by Customer';

-- ❌ 7. View all customer-canceled rides
SELECT * FROM bookings
WHERE booking_status = 'Canceled by Customer';

-- 👑 8. Top 5 customers by total number of rides
CREATE VIEW top_5_customers AS
SELECT customer_id, COUNT(booking_id) AS total_rides
FROM bookings
GROUP BY customer_id
ORDER BY total_rides DESC
LIMIT 5;

-- 🔍 9. View the top 5 customers
SELECT * FROM top_5_customers;

-- ❌ 10. Rides canceled by drivers due to personal & car-related issues
SELECT COUNT(*) AS total_driver_cancellations
FROM bookings
WHERE canceled_rides_by_driver = 'Personal & Car related issue';

-- 🔍 11. View all recordsView all records
SELECT * FROM bookings;

-- ⭐ 12. Max & Min driver ratings for Prime Sedan
SELECT vehicle_type,
       MAX(driver_ratings) AS max_rating,
       MIN(driver_ratings) AS min_rating
FROM bookings
WHERE vehicle_type = 'Prime Sedan'
GROUP BY vehicle_type;

-- 💳 13. All rides paid via UPI
SELECT * FROM bookings
WHERE payment_method = 'UPI';

-- ⭐ 14. Average customer rating per vehicle type
SELECT vehicle_type, AVG(customer_rating) AS average_customer_rating
FROM bookings 
GROUP BY vehicle_type
ORDER BY average_customer_rating DESC;

-- 💰 15. Total booking value of successful rides
SELECT booking_status, SUM(booking_value) AS value_of_succ_completed_rides
FROM bookings
WHERE booking_status = 'Success'
GROUP BY booking_status;

-- ❗ 16. Incomplete rides and their reasons
SELECT incomplete_rides, incomplete_rides_reason
FROM bookings
WHERE incomplete_rides = 'Yes';

-- 📍 17. Top 5 drop locations by ride count
SELECT drop_location, COUNT(*) AS total_drops
FROM bookings
GROUP BY drop_location
ORDER BY total_drops DESC
LIMIT 5;

-- 🚏 18. Top 5 pickup locations by ride count
SELECT pickup_location, COUNT(*) AS total_pickups
FROM bookings
GROUP BY pickup_location
ORDER BY total_pickups DESC
LIMIT 5;

-- 🛣️ 19. Average ride distance by vehicle type
SELECT vehicle_type, ROUND(AVG(ride_distance), 2) AS avg_ride_distance
FROM bookings
GROUP BY vehicle_type
ORDER BY avg_ride_distance DESC;

-- 💳 20. Revenue share by payment method (% contribution)
SELECT 
  payment_method,
  SUM(booking_value) AS total_revenue,
  ROUND(
    SUM(booking_value) * 100.0 / SUM(SUM(booking_value)) OVER(), 1
  ) AS revenue_percentage
FROM bookings
GROUP BY payment_method
ORDER BY total_revenue DESC;







