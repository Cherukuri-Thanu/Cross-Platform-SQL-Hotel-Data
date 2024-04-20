-- STEP1: CREATING A DATABASE:

--DROP TABLE hotel_meals
--DROP TABLE hotel_data_2018
--DROP TABLE hotel_data_2019
--DROP TABLE hotel_data_2020
--DROP TABLE hotel_market_segment

CREATE TABLE meals(
    cost DECIMAL(10, 2),
    meal VARCHAR(50)
)

BULK INSERT meals
FROM '/var/opt/mssql/data/hotel_meal_cost.csv'
WITH
(
    FIELDTERMINATOR = ',',    -- CSV field delimiter
    ROWTERMINATOR = '0x0D0A', -- Hexadecimal value for \r\n
    FIRSTROW = 2             -- Assuming your CSV has column headers in the first row
);

CREATE TABLE hotel_data_2018(
    hotel VARCHAR(50),
    is_canceled INT,
    lead_time INT,
    arrival_date_year INT,
    arrival_date_month VARCHAR(20),
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children VARCHAR(10) NULL,
    babies INT,
    meal VARCHAR(50),
    country VARCHAR(50),
    market_segment VARCHAR(50),
    distribution_channel VARCHAR(50),
    is_repeated_guest INT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type VARCHAR(10),
    assigned_room_type VARCHAR(10),
    booking_changes INT,
    deposit_type VARCHAR(50),
    agent VARCHAR(10) NULL,  -- Updated to INT based on example
    company VARCHAR(255) NULL, -- Updated to INT and made nullable based on example
    days_in_waiting_list INT,
    customer_type VARCHAR(50),
    adr DECIMAL(10, 2), -- Using DECIMAL for monetary values
    required_car_parking_spaces INT,
    total_of_special_requests INT,
    reservation_status VARCHAR(50),
    reservation_status_date DATE -- Ensure correct format during insertion
)

BULK INSERT hotel_data_2018
FROM '/var/opt/mssql/data/hotel_data_2018.csv'
WITH
(
    FIELDTERMINATOR = ',',    -- CSV field delimiter
    ROWTERMINATOR = '0x0D0A', -- Hexadecimal value for \r\n
    FIRSTROW = 2             -- Assuming your CSV has column headers in the first row
);

CREATE TABLE hotel_data_2019(
    hotel VARCHAR(50),
    is_canceled INT,
    lead_time INT,
    arrival_date_year INT,
    arrival_date_month VARCHAR(20),
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children VARCHAR(10) NULL,  -- Altered to handle 'N/A' values and NULL
    babies INT,
    meal VARCHAR(50),
    country VARCHAR(50),
    market_segment VARCHAR(50),
    distribution_channel VARCHAR(50),
    is_repeated_guest INT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type VARCHAR(10),
    assigned_room_type VARCHAR(10),
    booking_changes INT,
    deposit_type VARCHAR(50),
    agent VARCHAR(10) NULL,  -- Altered to handle 'NULL' and mixed data types
    company VARCHAR(255) NULL,  -- Altered to handle 'NULL'
    days_in_waiting_list INT,
    customer_type VARCHAR(50),
    adr DECIMAL(10, 2),  -- Using DECIMAL for monetary values
    required_car_parking_spaces INT,
    total_of_special_requests INT,
    reservation_status VARCHAR(50),
    reservation_status_date DATE  -- Ensure correct format during insertion
)

BULK INSERT hotel_data_2019
FROM '/var/opt/mssql/data/hotel_data_2019.csv'
WITH
(
    FIELDTERMINATOR = ',',    -- CSV field delimiter
    ROWTERMINATOR = '0x0D0A', -- Hexadecimal value for \r\n
    FIRSTROW = 2             -- Assuming your CSV has column headers in the first row
);

