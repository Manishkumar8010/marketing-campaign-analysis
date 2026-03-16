create database Marketing_Performance;
CREATE TABLE campaign_performance(
performance_id int primary key,
campaign_id int,
region varchar(20),
date DATE,
impressions INT,
clicks INT,
conversions int,
cost float,
revenue float);


SELECT* FROM marketing_performance.campaign_performance_table;

use marketing_performance;
 drop table campaign_table;

create table campaign_table(
campaign_id int,
campaign_name varchar(50),
channel_id int);

select * from campaign_table;

USE Marketing_Performance;

CREATE table channels_table(
channel_id int,
channel_name varchar(50)
);

use marketing_performance;

select * from campaign_performance_table;

-- 1 Total Revenue
SELECT ROUND(SUM(revenue),2) AS total_revenue
FROM campaign_performance_table;

-- 2 Total Marketing Cost
SELECT SUM(cost) AS total_cost
FROM campaign_performance_table;

-- 3 Revenue by Marketing Channel

SELECT 
ch.channel_name,
floor( sum(cp.revenue))AS total_revenue
FROM campaign_performance_table cp
JOIN campaign_table c
ON cp.campaign_id = c.campaign_id
JOIN channels_table ch
ON c.channel_id = ch.channel_id
GROUP BY ch.channel_name
ORDER BY total_revenue DESC;

-- 4 Top Performing Campaigns
SELECT 
c.campaign_name,
SUM(cp.revenue) AS total_revenue
FROM campaign_performance_table cp
JOIN campaigns_table c
ON cp.campaign_id = c.campaign_id
GROUP BY c.campaign_name
ORDER BY total_revenue DESC
LIMIT 5;

-- 5 Performance by Region
SELECT 
region,
SUM(revenue) AS total_revenue
FROM campaign_performance_table
GROUP BY region
ORDER BY total_revenue DESC;

-- 6 Click Through Rate (CTR)
SELECT 
ROUND(SUM(clicks)/SUM(impressions)*100,2) AS CTR_percentage
FROM campaign_performance_table;

-- 7 Conversion Rate
SELECT 
ROUND(SUM(conversions)/SUM(clicks)*100,2) AS conversion_rate
FROM campaign_performance_table;

-- 8 Return on Investment (ROI)
SELECT 
ROUND((SUM(revenue)-SUM(cost))/SUM(cost)*100,2) AS ROI_percentage
FROM campaign_performance_table;

-- 9 Best Channel by Conversions
SELECT 
ch.channel_name,
SUM(cp.conversions) AS total_conversions
FROM campaign_performance_table cp
JOIN campaigns_table c
ON cp.campaign_id = c.campaign_id
JOIN channels_table ch
ON c.channel_id = ch.channel_id
GROUP BY ch.channel_name
ORDER BY total_conversions DESC;

-- 10 Monthly Revenue Trend
SELECT 
MONTH(date) AS month,
SUM(revenue) AS total_revenue
FROM campaign_performance_table
GROUP BY month
ORDER BY month;