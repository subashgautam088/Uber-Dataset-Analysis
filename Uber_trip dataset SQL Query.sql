USE superstore_db;

# 1.Total number of trips.
SELECT COUNT(*) FROM ncr_ride_bookings;

# 2.Average fare amount.
SELECT ROUND(AVG(`Booking Value`),2) AS AVG_fare FROM uber;

# 3.Tota revenue generated.
SELECT SUM(`Booking Value`) FROM uber;

# 4.Maximum trip distance.
SELECT MAX(`Ride Distance`) AS max_trip FROM uber;

# 5.Average passenger count.
SELECT AVG(pass_count) FROM(SELECT row_number() OVER() AS pass_count FROM uber) t;

# 6.Trips where fare > 50.
SELECT `Booking Value` AS fare FROM uber WHERE `Booking Value` >  50;

# 7.Trips where distance > 10 miles means 16KM.
SELECT `Ride Distance` AS dist FROM uber WHERE `Ride Distance` > 16;

# 8.Total trips per passenger count.
SELECT `Booking ID`,COUNT(`Customer ID`) AS tot_trips FROM uber GROUP BY `Booking ID` ORDER BY tot_trips DESC;

# 9.Earliest trip date.
SELECT `Customer ID`, `Date` AS ear_dat FROM uber GROUP BY `Customer ID`,`Date` ORDER BY ear_dat ASC;

# 10.Latest trip date.
SELECT `Customer ID`, `Date` AS ear_dat FROM uber GROUP BY `Customer ID`,`Date` ORDER BY ear_dat DESC;

# 11. Total revenue per day.
SELECT SUM(`Booking Value`),Date FROM uber GROUP BY Date ORDER BY Date;

# 12.Average trip distance per day.
SELECT DATE AS per_day, AVG(`Ride Distance`) AS avg_dist
	FROM uber GROUP BY DATE ORDER BY per_day;

# 13.Trips per hour of day.
SELECT 
    HOUR(Time) AS trip_hour,
    COUNT(*) AS total_trips
	FROM uber
	GROUP BY HOUR(Time)
	ORDER BY trip_hour;
    
# 14.Peak hour of Uber rides.
SELECT HOUR(Time) AS trip_hr,COUNT(*) AS total_trip FROM uber 
	GROUP BY HOUR(Time) ORDER BY total_trip DESC LIMIT 5;
    
# 15.Total revenue per passenger count.
SELECT `Customer ID`,COUNT(`Customer ID`),SUM(`Booking Value`) AS tot_rev,SUM(`Ride Distance`) 
		FROM uber GROUP BY `Customer ID` ORDER BY tot_rev DESC;


# 16.Top 10 longest trips.
SELECT `Customer ID`,`Ride Distance` FROM uber ORDER BY `Ride Distance` DESC LIMIT 10;

# 17. Average fare per mile.
SELECT SUM(`Booking Value`)/ SUM(`Ride Distance`) AS fare_per_mile FROM uber;

# 18.Trips where distance > average distance.
SELECT 
    u.`Customer ID`,
    u.`Ride Distance`,
    a.avg_distance
		FROM uber u
		CROSS JOIN (
			SELECT AVG(`Ride Distance`) AS avg_distance 
			FROM uber
		) a
		WHERE u.`Ride Distance` > a.avg_distance;

# 19.Total revenue per month.
SELECT MONTH(Date),SUm(`Booking Value`) AS tot_revenue FROM uber GROUP BY MONTH(Date) ORDER BY tot_revenue DESC;

# 20.Trips with fare higher than average fare.
SELECT u.`Booking ID`, u.`Booking Value`, a.avg_fare FROM uber u 
		CROSS JOIN( SELECT AVG(`Booking Value`) AS avg_fare FROM uber) a
        WHERE u.`Booking Value` > a.avg_fare;

# 21.Row number of trips by date.
SELECT *,ROW_NUMBER() OVER(ORDER BY DATE(date) DESC) AS row_num FROM uber;

# 22.Rank trips by fare amount.
SELECT *, RANK() OVER(ORDER BY `Booking Value` DESC) AS rnk,
DENSE_RANK() OVER(ORDER BY `Booking Value` DESC) AS dense_rnk FROm uber;

# 23.Running total revenue.
SELECT *,SUM(`Booking Value`) OVER(ORDER BY `Date` DESC) AS run_rev FROM uber;
SELECT 
    `Date`,
    `Booking Value`,
    SUM(`Booking Value`) OVER(ORDER BY `Date` DESC) AS running_total_revenue
FROM uber;

# 24.Previous trip fare using LAG.
SELECT *,LAG(`Booking Value`) OVER() AS prev_fare FROM uber;

# 25.Next trip fare using LEAD.
SELECT *,LEAD(`Booking Value`) OVER() AS next_fare FROM uber;

