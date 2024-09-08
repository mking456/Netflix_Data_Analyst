-- 1. Count the number of Movies vs TV Shows
SELECT TYPE,COUNT(*) AS CONTENT_NBR
FROM netflix
GROUP BY TYPE;

-- 2. Find the most common rating for movies and TV shows
select * from netflix;
select type,rating
from(
	SELECT TYPE,RATING,count(*), rank() over(partition by type order by count(*) desc)as ranking
	from netflix
	group by 1,2) as t1
where ranking=1;

-- 3. List all movies released in a specific year (e.g., 2020)
select *
from netflix
where release_year='2020' and type='movie';

-- 4. Find the top 5 countries with the most content on Netflix
SELECT country, count(*) as count
FROM netflix
GROUP BY country
ORDER by count desc
LIMIT 5;

-- 5. Identify the longest movie

select *
from netflix
where type='movie'
and 
duration = (select max(duration) as longest_movie
			from netflix);
            
-- 6. Find content added in the last 5 years
select *
from netflix
where date_sub(curdate(),interval 5 year) <= str_to_date(date_added,'%M %d,%Y');

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT * 
FROM netflix
WHERE director='Rajiv Chilaka';

SELECT * FROM netflix
WHERE director LIKE '%Bruno Garotti%';

-- 8. List all TV shows with more than 5 seasons

SELECT *,
 cast(SUBSTRING_INDEX(duration,' ',1) as unsigned) as session_count
FROM netflix
WHERE 
type= 'TV SHOW'AND
cast(SUBSTRING_INDEX(duration,' ',1) as unsigned) > 5;

-- 9. Count the number of content items in each genre
-- 10.Find each year and the average numbers of content release in India on netflix. 
-- return top 5 year with highest avg content release!
select * from netflix;
select  YEAR(DATE_FORMAT(STR_TO_DATE(date_added, '%M %d, %Y'), '%Y-%m-%d')) AS formatted_date,count(*)/(select count(*) from netflix where country = 'india') as avg_number
from netflix
where country='india'
GROUP BY 1;

-- 11. List all movies that are documentaries
select *
from netflix
where listed_in like  'documentaries%';

-- 12. Find all content without a director
SELECT *
FROM netflix
WHERE director IS NULL OR director = '';

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT COUNT(*) AS salman_khan_movies
FROM netflix
WHERE type = 'Movie'
AND casts LIKE '%Salman Khan%'
AND release_year >= YEAR(CURDATE()) - 10;

-- 14.Find the top 10 actors who have appeared in the highest number of movies produced in India.


SELECT *,TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(casts, ',',1), ',',-4)) AS actor_name
from netflix
WHERE type = 'Movie' and country='india'
limit 10;




