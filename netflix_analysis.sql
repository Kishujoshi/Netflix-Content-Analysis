drop table netflix_titles ;



CREATE TABLE netflix_titles (
    show_id INT ,
    type VARCHAR(20),
    title TEXT,
    director TEXT,
    movie_cast TEXT,
    country TEXT,
    month_text VARCHAR (50),
    day_add INT ,
    year_add INT ,
    month_add INT ,
    date_added DATE,
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(20),
    listed_in TEXT,
    description TEXT
);

select * from netflix_titles nt;

alter table netflix_titles drop column month_text ;
alter table netflix_titles drop column day_add , drop column year_add , drop column month_add ;

select * from netflix_titles nt;

--> Total Records 
select count(*) from netflix_titles nt ;

--> We are having space in data so we can not calculate data as NULL so we are making those data as NULL
UPDATE netflix_titles 
SET director = NULLIF(TRIM(director), ''), 
title = NULLIF(TRIM(title), ''), 
"type" = nullif (trim("type"), ''),  
movie_cast = nullif (trim(movie_cast), ''),
country = nullif (trim(country), ''),
rating = nullif (trim(rating), ''),
duration = nullif (trim(duration), ''),
listed_in = nullif(trim(listed_in), ''),
description = nullif (trim(description), '') ;

--> Checking Null Values
select count(*) filter(where show_id is null) as missing_showID,
count(*) filter(where "type"  is null) as missing_type,
count(*) filter(where title  is null) as missing_title,
count(*) filter(where director  is null) as missing_director,
count(*) filter(where movie_cast  is null) as missing_movie_cast,
count(*) filter(where country  is null) as missing_country,
count(*) filter(where date_added is null) as missing_date_added,
count(*) filter(where release_year  is null) as missing_release_year,
count(*) filter(where rating  is null) as missing_rating,
count(*) filter(where duration  is null) as missing_duration,
count(*) filter(where listed_in  is null) as missing_listed_in,
count(*) filter(where description is null) as missing_description
from netflix_titles nt ;


--> Movies Vs TV Show
select "type" ,
count(*) as total_titles 
from netflix_titles nt 
group by "type" 
order by total_titles ;

--> Content Added Over Time
select release_year ,
count(*) as total_titles  
from netflix_titles nt 
group by release_year 
order by release_year ;

--> Top 10 Content Producing Countries
select country ,
count(*) as total_titles  
from netflix_titles nt 
where country is not null 
group by country 
order by total_titles desc 
limit 10;

--> Top Ratings
select rating ,
count(*) as total_titles
from netflix_titles nt 
where rating is not null 
group by rating 
order by total_titles desc ;

--> Top 10 Directors With Highest filems or shows
select director ,
count(*) as total_titles 
from netflix_titles nt 
where director is not null
group by director 
order by total_titles desc 
limit 10;

--> Most Common Genres
select listed_in ,
count(*) as total_titles  
from netflix_titles nt 
where listed_in is not null 
group by listed_in 
order by total_titles desc 
limit 10;

--> Movie Duration Analysis
select duration ,
count(*) as total_titles 
from netflix_titles nt 
where "type" = 'Movie' 
group by duration 
order by total_titles desc
limit 10;



--> Movies vs TV Shows by Year
select "type", release_year ,
count(*) as total_titles 
from netflix_titles nt 
group by release_year , "type" 
order by release_year ;

--> Top 10 Countries Producing Movies
select country ,
count(*) as total_titles  
from netflix_titles
where "type" = 'Movie' and country is not null 
group by country 
order by total_titles desc
limit 10;

--> Top 10 Countries Producing TV Shows
select country ,
count(*) as total_titles 
from netflix_titles nt 
where "type" = 'TV Show' and country is not null 
group by country 
order by total_titles desc
limit 10;

--> Content Added by Release Year Trend
select release_year ,
count(*) as total_titles  
from netflix_titles nt 
group by release_year 
order by release_year;

--> Most Common Ratings by Content Type
select "type" , rating ,
count(*) as total_titles  
from netflix_titles nt 
where rating is not null
group by "type" , rating 
order by total_titles desc;

--> Oldest Content on Netflix
select "type", title , release_year 
from netflix_titles nt
order by release_year  
limit 10;

--> Newest Content on Netflix
select "type" , title , release_year 
from netflix_titles nt 
order by release_year desc 
limit 10;

--> Content Distribution by Rating
select "type" , rating ,
count(*) as total_titles  
from netflix_titles nt 
where rating is not null
group by "type" , rating 
order by rating ;

--> Create Content Age Bucket
--> How much content is recent vs older?
select 
case 
	when release_year >= 2020 then '2020+'
	when release_year >= 2015 then '2015 - 2019'
	when release_year >= 2010 then '2010 - 2014'
	else 'Before 2010'
end as content_period,
count(*) as total_titles  
from netflix_titles nt 
group by content_period 
order by total_titles desc ;