# 26.Difference between current fare and previous fare.
SELECT *,LAG(`Booking Value`) OVER() AS prev_fare,
		LEAD(`Booking Value`) OVER() AS next_fare 
        FROM uber;

# 27.Top 5 highest fare trips.
SELECT * FROM(
				SELECT *,DENSE_RANK() OVER(ORDER BY `Booking Value` DESC) AS five_H_fare FROM uber) t
                WHERE five_H_fare <=5;
SELECT `Booking Value` FROM uber ORDER BY `Booking Value` DESC LIMIT 5;

# 28.Rank trips per day.
SELECT *,RANK() OVER(PARTITION BY DAY(`Date`) ORDER BY `Booking Value` DESC) AS rnk FROM uber;

# 29.Running distance travelled.
SELECT 
    `Date`,
    `Ride Distance`,
    SUM(`Ride Distance`) OVER(ORDER BY `Date`) AS running_total_distance
FROM uber;
SELECT 
    `Date`,
    `Ride Distance`,
    SUM(`Ride Distance`) OVER(PARTITION BY DATE(`Date`) ORDER BY `Booking ID`) AS daily_running_distance
FROM uber;

# 30.Average fare compared to overall average.
SELECT 
    `Booking ID`,
    `Booking Value`,
    (SELECT AVG(`Booking Value`) FROM uber) AS overall_avg,
    `Booking Value` - (SELECT AVG(`Booking Value`) FROM uber) AS diff_from_avg
FROM uber;

# 31.Peak pickup hour.
SELECT HOUR(Time) AS hr,COUNT(`Booking ID`) AS pickup FROM uber GROUP BY HOUR(Time) ORDER BY pickup DESC;

# 32.Revenue contribution % per hour.
SELECT HOUR(Time) AS hr,SUM(`Booking Value`) AS hr_rev,
		(SUM(`Booking Value`)/(SELECT SUM(`Booking Value`) FROM uber) * 100) AS fare 
		FROM uber GROUP BY HOUR(Time) ORDER BY hr DESC;
SELECT 
    HOUR(Time) AS hr,
    SUM(`Booking Value`) AS hour_revenue,
    (SUM(`Booking Value`) / (SELECT SUM(`Booking Value`) FROM uber)) * 100 
    AS revenue_percent
	FROM uber
	GROUP BY HOUR(Time)
	ORDER BY hr;

# 33.Top 5 busiest days.
SELECT DAY(Date) AS days,COUNT(*) AS Total_trips
		FROM uber GROUP BY days ORDER BY Total_trips DESC ;
SELECT DAY(Date) AS days,COUNT(*) AS Total_trips
		FROM uber WHERE `Booking Status` = 'Completed' GROUP BY days ORDER BY Total_trips DESC ;

# 34.Trips above daily average distance.
SELECT `Ride Distance` ,(SELECT AVG(`Ride Distance`) FROM uber ) AS avg_distance FROM uber
		WHERE `Ride Distance` > (SELECT AVG(`Ride Distance`) FROM uber);

# 35.Moving average of fares.
SELECT
    `Date`,
    `Booking Value`,
    AVG(`Booking Value`) OVER(
        ORDER BY `Date`
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_fare
	FROM uber;

# 36.Longest Trip each day.
SELECT DAY(Date),MAX(`Ride Distance`) AS long_trip FROM uber GROUP BY DAY(Date) ORDER BY long_trip DESC;

# 37.Revenue growth vs previous day.
SELECT SUM(`Booking Value`) AS daily_rev,
		LAG(SUM(`Booking Value`)) OVER(ORDER BY Date) AS prev_day_rev,
        SUM(`Booking Value`) - 
        LAG(SUM(`Booking Value`)) OVER(ORDER BY Date) AS revenue_growth
        FROM uber
        GROUP BY Date
        ORDER BY DATE;

# 38.DIstance Growth vs previous trip.
SELECT `Ride Distance` AS daily_ride,
		LAG(`Ride DIstance`) OVER(ORDER BY Date) AS prev_ride,
         `Ride Distance` - 
         LAG(`Ride DIstance`) OVER(ORDER BY Date) AS dist_growth
         FROM uber
         ORDER BY Date;
SELECT 
    `Ride Distance`,
    LAG(`Ride Distance`) OVER(ORDER BY `Date`) AS prev_trip_distance,
    `Ride Distance` - LAG(`Ride Distance`) OVER(ORDER BY `Date`) AS distance_growth
FROM uber
ORDER BY `Date`;

# 39.Passenger trends per day.
SELECT DAY(DATE), COUNT(*) AS pass_numb FROM uber GROUP BY DAY(Date) ORDER BY pass_numb DESC;

# 40.Trips per weekday vs weekend.
SELECT 
	CASE
		WHEN DAYOFWEEK(`Date`) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
	END AS day_type,
    COUNT(*) AS total_trips
FROM uber
GROUP BY day_type;


RENAME TABLE ncr_ride_bookings TO uber;
SELECT * FROm superstore_db.uber; 

