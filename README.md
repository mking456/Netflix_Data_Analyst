# Netflix_Data_Analyst_Using_MYSQL

![Netflix_logo](https://github.com/mking456/Netflix_Data_Analyst/blob/main/logo.png)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives
* Analyze the distribution of content types (movies vs TV shows).
* Identify the most common ratings for movies and TV shows.
* List and analyze content based on release years, countries, and durations.
* Explore and categorize content based on specific criteria and keywords.

## Dataset
The data for this project is sourced from the Kaggle dataset:

* Dataset Link:[Movie_Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id VARCHAR(5),
    type VARCHAR(10),
    title VARCHAR(250),
    director VARCHAR(550),
    casts VARCHAR(1050),
    country VARCHAR(550),
    date_added VARCHAR(55),
    release_year INT,
    rating VARCHAR(15),
    duration VARCHAR(15),
    listed_in VARCHAR(250),
    description VARCHAR(550)
);
```
## Business Problems and Solutions

## 1. Count the number of Movies vs TV Shows
```sql
SELECT TYPE,COUNT(*) AS CONTENT_NBR
FROM netflix
GROUP BY TYPE;
```
## 2. Find the most common rating for movies and TV shows
```sql
select type,rating
from(
	SELECT TYPE,RATING,count(*), rank() over(partition by type order by count(*) desc)as ranking
	from netflix
	group by 1,2) as t1
where ranking=1;
```
## 3. List all movies released in a specific year (e.g., 2020)
```sql
select *
from netflix
where release_year='2020' and type='movie';
```
## 4. Find the top 5 countries with the most content on Netflix
```sql
SELECT country, count(*) as count
FROM netflix
GROUP BY country
ORDER by count desc
LIMIT 5;
```
## 5. Identify the longest movie
```sql
select *
from netflix
where type='movie'
and 
duration = (select max(duration) as longest_movie
			from netflix);
```
## 6. Find content added in the last 5 years
```sql
select *
from netflix
where date_sub(curdate(),interval 5 year) <= str_to_date(date_added,'%M %d,%Y');
```
## 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
```sql
SELECT * 
FROM netflix
WHERE director='Rajiv Chilaka';

SELECT * FROM netflix
WHERE director LIKE '%Bruno Garotti%';
```
## 8. List all TV shows with more than 5 seasons
```sql
SELECT *,
 cast(SUBSTRING_INDEX(duration,' ',1) as unsigned) as session_count
FROM netflix
WHERE 
type= 'TV SHOW'AND
cast(SUBSTRING_INDEX(duration,' ',1) as unsigned) > 5;
```
## 10.Find each year and the average numbers of content release in India on netflix.return top 5 year with highest avg content release!
```sql
select * from netflix;
select  YEAR(DATE_FORMAT(STR_TO_DATE(date_added, '%M %d, %Y'), '%Y-%m-%d')) AS formatted_date,count(*)/(select count(*) from netflix where country = 'india') as avg_number
from netflix
where country='india'
GROUP BY 1;
```
## 11. List all movies that are documentaries
```sql
select *
from netflix
where listed_in like  'documentaries%';
```
## 12. Find all content without a director
```sql
SELECT *
FROM netflix
WHERE director IS NULL OR director = '';
```
## 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
```sql
SELECT COUNT(*) AS salman_khan_movies
FROM netflix
WHERE type = 'Movie'
AND casts LIKE '%Salman Khan%'
AND release_year >= YEAR(CURDATE()) - 10;
```
## 14.Find the top 10 actors who have appeared in the highest number of movies produced in India.
```sql
SELECT *,TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(casts, ',',1), ',',-4)) AS actor_name
from netflix
WHERE type = 'Movie' and country='india'
limit 10;
```
## Objective: Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.

## Findings and Conclusion
* Content Distribution: The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
* Common Ratings: Insights into the most common ratings provide an understanding of the content's target audience.
* Geographical Insights: The top countries and the average content releases by India highlight regional content distribution.
* Content Categorization: Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

## This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.

#Author Mayur
