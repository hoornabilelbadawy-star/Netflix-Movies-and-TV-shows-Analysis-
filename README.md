

Netflix Movies & TV Shows Analysis – SQL Project

1. Project Overview

This project focuses on exploring and analyzing Netflix Movies and TV Shows using Microsoft SQL Server.

The main objective was to investigate Netflix content distribution, ratings, countries, genres, actors, directors, and content trends over time through a set of 15 analytical questions.

2. Dataset Information

The dataset contains information about Netflix titles, including the following columns:

* show_id
* type
* title
* director
* cast
* country
* date_added
* release_year
* rating
* duration
* listed_in
* description

3. Business Questions & Analysis

The project addresses 15 analytical questions:

1. Count the number of Movies vs. TV Shows.
2. Find the most common rating for Movies and TV Shows.
3. List all movies released in a specific year.
4. Find the top 5 countries with the most Netflix content.
5. Identify the longest movie.
6. Find content added in the last five available years.
7. Find all movies and TV shows by director Rajiv Chilaka.
8. List all TV shows with more than five seasons.
9. Count the number of content items in each genre.
10. Find each year and the average monthly content added in India, returning the top five years.
11. List all movies classified as documentaries.
12. Find all content without director information.
13. Find the number of movies featuring Salman Khan in the last ten years.
14. Find the top 10 actors with the highest number of appearances in Indian movies.
15. Categorize content based on the keywords ‘kill’ and ‘violence’ in the description, labeling it as Good or Bad.

4. SQL Skills & Techniques Applied

Throughout this project, I practiced and applied:

* Aggregate Functions: COUNT(), AVG(), MAX()
* Filtering & Grouping: WHERE, GROUP BY, HAVING
* Sorting & Limiting: ORDER BY, TOP
* Common Table Expressions (CTEs)
* Subqueries
* Window Functions and Ranking
* CROSS APPLY and STRING_SPLIT()
* CASE WHEN
* TRY_CAST()
* String Functions: LTRIM(), RTRIM(), CHARINDEX()
* Date Functions: YEAR(), MONTH()

5. Challenges & Problem-Solving

During the project, I encountered several challenges that required additional problem-solving:

1. Handling Multiple Values in One Column

Some columns, such as country, cast, and listed_in, contain multiple values within a single cell.

* Solution: Used CROSS APPLY with STRING_SPLIT() to separate multiple values into individual rows for more detailed analysis.

2. Handling Mixed Data Types in the Duration Column

The duration column contains both numeric values and text, such as 120 min and 5 Seasons.

* Solution: Used LTRIM(), CHARINDEX(), and TRY_CAST() to extract and convert the numeric portion, allowing me to filter TV shows with more than five seasons.

3. Dynamic Date Filtering

Instead of using fixed date conditions with BETWEEN, I wanted to identify the latest five years dynamically.

* Solution: Used a subquery with TOP 5, GROUP BY, and ORDER BY to retrieve the latest available years.

4. Calculating Average Monthly Content Added

I wanted to identify the years with the highest average monthly content additions in India.

* Solution: Used CROSS APPLY to extract India from the country column, date functions to extract the year and month, and CTEs to calculate the average monthly content for each year.

5. Conditional Content Classification

I wanted to categorize content based on the presence of specific keywords in the description.

* Solution: Used CASE WHEN to classify content containing ‘kill’ or ‘violence’ as Bad and all other content as Good.

6. Project Source & Contribution

The dataset and analytical questions were obtained from a YouTube educational source.

However, the SQL queries, solutions, and analytical approach were independently developed and implemented by me. 

ORIGINAL PROJECT SOURCE: https://www.youtube.com/watch?v=-7cT0651_lw&t=4964s 

This project provided an opportunity to strengthen my SQL skills, improve my analytical thinking, and practice solving practical data-related challenges.

7. Key Takeaways

* Improved my understanding of SQL querying and data exploration.
* Gained practical experience with CTEs, subqueries, and window functions.
* Learned to handle multi-value columns using CROSS APPLY.
* Improved my ability to work with mixed data types and text manipulation.
* Developed a more structured approach to solving analytical problems.