CREATE TABLE hotel_data_2020(
    hotel VARCHAR(50),
    is_canceled INT,
    lead_time INT,
    arrival_date_year INT,
    arrival_date_month VARCHAR(20),
    arrival_date_week_number INT,
    arrival_date_day_of_month INT,
    stays_in_weekend_nights INT,
    stays_in_week_nights INT,
    adults INT,
    children VARCHAR(10) NULL,  -- Altered to handle 'N/A' values and NULL
    babies INT,
    meal VARCHAR(50),
    country VARCHAR(50),
    market_segment VARCHAR(50),
    distribution_channel VARCHAR(50),
    is_repeated_guest INT,
    previous_cancellations INT,
    previous_bookings_not_canceled INT,
    reserved_room_type VARCHAR(10),
    assigned_room_type VARCHAR(10),
    booking_changes INT,
    deposit_type VARCHAR(50),
    agent VARCHAR(10) NULL,  -- Altered to handle 'NULL' and mixed data types
    company VARCHAR(255) NULL,  -- Altered to handle 'NULL'
    days_in_waiting_list INT,
    customer_type VARCHAR(50),
    adr DECIMAL(10, 2),  -- Using DECIMAL for monetary values
    required_car_parking_spaces INT,
    total_of_special_requests INT,
    reservation_status VARCHAR(50),
    reservation_status_date DATE  -- Ensure correct format during insertion
)

BULK INSERT hotel_data_2020
FROM '/var/opt/mssql/data/hotel_data_2020.csv'
WITH
(
    FIELDTERMINATOR = ',',    -- CSV field delimiter
    ROWTERMINATOR = '0x0D0A', -- Hexadecimal value for \r\n
    FIRSTROW = 2             -- Assuming your CSV has column headers in the first row
);

CREATE TABLE hotel_market_segment(
    discount DECIMAL(10, 7),
    market_segment VARCHAR(100)
)

BULK INSERT hotel_market_segment
FROM '/var/opt/mssql/data/hotel_market_segment.csv'
WITH
(
    FIELDTERMINATOR = ',',    -- CSV field delimiter
    ROWTERMINATOR = '0x0D0A', -- Hexadecimal value for \r\n
    FIRSTROW = 2             -- Assuming your CSV has column headers in the first row
);

--STEP-2: EDA:
--SELECT * FROM dbo.hotel_data_2018
--SELECT * FROM dbo.hotel_data_2019
--SELECT * FROM dbo.hotel_data_2020

--Combine all the hotels data from years into single sheet for doing revenue analysis:
WITH hotels as (
    SELECT * FROM dbo.hotel_data_2018
    UNION
    SELECT * FROM dbo.hotel_data_2019
    UNION
    SELECT * FROM dbo.hotel_data_2020
)
SELECT * FROM hotels;

--Calculate total revenue throughout the years:
SELECT (stays_in_week_nights+stays_in_weekend_nights)*adr AS revenue from hotels
SELECT SUM((stays_in_week_nights+stays_in_weekend_nights)*adr) AS total_revenue from hotels --39358172.70

--Calculate 2018 yearly revenue:
SELECT SUM((stays_in_week_nights+stays_in_weekend_nights)*adr) AS yearly_revenue_for_2018 FROM hotels
WHERE arrival_date_year = 2018 --4885517.06
--Calculate 2019 yearly revenue:
SELECT SUM((stays_in_week_nights+stays_in_weekend_nights)*adr) AS yearly_revenue_for_2019 FROM hotels
WHERE arrival_date_year = 2019; --20188409.40
--Calculate 2020 yearly revenue:
SELECT SUM((stays_in_week_nights+stays_in_weekend_nights)*adr) AS yearly_revenue_for_2020 FROM hotels
WHERE arrival_date_year = 2020; --14284246.24

-- Revenue trend by year:
SELECT 
    arrival_date_year,
    SUM((stays_in_week_nights+stays_in_weekend_nights)*adr) AS revenue
FROM hotels
GROUP BY arrival_date_year;

--Revenue trend by hotel type:
SELECT 
    arrival_date_year, hotel,
    SUM((stays_in_week_nights+stays_in_weekend_nights)*adr) AS revenue FROM hotels
GROUP BY arrival_date_year, hotel;

-- Merge market_segment column from 'Hotelmarketsegment' Table with 'hotels' table:

WITH hotels as (
    SELECT * FROM dbo.hotel_data_2018
    UNION
    SELECT * FROM dbo.hotel_data_2019
    UNION
    SELECT * FROM dbo.hotel_data_2020)

SELECT * FROM hotels ho
left JOIN hotel_market_segment h on h.market_segment = ho.market_segment
left JOIN meals m on m.meal = ho.meal;


