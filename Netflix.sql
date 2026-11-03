

--SELECT * FROM NETFLIX

--1. Count the number of Movies vs TV ShowsN

	SELECT type , COUNT (*) AS TYPE_NUM 
	FROM netflix
	GROUP BY type 
	ORDER BY TYPE_NUM DESC

--2. Find the most common rating for movies and TV shows

WITH RANKING_COUNT AS 
(
	SELECT   TYPE, rating , 
	COUNT(*) RATING_NUM ,
	ROW_NUMBER () OVER (PARTITION BY TYPE  ORDER BY COUNT(*) DESC ) AS RANKING
	FROM netflix
	GROUP BY TYPE,  rating
	
	) 
	SELECT  TYPE , rating , RATING_NUM
	FROM RANKING_COUNT
	WHERE RANKING = 1 

--3. List all movies released in a specific year (e.g., 2020)
	
	SELECT title , release_year
	FROM netflix
	WHERE release_year = '2020' 
	AND type = 'MOVIE' ;
	
--4. Find the top 5 countries with the most content on Netflix

	SELECT TOP 5 
		LTRIM(RTRIM(C.VALUE)) AS COUNTRY,
		COUNT (*) AS CONTANT
	FROM netflix  N 
	CROSS APPLY string_split (N.country , ',') AS C
	WHERE country IS NOT NULL 
	AND LTRIM(RTRIM(C.VALUE)) <> ''
	GROUP BY LTRIM(RTRIM(C.VALUE))
	ORDER BY CONTANT desc


--5. Identify the longest movie 

	SELECT 
		title  , 
		TRY_CAST (LTRIM(RTRIM(D.value)) AS INT)  AS DURATION 
	FROM netflix N 
	CROSS APPLY string_split (duration , ' ' ) AS D 
	WHERE type = 'MOVIE' 
	AND TRY_CAST (LTRIM(RTRIM(D.value)) AS INT) IS NOT NULL 
	ORDER BY DURATION DESC;


--6. Find content added in the last 5 years

	SELECT  
		TYPE , title , release_year
	FROM netflix
	WHERE release_year IN ( 
			SELECT TOP 5  release_year FROM netflix
			GROUP BY release_year
			ORDER BY release_year DESC) 
	ORDER BY release_year


--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

	SELECT type , title , director
	FROM netflix
	WHERE director LIKE '%Rajiv Chilaka%'

--8. List all TV shows with more than 5 seasons
	
	SELECT TYPE , title , DURATION 
	FROM netflix 
	WHERE TYPE = 'TV SHOW'
	AND TRY_CAST(LEFT( DURATION ,CHARINDEX(' ',DURATION) -1) AS INT) > 5 
	ORDER BY duration
	 
	
--9. Count the number of content items in each genre

	SELECT  
		TYPE , 
		LTRIM(RTRIM(L1.VALUE)) AS GENRE ,
		COUNT(*) CONTANT 
	FROM netflix N
	CROSS APPLY string_split (N.listed_in,',') AS L1
	WHERE LTRIM(RTRIM(L1.VALUE))  <> ''
	GROUP BY LTRIM(RTRIM(L1.VALUE)),TYPE
	ORDER BY CONTANT DESC 

--10.Find each year and the average numbers of content release in India on netflix. 
--return top 5 year with highest avg content release!

WITH INDIA_RELEASE AS 
(
	SELECT
		LTRIM(RTRIM(C.value)) COUNTRY,
		MONTH(date_added) AS ADDED_MONTH 
		,YEAR (date_added) AS ADDED_YAER, 
		COUNT(*) AS CONTENT 
	FROM netflix N
	CROSS APPLY string_split (N.country, ',') AS C 
	WHERE LTRIM(RTRIM(C.value)) = 'INDIA'
	AND YEAR (date_added) IS NOT NULL
	GROUP BY YEAR (date_added) ,MONTH(date_added),
	 LTRIM(RTRIM(C.value)) 
			
	) , 
YEARLY_AVG AS 
	( 
	SELECT  ADDED_YAER ,  
	  AVG(CONTENT )   AS AVG_MONTHLY_CONTENT
	FROM INDIA_RELEASE
	GROUP BY ADDED_YAER 
		)
 SELECT TOP 5 
		 ADDED_YAER , AVG_MONTHLY_CONTENT
		 FROM YEARLY_AVG 
		 ORDER BY AVG_MONTHLY_CONTENT DESC

--11. List all movies that are documentaries
	
	SELECT 
		TYPE, title ,listed_in
	FROM netflix N
	WHERE  listed_in LIKE  '%DOCUMENTARIES%' 


--12. Find all content without a director

	SELECT 
		SHOW_ID ,TYPE, title , listed_in 
	FROM netflix
	WHERE director IS NULL 
	GROUP BY SHOW_ID ,TYPE, title , listed_in

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

	SELECT 
		title , release_year , date_added
	FROM netflix
	WHERE TYPE = 'MOVIE'
	AND CAST LIKE '%Salman Khan%'
	AND DATE_ADDED >= DATEADD (YEAR, -10 ,GETDATE())
	ORDER BY date_added 

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

	SELECT TOP 10 
		LTRIM(RTRIM(C.value)) CAST , 
		COUNT(*) CONTENT
	FROM netflix N
	CROSS APPLY string_split (N.cast ,',') AS C
	WHERE type = 'MOVIE' 
	AND country LIKE '%INDIA%'
	GROUP BY LTRIM(RTRIM(C.value))
	ORDER BY CONTENT DESC

--15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.

WITH CATEGORIES AS 
(
	SELECT * ,
	CASE 
		WHEN  description LIKE '% KILL %' OR  
		description LIKE '% violence %' THEN 'BAD' 
			 ELSE 'GOOD'
	END CATEGORY 
	FROM netflix
)
	SELECT CATEGORY ,
		COUNT(*) CONTENT_COUNT
	FROM CATEGORIES 
	GROUP BY CATEGORY 