create database sqlproject1;
use sqlproject1;

create table olympics(
ID int,
Name varchar(500),
Sex varchar(10),
Age int,
Height int,
Weight int,
Team varchar(350),
NOC varchar(100),
Games varchar(500),
Year int,
Season varchar(400),
City varchar(300),
Sport varchar(500),
Event varchar(400),
Medal varchar(200));

show variables like "secure_file_priv";

load data infile "C:/ProgramData/MySQL/MySQL Server 9.0/Uploads/Athletes_transformed.csv"
into table olympics
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;


-- 1. Show how many medal counts present for entire data

select Medal, count(*) AS Medalcount
from olympics
where Medal is not null
group by Medal;
-- 2. Show count of unique sports present in Olympics
select count(distinct sport) as unique_sports_count
from olympics;

-- 3. Show how many different medals won by team India
select medal, count(*) as medal_count
from olympics
where team = 'India' 
group by medal;


-- 4. Show event wise medals won by India show from highest to lowest medals won in order
select event, count(medal) as medal_count
from olympics
where team = 'India'
group by event
order by medal_count desc;



-- 5. Show event wise medals won by India in order of year
select year, event, count(medal) as medal_count
from olympics
where team = 'India'
group by year, event
order by year, event;


-- 6. show country who won maximum medals.
select team, count(medal) as medal_count
from olympics
where medal is not null
group by team
order by medal_count desc
limit 1;

-- 7.show top 10 countries whowon gold
select team, count(medal) as gold_medals
from olympics
where medal = 'Gold'
group by team
order by gold_medals desc
limit 10;


--  8. show in which year did United states won most gold medal
select year, count(medal) as gold_medals
from olympics
where team = 'United States' and medal = 'Gold'
group by year
order by gold_medals desc
limit 1;


-- 9. In which sports United States has most medals.
select sport, count(medal) as total_medals
from olympics
where team = 'United States'
group by sport
order by total_medals desc
limit 1;


-- 10. Find top three players who won most medals along with their sports and country
select name, sport, team, count(medal) as total_medals
from olympics
group by name, sport, team
order by total_medals desc
limit 3;


-- 11. Find player with most gold medals in cycling along with his country.
select name, team, count(medal) as gold_medals
from olympics
where sport = 'Cycling' and medal = 'Gold'
group by name, team
order by gold_medals desc
limit 1;


-- 12.Find player with most medals (Gold+Silver+Bronze) in Basketball also show his country.
select name, team, count(medal) as total_medals
from olympics
where sport = 'Basketball' and medal in ('Gold', 'Silver', 'Bronze')
group by name, team
order by total_medals desc
limit 1;


-- 13. Find out the count of different medals of the top basketball player Teresa Edwards
select medal, count(medal) as medal_count
from olympics
where name = 'Teresa Edwards' and sport = 'Basketball'
group by medal;

-- 14. Find out medals won by male,female each year , Export this data and plot graph in excel
select year, sex, count(medal) as medal_count
from olympics
where medal in ('Gold', 'Silver', 'Bronze')
group by year, sex
order by year, sex;

