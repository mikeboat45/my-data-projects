CREATE DATABASE hotelanalysis;
-- CSV data imported using the Table Data Import Wizard. Table name: hotelbooking
-- Examine Table Data
SELECT *
FROM hotelbooking
LIMIT 25;
-- Exploratory Data Analysis
-- 1. Market segment generating the most revenue
SELECT
market_segment,
SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)) AS total_revenue
FROM hotelbooking
GROUP BY market_segment
ORDER BY total_revenue DESC;
-- 2. Number of bookings per market segment
SELECT
market_segment,
COUNT(*) AS total_bookings
FROM hotelbooking
GROUP BY market_segment
ORDER BY total_bookings DESC;
-- 3. Distribution of bookings across customer types
SELECT
customer_type,
COUNT(*) AS total_bookings
FROM hotelbooking
GROUP BY customer_type;
-- 4. Monthly booking trends
SELECT
YEAR(str_to_date(arrival_date, '%d/%m/%Y')) AS year,
MONTH(str_to_date(arrival_date, '%d/%m/%Y')) AS month,
COUNT(*) AS total_bookings
FROM hotelbooking
GROUP BY YEAR(str_to_date(arrival_date, '%d/%m/%Y')), MONTH(str_to_date(arrival_date, '%d/%m/%Y'))
ORDER BY YEAR(str_to_date(arrival_date, '%d/%m/%Y')), MONTH(str_to_date(arrival_date, '%d/%m/%Y'));
-- Customer Behaviour Analysis
-- 5. Average lead time for bookings per market_segment
SELECT avg(lead_time) as avg_lead_time
FROM hotelbooking;
SELECT
market_segment,
AVG(lead_time) AS avg_lead_time
FROM hotelbooking
GROUP BY market_segment
ORDER BY avg_lead_time;
-- 6. Room types with the highest cancellation rates
SELECT
reserved_room_type,
COUNT(*) AS cancellations,
(COUNT(*) * 100.0) / SUM(COUNT(*)) OVER () AS cancellation_rate
FROM hotelbooking
WHERE is_canceled = 1
GROUP BY reserved_room_type
ORDER BY cancellation_rate DESC;
-- 7. Countries with the most bookings (Top 10)
SELECT
country,
COUNT(*) AS total_bookings
FROM hotelbooking
GROUP BY country
ORDER BY total_bookings DESC
LIMIT 10;
-- 8. Repeat vs. new customer ratio
SELECT
is_repeated_guest,
COUNT(*) AS customer_count
FROM hotelbooking
GROUP BY is_repeated_guest;
-- Revenue Trend Analysis
-- 9. Room types generating the highest revenue
SELECT
assigned_room_type,
SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)) AS total_revenue
FROM hotelbooking
GROUP BY assigned_room_type
ORDER BY total_revenue DESC;
-- 10. Seasonal revenue trends
SELECT
seasons,
avg(adr) as average_revenue,
SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)) AS total_revenue
FROM
hotelbooking
GROUP BY seasons;