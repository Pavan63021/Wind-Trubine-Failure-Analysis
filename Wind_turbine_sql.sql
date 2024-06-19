create database project;
select * from wind_turbine_1;
describe wind_turbine_1;
set sql_safe_updates=0;

-- changing date format
update wind_turbine_1 set date = str_to_date(date,"%d-%m-%Y");

-- changing date datatype from text to date
alter table wind_turbine_1 modify column date date;


-- checking for duplicates
select distinct count(*) from wind_turbine_1;

-- checking for missing values
select count(*) from wind_turbine_1 where date is null;
select count(*) from wind_turbine_1 where Wind_speed is null;
select count(*) from wind_turbine_1 where power is null;
select count(*) from wind_turbine_1 where Nacelle_ambient_temperature is null;
select count(*) from wind_turbine_1 where Generator_bearing_temperature is null;
select count(*) from wind_turbine_1 where Gear_oil_temperature is null;
select count(*) from wind_turbine_1 where Ambient_temperature is null;
select count(*) from wind_turbine_1 where Rotor_Speed is null;
select count(*) from wind_turbine_1 where Nacelle_temperature is null;
select count(*) from wind_turbine_1 where Bearing_temperature is null;
select count(*) from wind_turbine_1 where Generator_speed is null;
select count(*) from wind_turbine_1 where Yaw_angle is null;
select count(*) from wind_turbine_1 where Wind_direction is null;
select count(*) from wind_turbine_1 where Wheel_hub_temperature is null;
select count(*) from wind_turbine_1 where Gear_box_inlet_temperature is null;
select count(*) from wind_turbine_1 where Failure_status is null;



-- First moment business decision
# mean
select avg(Wind_speed) from wind_turbine_1;
select avg(Power) from wind_turbine_1;
select avg(Nacelle_ambient_temperature) from wind_turbine_1;
select avg(Generator_bearing_temperature) from wind_turbine_1;
select avg(Gear_oil_temperature) from wind_turbine_1;
select avg(Ambient_temperature) from wind_turbine_1;
select avg(Rotor_Speed) from wind_turbine_1;
select avg(Nacelle_temperature) from wind_turbine_1;
select avg(Bearing_temperature) from wind_turbine_1;
select avg(Generator_speed) from wind_turbine_1;
select avg(Yaw_angle) from wind_turbine_1;
select avg(Wind_direction) from wind_turbine_1;
select avg(Wheel_hub_temperature) from wind_turbine_1;
select avg(Gear_box_inlet_temperature) from wind_turbine_1;

