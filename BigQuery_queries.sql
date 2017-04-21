# These queries are essentially directly from:
# https://github.com/fivethirtyeight/data/blob/master/subreddit-algebra/processData.sql
# by Ella Koeze (@ellakoeze on github).

# Query the first: you'll need to run this query and save the result to table on bigquery

## Creating list of number of users in each subreddit: 
## Thanks to Reddit users /u/Stuck_In_the_Matrix for pulling the data originally and /u/fhoffa for hosting the data on BigQery
SELECT subreddit, authors, DENSE_RANK() OVER (ORDER BY authors DESC) AS rank_authors
FROM (SELECT subreddit, SUM(1) as authors
     FROM (SELECT subreddit, author, COUNT(1) as cnt 
         FROM [fh-bigquery:reddit_comments.all_starting_201501]
         WHERE author NOT IN (SELECT author FROM [fh-bigquery:reddit_comments.bots_201505])
         GROUP BY subreddit, author HAVING cnt > 0)
     GROUP BY subreddit) t
ORDER BY authors DESC;

# Query the second: having completed the first query and saved the results you
# can run this query, substituting reddit-mapping:redditoverlaps.subr_rank_all_starting_201501
# for the BigQuery table where you saved the results of Query the first.

# Creating list of number of users who authored at least 10 posts in pairs of subreddits: 
SELECT t1.subreddit, t2.subreddit, SUM(1) as NumOverlaps
FROM (SELECT subreddit, author, COUNT(1) as cnt 
     FROM [fh-bigquery:reddit_comments.all_starting_201501]
     WHERE author NOT IN (SELECT author FROM [fh-bigquery:reddit_comments.bots_201505])
     AND subreddit IN (SELECT subreddit FROM [reddit-mapping:redditoverlaps.subr_rank_all_starting_201501]
       WHERE rank_authors>200 AND rank_authors<2201)
     GROUP BY subreddit, author HAVING cnt > 10) t1
JOIN (SELECT subreddit, author, COUNT(1) as cnt 
     FROM [fh-bigquery:reddit_comments.all_starting_201501]
     WHERE author NOT IN (SELECT author FROM [fh-bigquery:reddit_comments.bots_201505])
     GROUP BY subreddit, author HAVING cnt > 10) t2
ON t1.author=t2.author
WHERE t1.subreddit!=t2.subreddit
GROUP BY t1.subreddit, t2.subreddit