# median
select Wind_speed as median_wind_speed
FROM (
    SELECT wind_speed, ROW_NUMBER() OVER (ORDER BY wind_speed) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM wind_turbine_1
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;   

select power as median_power
FROM (
    SELECT power, ROW_NUMBER() OVER (ORDER BY power) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM wind_turbine_1
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2; 

select Nacelle_ambient_temperature as median_Nacelle_ambient_temperature
FROM (
    SELECT Nacelle_ambient_temperature, ROW_NUMBER() OVER (ORDER BY Nacelle_ambient_temperature) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM wind_turbine_1
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

select Generator_bearing_temperature as median_Generator_bearing_temperature
FROM (
    SELECT Generator_bearing_temperature, ROW_NUMBER() OVER (ORDER BY Generator_bearing_temperature) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM wind_turbine_1
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

select Gear_oil_temperature as median_Gear_oil_temperature
FROM (
    SELECT Gear_oil_temperature, ROW_NUMBER() OVER (ORDER BY Gear_oil_temperature) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM wind_turbine_1
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

select Ambient_temperature as median_Ambient_temperature
FROM (
    SELECT Ambient_temperature, ROW_NUMBER() OVER (ORDER BY Ambient_temperature) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM wind_turbine_1
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

select Rotor_Speed as median_Rotor_Speed
FROM (
    SELECT Rotor_Speed, ROW_NUMBER() OVER (ORDER BY Rotor_Speed) AS row_num,
           COUNT(*) OVER () AS total_count
    FROM wind_turbine_1
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

-- mode for failure status
select Failure_status,count(failure_status) from wind_turbine_1 group by Failure_status order by Failure_status desc limit 1;

-- second moment business decision
# standard deviation and variance
select (select std(Wind_speed)) as std ,(select variance(wind_speed)) as variance from wind_turbine_1;
select (select std(power)) as std ,(select variance(power)) as variance from wind_turbine_1;
select (select std(Nacelle_ambient_temperature)) as std ,(select variance(Nacelle_ambient_temperature)) as variance from wind_turbine_1;
select (select std(Generator_bearing_temperature)) as std ,(select variance(Generator_bearing_temperature)) as variance from wind_turbine_1;
select (select std(Gear_oil_temperature)) as std ,(select variance(Gear_oil_temperature)) as variance from wind_turbine_1;
select (select std(Ambient_temperature)) as std ,(select variance(Ambient_temperature)) as variance from wind_turbine_1;
select (select std(Rotor_Speed)) as std ,(select variance(Rotor_Speed)) as variance from wind_turbine_1;
select (select std(Nacelle_temperature)) as std ,(select variance(Nacelle_temperature)) as variance from wind_turbine_1;
select (select std(Bearing_temperature)) as std ,(select variance(Bearing_temperature)) as variance from wind_turbine_1;
select (select std(Generator_speed)) as std ,(select variance(Generator_speed)) as variance from wind_turbine_1;
select (select std(Yaw_angle)) as std ,(select variance(Yaw_angle)) as variance from wind_turbine_1;
select (select std(Wind_direction)) as std ,(select variance(Wind_direction)) as variance from wind_turbine_1;
select (select std(Wheel_hub_temperature)) as std ,(select variance(Wheel_hub_temperature)) as variance from wind_turbine_1;
select (select std(Gear_box_inlet_temperature)) as std ,(select variance(Gear_box_inlet_temperature)) as variance from wind_turbine_1;



#range
select max(wind_speed)-min(wind_speed) from wind_turbine_1;

-- third and fourth moment busniess decision
SELECT
    (
        SUM(POWER(wind_speed - (SELECT AVG(wind_speed) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(wind_speed) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(wind_speed - (SELECT AVG(wind_speed) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(wind_speed) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(power - (SELECT AVG(power) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(power) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(power - (SELECT AVG(power) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(power) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(Nacelle_ambient_temperature - (SELECT AVG(Nacelle_ambient_temperature) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Nacelle_ambient_temperature) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(Nacelle_ambient_temperature - (SELECT AVG(Nacelle_ambient_temperature) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Nacelle_ambient_temperature) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(Generator_bearing_temperature - (SELECT AVG(Generator_bearing_temperature) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Generator_bearing_temperature) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(Generator_bearing_temperature - (SELECT AVG(Generator_bearing_temperature) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Generator_bearing_temperature) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(Gear_oil_temperature - (SELECT AVG(Gear_oil_temperature) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Gear_oil_temperature) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(Gear_oil_temperature - (SELECT AVG(Gear_oil_temperature) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(Gear_oil_temperature) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(ambient_temperature - (SELECT AVG(ambient_temperature) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(ambient_temperature) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(ambient_temperature - (SELECT AVG(ambient_temperature) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(ambient_temperature) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(rotor_speed - (SELECT AVG(rotor_speed) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(rotor_speed) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(rotor_speed - (SELECT AVG(rotor_speed) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(rotor_speed) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(nacelle_temperature - (SELECT AVG(nacelle_temperature) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(nacelle_temperature) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(nacelle_temperature - (SELECT AVG(nacelle_temperature) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(nacelle_temperature) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(generator_speed - (SELECT AVG(generator_speed) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(generator_speed) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(generator_speed - (SELECT AVG(generator_speed) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(generator_speed) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(yaw_angle - (SELECT AVG(yaw_angle) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(yaw_angle) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(yaw_angle - (SELECT AVG(yaw_angle) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(yaw_angle) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(wind_direction - (SELECT AVG(wind_direction) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(wind_direction) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(wind_direction - (SELECT AVG(wind_direction) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(wind_direction) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(wheel_hub_temperature - (SELECT AVG(wheel_hub_temperature) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(wheel_hub_temperature) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(wheel_hub_temperature - (SELECT AVG(wheel_hub_temperature) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(wheel_hub_temperature) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

SELECT
    (
        SUM(POWER(gear_box_inlet_temperature - (SELECT AVG(gear_box_inlet_temperature) FROM wind_turbine_1), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(gear_box_inlet_temperature) FROM wind_turbine_1), 3))
    ) AS skewness,
    (
        (SUM(POWER(gear_box_inlet_temperature - (SELECT AVG(gear_box_inlet_temperature) FROM wind_turbine_1), 4)) / 
        (COUNT(*) * POWER((SELECT STDDEV(gear_box_inlet_temperature) FROM wind_turbine_1), 4))) - 3
    ) AS kurtosis
FROM wind_turbine_1;

-- correlation coefficient value wind_speed vs power
select
(avg(Wind_speed*power)-avg(Wind_speed)*avg(Power))/
(sqrt(avg(wind_speed*wind_speed)-avg(Wind_speed)*avg(Wind_speed))*sqrt(avg(power*power)-avg(power)*avg(power)))
from wind_turbine_1;

#wind_direction vs generator_speed
select
(avg(Wind_direction*Generator_speed)-avg(Wind_direction)*avg(Generator_speed))/
(sqrt(avg(wind_direction*wind_direction)-avg(Wind_direction)*avg(Wind_direction))*sqrt(avg(generator_speed*generator_speed)-avg(generator_speed)*avg(generator_speed)))
from wind_turbine_1;

select corr(wind_speed,power) from wind_turbine_1;
-- Bivarient analysis
#input(wind_speed) vs output(power)
select wind_speed,power from wind_turbine_1;

-- outliers detection using stddev
select * from (select Wind_speed,(Wind_speed-avg(Wind_speed) over ()) /stddev(Wind_speed) over() as zscore 
from wind_turbine_1) as score_table where zscore>3 or zscore<-3;

select * from (select Generator_bearing_temperature,(Generator_bearing_temperature-avg(Wind_speed) over ()) /stddev(Generator_bearing_temperature) over() as zscore 
from wind_turbine_1) as score_table where zscore>3 or zscore<-3;

select * from (select Wheel_hub_temperature,(Wheel_hub_temperature-avg(Wind_speed) over ()) /stddev(Wheel_hub_temperature) over() as zscore 
from wind_turbine_1) as score_table where zscore>3 or zscore<-3;

-- retaining outliers
select Wind_speed,percent_rank() over(order by wind_speed) as Q1
from wind_turbine_1 ;
# lower_fence=9.86-1.5*13.37=-10.195
# upper_fence=23.23+1.5*13.37=43.285

update wind_turbine_1 set wind_speed =
case 
when wind_speed < -10.195 then wind_speed = -10.195
when wind_speed > 43.285 then wind_speed = 43.285
else wind_speed
end;


select power,percent_rank() over(order by power) as Q from wind_turbine_1;
#2.41
#3.18
#lower_fence = 2.41-1.5*0.77=1.255
#upper_fence = 3.18+1.5*0.77=4.335

UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(power) + 2 * STDDEV(power) AS upper_fence,
        AVG(power) - 2 * STDDEV(power) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.power = 
    CASE 
        WHEN wt.power > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.power < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.power
    END;
select power from wind_turbine_1 where power < (select (avg(power) - 2 * STDDEV(power)) from wind_turbine_1);
UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(Nacelle_ambient_temperature) + 2 * STDDEV(Nacelle_ambient_temperature) AS upper_fence,
        AVG(Nacelle_ambient_temperature) - 2 * STDDEV(Nacelle_ambient_temperature) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.Nacelle_ambient_temperature = 
    CASE 
        WHEN wt.Nacelle_ambient_temperature > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.Nacelle_ambient_temperature < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.Nacelle_ambient_temperature
    END;
    
UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(Gear_oil_temperature) + 2 * STDDEV(Gear_oil_temperature) AS upper_fence,
        AVG(Gear_oil_temperature) - 2 * STDDEV(Gear_oil_temperature) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.Gear_oil_temperature = 
    CASE 
        WHEN wt.Gear_oil_temperature > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.Gear_oil_temperature < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.Gear_oil_temperature
    END;
 
UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(Generator_bearing_temperature) + 2 * STDDEV(Generator_bearing_temperature) AS upper_fence,
        AVG(Generator_bearing_temperature) - 2 * STDDEV(Generator_bearing_temperature) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.Generator_bearing_temperature = 
    CASE 
        WHEN wt.Generator_bearing_temperature > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.Generator_bearing_temperature < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.Generator_bearing_temperature
    END;

UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(Ambient_temperature) + 2 * STDDEV(Ambient_temperature) AS upper_fence,
        AVG(Ambient_temperature) - 2 * STDDEV(Ambient_temperature) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.Ambient_temperature = 
    CASE 
        WHEN wt.Ambient_temperature > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.Ambient_temperature < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.Ambient_temperature
    END;

UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(Nacelle_temperature) + 2 * STDDEV(Nacelle_temperature) AS upper_fence,
        AVG(Nacelle_temperature) - 2 * STDDEV(Nacelle_temperature) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.nacelle_temperature = 
    CASE 
        WHEN wt.nacelle_temperature > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.nacelle_temperature < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.nacelle_temperature
    END;

 UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(Rotor_Speed) + 2 * STDDEV(Rotor_Speed) AS upper_fence,
        AVG(Rotor_Speed) - 2 * STDDEV(Rotor_Speed) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.Rotor_Speed = 
    CASE 
        WHEN wt.Rotor_Speed > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.Rotor_Speed < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.Rotor_Speed
    END;

 UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(Generator_speed) + 2 * STDDEV(Generator_Speed) AS upper_fence,
        AVG(Generator_Speed) - 2 * STDDEV(Generator_Speed) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.Generator_Speed = 
    CASE 
        WHEN wt.Generator_Speed > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.Generator_Speed < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.Generator_Speed
    END;   
    
 UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(Wind_direction) + 2 * STDDEV(Wind_direction) AS upper_fence,
        AVG(Wind_direction) - 2 * STDDEV(Wind_direction) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.Wind_direction = 
    CASE 
        WHEN wt.Wind_direction > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.Wind_direction < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.Wind_direction
    END;
    
UPDATE wind_turbine_1 AS e
JOIN (
SELECT
Yaw_angle ,
NTILE(4) OVER (ORDER BY yaw_angle) AS Column5_quartile
FROM wind_turbine_1
) AS subquery ON e.yaw_angle = subquery.yaw_angle
SET e.yaw_angle = (
SELECT AVG(yaw_angle)
FROM (
SELECT
yaw_angle ,
NTILE(4) OVER (ORDER BY yaw_angle) AS Column5_quartile
FROM wind_turbine_1
) AS temp
WHERE Column5_quartile = subquery.Column5_quartile
)
WHERE subquery.Column5_quartile IN (1, 4); 

 UPDATE wind_turbine_1 as wt
JOIN (
    SELECT
        AVG(Gear_box_inlet_temperature) + 2 * STDDEV(Gear_box_inlet_temperature) AS upper_fence,
        AVG(Gear_box_inlet_temperature) - 2 * STDDEV(Gear_box_inlet_temperature) AS lower_fence
    FROM wind_turbine_1
) AS bounds ON 1=1
SET wt.Gear_box_inlet_temperature = 
    CASE 
        WHEN wt.Gear_box_inlet_temperature > bounds.upper_fence THEN bounds.upper_fence
        WHEN wt.Gear_box_inlet_temperature < bounds.lower_fence THEN bounds.lower_fence
        ELSE wt.Gear_box_inlet_temperature
    END;
set sql_safe_updates=0;


-- median imputation
update wind_turbine_1 set Wind_speed=16.55 where Wind_speed is null;
update wind_turbine_1 set power=2.78 where power is null;
# update wind_turbine_1 set power=coalesce(power,@median_value) where power is null;
update wind_turbine_1 set nacelle_ambient_temperature=23.03 where nacelle_ambient_temperature is null;
update wind_turbine_1 set nacelle_temperature=44.91 where nacelle_temperature is null;
update wind_turbine_1 set generator_speed=1406.11 where generator_speed is null;
update wind_turbine_1 set yaw_angle=32.84 where yaw_angle is null;
update wind_turbine_1 set gear_box_inlet_temperature=15.87 where gear_box_inlet_temperature is null;


-- discretisation
update wind_turbine_1 set bearing_temperature =
case
when bearing_temperature < 70 then 'low temperature'
when bearing_temperature > 100 then 'high temperature'
else 'optimum temperature' 
end; 

-- label encoding

select Failure_status ,
case
when Failure_status = 'No_failure' then 1
else 0
end as discretisation
from wind_turbine_1;

-- dummy / one hot / binary encoding
select Failure_status ,
case
when Failure_status = 'No_failure' then 1 else 0 end as no_failure,
case
when failure_status = 'failure' then 1 else 0 end as failure
from wind_turbine_1;

-- TRANSFORMATION for linearisation
update wind_turbine_1 set wind_speed = sqrt(wind_speed);
update wind_turbine_1 set power = sqrt(power);
update wind_turbine_1 set nacelle_temperature = sqrt(nacelle_temperature);
update wind_turbine_1 set generator_bearing_temperature = sqrt(generator_bearing_temperature);
update wind_turbine_1 set gear_oil_temperature = sqrt(gear_oil_temperature);
update wind_turbine_1 set ambient_temperature = sqrt(ambient_temperature);
update wind_turbine_1 set rotor_speed = sqrt(rotor_speed);
update wind_turbine_1 set generator_speed = sqrt(generator_speed);
update wind_turbine_1 set yaw_angle = sqrt(yaw_angle);
update wind_turbine_1 set wind_direction = sqrt(wind_direction);
update wind_turbine_1 set wheel_hub_temperature = sqrt(wheel_hub_temperature);
update wind_turbine_1 set rotor_speed = sqrt(rotor_speed);
update wind_turbine_1 set nacelle_ambient_temperature = sqrt(nacelle_ambient_temperature);
set sql_safe_updates=0;
select* from wind_turbine_1;
-- NORMALISATION
select gear_box_inlet_temperature ,
(gear_box_inlet_temperature - min_C) / (max_C - min_C) as normalized from(
select gear_box_inlet_temperature, (select(min(gear_box_inlet_temperature)) from wind_turbine_1) as min_c,
( select(max(gear_box_inlet_temperature))from wind_turbine_1) as max_c  from wind_turbine_1 ) as scaled;

-- NORMALISATION
create table wind_turbine as select date,failure_status,
(Wind_speed - min_ws) / (max_ws - min_ws) as wind_speed_scaled,
(power - min_p) / (max_p - min_p) as power_scaled,
(Ambient_temperature - min_amb) / (max_amb - min_amb) as ambient_temp_scaled,
(rotor_speed - min_r) / (max_r - min_r) as rotor_speed_scaled,
(Nacelle_temperature - min_nt) / (max_nt - min_nt) as nacelle_temp_scaled,Bearing_temperature,
(gear_box_inlet_temperature - min_C) / (max_C - min_C) as gear_box_inlet_temperat_scaled,
(nacelle_ambient_temperature - min_nac) / (max_nac - min_nac) as nacelle_amb_temperat_scaled ,
(generator_bearing_temperature - min_gen) / (max_gen - min_gen) as gen_bear_temperat_scaled ,
(Generator_speed - min_gs) / (max_gs - min_gs) as generator_speed_scaled,
(Yaw_angle - min_y) / (max_y - min_y) as yaw_angle_scaled,
(Wind_direction - min_wd) / (max_wd - min_wd) as wind_direction_scaled,
(Wheel_hub_temperature - min_wh) / (max_wh - min_wh) as wheel_hub_temp_scaled,
(gear_oil_temperature - min_gear) / (max_gear - min_gear) as gear_oil_temperat_scaled from(
select date,Wind_speed,power,Ambient_temperature,Rotor_Speed,Nacelle_temperature,
Bearing_temperature,Generator_speed,Yaw_angle,Wind_direction,Wheel_hub_temperature,
gear_box_inlet_temperature,nacelle_ambient_temperature,generator_bearing_temperature,gear_oil_temperature,Failure_status,

(select(min(gear_box_inlet_temperature)) from wind_turbine_1) as min_c,
(select(max(gear_box_inlet_temperature))from wind_turbine_1) as max_c ,
(select(min(nacelle_ambient_temperature)) from wind_turbine_1) as min_nac,
(select(max(nacelle_ambient_temperature))from wind_turbine_1) as max_nac ,
(select(min(generator_bearing_temperature)) from wind_turbine_1) as min_gen,
(select(max(generator_bearing_temperature))from wind_turbine_1) as max_gen ,
(select(min(gear_oil_temperature)) from wind_turbine_1) as min_gear,
(select(max(gear_oil_temperature))from wind_turbine_1) as max_gear ,
(select(min(wind_speed)) from wind_turbine_1) as min_ws,
(select(max(wind_speed))from wind_turbine_1) as max_ws,
(select(min(Wind_direction)) from wind_turbine_1) as min_wd,
(select(max(Wind_direction))from wind_turbine_1) as max_wd,
(select(min(power)) from wind_turbine_1) as min_p,
(select(max(power))from wind_turbine_1) as max_p,
(select(min(Ambient_temperature)) from wind_turbine_1) as min_amb,
(select(max(Ambient_temperature))from wind_turbine_1) as max_amb ,
(select(min(Nacelle_temperature)) from wind_turbine_1) as min_nt,
(select(max(Nacelle_temperature))from wind_turbine_1) as max_nt ,
(select(min(Generator_speed)) from wind_turbine_1) as min_gs,
(select(max(Generator_speed))from wind_turbine_1) as max_gs ,
(select(min(Yaw_angle)) from wind_turbine_1) as min_y,
(select(max(Yaw_angle))from wind_turbine_1) as max_y ,
(select(min(Rotor_Speed)) from wind_turbine_1) as min_r,
(select(max(Rotor_Speed))from wind_turbine_1) as max_r,
(select(min(Wheel_hub_temperature)) from wind_turbine_1) as min_wh,
(select(max(Wheel_hub_temperature))from wind_turbine_1) as max_wh
 from wind_turbine_1 ) as scaled;

select * from wind_turbine;
select * from wind_turbine_1;

# stddev and variance
select (select std(Wind_speed_scaled)) as std ,(select variance(wind_speed_scaled)) as variance from wind_turbine;
select (select std(power_scaled)) as std ,(select variance(power_scaled)) as variance from wind_turbine;
select (select std(Nacelle_amb_temperat_scaled)) as std ,(select variance(Nacelle_amb_temperat_scaled)) as variance from wind_turbine;
select (select std(Gen_bear_temperat_scaled)) as std ,(select variance(Gen_bear_temperat_scaled)) as variance from wind_turbine;
select (select std(Gear_oil_temperat_scaled)) as std ,(select variance(Gear_oil_temperat_scaled)) as variance from wind_turbine;
select (select std(Ambient_temp_scaled)) as std ,(select variance(Ambient_temp_scaled)) as variance from wind_turbine;
select (select std(Rotor_Speed_scaled)) as std ,(select variance(Rotor_Speed_scaled)) as variance from wind_turbine;
select (select std(Nacelle_temp_scaled)) as std ,(select variance(Nacelle_temp_scaled)) as variance from wind_turbine;
select (select std(Generator_speed_scaled)) as std ,(select variance(Generator_speed_scaled)) as variance from wind_turbine;
select (select std(Yaw_angle_scaled)) as std ,(select variance(Yaw_angle_scaled)) as variance from wind_turbine;
select (select std(Wind_direction_scaled)) as std ,(select variance(Wind_direction_scaled)) as variance from wind_turbine;
select (select std(Wheel_hub_temp_scaled)) as std ,(select variance(Wheel_hub_temp_scaled)) as variance from wind_turbine;
select (select std(Gear_box_inlet_temperat_scaled)) as std ,(select variance(Gear_box_inlet_temperat_scaled)) as variance from wind_turbine;

# mean
select avg(Wind_speed_scaled) from wind_turbine;
select avg(Power_scaled) from wind_turbine;
select avg(Nacelle_amb_temperat_scaled) from wind_turbine;
select avg(Gen_bear_temperat_scaled) from wind_turbine;
select avg(Gear_oil_temperat_scaled) from wind_turbine;
select avg(Ambient_temp_scaled) from wind_turbine;
select avg(Rotor_Speed_scaled) from wind_turbine;
select avg(Nacelle_temp_scaled) from wind_turbine;
select avg(Generator_speed_scaled) from wind_turbine;
select avg(Yaw_angle_scaled) from wind_turbine;
select avg(Wind_direction_scaled) from wind_turbine;
select avg(Wheel_hub_temp_scaled) from wind_turbine;
select avg(Gear_box_inlet_temperat_scaled) from wind_turbine;
