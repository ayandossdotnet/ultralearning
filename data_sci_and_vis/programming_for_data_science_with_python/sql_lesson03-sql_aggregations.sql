/*
 Find the total amount of poster_qty paper ordered in the orders table.
 */
SELECT sum(orders.poster_qty) AS total_poster_qty
FROM public.orders;

/*
 Find the total amount of standard_qty paper ordered in the orders table.
 */
SELECT sum(orders.standard_qty)
FROM public.orders;

/*
 Find the total dollar amount of sales using the total_amt_usd in the orders table.
 */
SELECT sum(orders.total_amt_usd)
FROM public.orders;

/*
 Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.
 */
SELECT orders.standard_amt_usd + orders.gloss_amt_usd
FROM public.orders;

/*
 Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.
 */
SELECT sum(orders.standard_amt_usd) / sum(orders.standard_qty)
FROM public.orders;

/*
 When was the earliest order ever placed? You only need to return the date.
 */
SELECT min(orders.occurred_at)
FROM public.orders;

/*
 Try performing the same query as above without using an aggregation function.
 */
SELECT orders.occurred_at
FROM public.orders
ORDER BY orders.occurred_at
LIMIT 1;

/*
 When did the most recent (latest) web_event occur?
 */
SELECT max(web_events.occurred_at)
FROM public.web_events;

/*
 Try to perform the result of the previous query without using an aggregation function.
 */
SELECT web_events.occurred_at
FROM public.web_events
ORDER BY web_events.occurred_at DESC
LIMIT 1;

/*
 Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
 */
SELECT avg(orders.poster_qty) AS avg_poster_qty,
       avg(orders.poster_amt_usd) AS avg_poster_amt,
       avg(orders.gloss_qty) as avg_gloss_qty,
       avg(orders.gloss_amt_usd) AS avg_gloss_amt,
       avg(orders.standard_qty) AS avg_std_qty,
       avg(orders.standard_amt_usd) AS avg_std_amt
FROM public.orders;

/*
 What is the MEDIAN total_usd spent on all orders?
 */
SELECT percentile_cont(0.5) WITHIN GROUP ( ORDER BY orders.total_amt_usd )
FROM public.orders;

/*
 Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
 */
SELECT accounts.name, orders.occurred_at
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
ORDER BY orders.occurred_at
LIMIT 1;

/*
 Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
 */
SELECT accounts.name AS company, sum(orders.total_amt_usd) AS total_sales_usd
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY total_sales_usd DESC
LIMIT 15;

/*
 Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.
 */
SELECT web_events.occurred_at, web_events.channel, accounts.name
FROM public.web_events
JOIN accounts ON web_events.account_id = accounts.id
ORDER BY web_events.occurred_at DESC
LIMIT 1;

/*
 Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.
 */
SELECT web_events.channel, count(*) AS times_used
FROM public.web_events
GROUP BY web_events.channel
ORDER BY times_used DESC;

/*
 Who was the primary contact associated with the earliest web_event?
 */
SELECT accounts.primary_poc
FROM public.web_events
JOIN accounts ON web_events.account_id = accounts.id
ORDER BY web_events.occurred_at
LIMIT 1;

/*
 What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
 */
SELECT accounts.name, min(orders.total_amt_usd) as smallest_order
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY smallest_order, accounts.name;

/*
 Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
 */
SELECT region.name, count(sales_reps.id) AS number_sales_reps
FROM public.sales_reps
JOIN region ON sales_reps.region_id = region.id
GROUP BY region.name
ORDER BY number_sales_reps DESC;

/*
 For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.
 */
SELECT accounts.name, avg(orders.standard_qty), avg(orders.gloss_qty), avg(orders.poster_qty)
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY accounts.name;

/*
 For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
 */
SELECT accounts.name,
       avg(orders.standard_amt_usd),
       avg(orders.gloss_amt_usd),
       avg(orders.poster_amt_usd)
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY accounts.name;

/*
 Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
 */
SELECT sales_reps.name, web_events.channel, count(*) AS events
FROM public.web_events
JOIN accounts ON web_events.account_id = accounts.id
JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
GROUP BY sales_reps.name, web_events.channel
ORDER BY sales_reps.name, events DESC;

/*
 Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
 */
SELECT region.name, web_events.channel, count(*) AS events
FROM public.web_events
JOIN accounts ON web_events.account_id = accounts.id
JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
JOIN region ON sales_reps.region_id = region.id
GROUP BY region.name, web_events.channel
ORDER BY events DESC;

/*
 Use DISTINCT to test if there are any accounts associated with more than one region.
 */
SELECT accounts.name, region.name
FROM public.accounts
JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
JOIN region ON sales_reps.region_id = region.id
ORDER BY accounts.name;

SELECT DISTINCT accounts.id, accounts.name
FROM public.accounts;

/*
 Have any sales reps worked on more than one account?
 */
SELECT DISTINCT sales_reps.id, sales_reps.name
FROM public.sales_reps;

SELECT sales_reps.id, sales_reps.name, count(accounts.id) AS num_accounts
FROM public.accounts
JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
GROUP BY sales_reps.id, sales_reps.name
ORDER BY num_accounts;

/*
 How many of the sales reps have more than 5 accounts that they manage?
 */
SELECT sales_reps.id, sales_reps.name, count(accounts.id) AS num_accounts
FROM public.accounts
JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
GROUP BY sales_reps.id, sales_reps.name
HAVING count(accounts.id) > 5
ORDER BY num_accounts;

/*
 How many accounts have more than 20 orders?
 */
SELECT count(*) AS accounts_with_more_than_20_orders
FROM (
    SELECT accounts.name, count(orders.id) AS num_orders
    FROM public.orders
    JOIN accounts ON orders.account_id = accounts.id
    GROUP BY accounts.name
    HAVING count(orders.id) > 20) AS table1;

/*
 Which account has the most orders?
 */
SELECT accounts.name, count(orders.id) AS num_orders
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY accounts.name
HAVING count(orders.id) > 20
ORDER BY num_orders DESC
LIMIT 1;

/*
 Which accounts spent more than 30,000 usd total across all orders?
 */
SELECT accounts.name, sum(orders.total_amt_usd) AS total_spent_usd
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY accounts.name
HAVING sum(orders.total_amt_usd) > 30000
ORDER BY total_spent_usd DESC;

/*
 Which accounts spent less than 1,000 usd total across all orders?
 */
SELECT accounts.name, sum(orders.total_amt_usd) AS total_spent_usd
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY accounts.name
HAVING sum(orders.total_amt_usd) < 1000
ORDER BY total_spent_usd;

/*
 Which account has spent the most with us?
 */
SELECT accounts.name, sum(orders.total_amt_usd) AS total_spent_usd
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY total_spent_usd DESC
LIMIT 1;

/*
 Which account has spent the least with us?
 */
SELECT accounts.name, sum(orders.total_amt_usd) AS total_spent_usd
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY accounts.name
ORDER BY total_spent_usd
LIMIT 1;

/*
 Which accounts used facebook as a channel to contact customers more than 6 times?
 */
SELECT accounts.name, count(web_events.id) AS times_contacted_using_facebook
FROM public.web_events
JOIN accounts ON web_events.account_id = accounts.id
GROUP BY accounts.name, web_events.channel
HAVING count(web_events.id) > 6 AND web_events.channel IN ('facebook')
ORDER BY times_contacted_using_facebook DESC;

/*
 Which account used facebook most as a channel?
 */
SELECT accounts.name, count(web_events.id) AS times_contacted_using_facebook
FROM public.web_events
JOIN accounts ON web_events.account_id = accounts.id
GROUP BY accounts.name, web_events.channel
HAVING web_events.channel IN ('facebook')
ORDER BY times_contacted_using_facebook DESC
LIMIT 1;

/*
 Which channel was most frequently used by most accounts?
 */
SELECT accounts.name, web_events.channel, count(*) AS times_used
FROM public.web_events
JOIN accounts ON web_events.account_id = accounts.id
GROUP BY accounts.id, accounts.name, web_events.channel
ORDER BY times_used DESC
LIMIT 15;

/*
 Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
 */
SELECT date_part('year', orders.occurred_at) AS year, sum(orders.total_amt_usd) AS total_spent
FROM public.orders
GROUP BY year
ORDER BY total_spent DESC;

/*
 Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
 */
SELECT date_part('month', orders.occurred_at) AS month, sum(orders.total_amt_usd) AS total_spent
FROM public.orders
WHERE orders.occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY month
ORDER BY total_spent DESC;

/*
 Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
 */
SELECT date_part('year', orders.occurred_at) AS year, count(*) AS number_of_orders
FROM public.orders
GROUP BY year
ORDER BY number_of_orders DESC;

/*
 Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
 */
SELECT date_part('month', orders.occurred_at) as month,
       count(*) as number_of_orders
FROM public.orders
WHERE orders.occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

/*
 In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
 */
SELECT date_trunc('month', orders.occurred_at) AS month,
       sum(orders.gloss_amt_usd) AS gloss_usd
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
WHERE accounts.name IN ('Walmart')
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*
 Write a query to display for each order, the account ID, total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
 */
SELECT orders.account_id,
       orders.total_amt_usd,
       CASE WHEN orders.total_amt_usd >= 3000 THEN 'Large'
            ELSE 'Small' END AS order_level
FROM public.orders;

/*
 Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
 */
SELECT CASE WHEN orders.total >= 2000 THEN 'At Least 2000'
            WHEN orders.total >= 1000 AND orders.total < 2000 THEN 'Between 1000 and 2000'
            ELSE 'Less than 1000' END AS order_level,
       count(*) as no_of_orders
FROM public.orders
GROUP BY 1
ORDER BY 2 DESC;

/*
 We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
 */
SELECT accounts.name,
       sum(orders.total_amt_usd) AS total_sales,
       CASE WHEN sum(orders.total_amt_usd) > 200000 THEN 'Top Level'
            WHEN sum(orders.total_amt_usd) >= 100000 THEN 'Middle Level'
            WHEN sum(orders.total_amt_usd) < 100000 THEN 'Lowest Level' END AS lifetime_value_leel
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
GROUP BY 1
ORDER BY 2 DESC;

/*
 We would now like to perform a similar calculation to the previous one, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.
 */
SELECT accounts.name,
       sum(orders.total_amt_usd) AS total_sales,
       CASE WHEN sum(orders.total_amt_usd) > 200000 THEN 'Top Level'
            WHEN sum(orders.total_amt_usd) >= 100000 THEN 'Middle Level'
            WHEN sum(orders.total_amt_usd) < 100000 THEN 'Lowest Level' END AS lifetime_value_leel
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
WHERE date_part('year', orders.occurred_at) = 2016 OR
      date_part('year', orders.occurred_at) = 2017
GROUP BY 1
ORDER BY 2 DESC;

/*
 We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.
 */
SELECT sales_reps.name,
       count(orders.id) AS total_number_of_orders,
       CASE WHEN count(orders.id) > 200 THEN 'top'
            ELSE 'not' END AS top_sales_rep
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
GROUP BY 1
ORDER BY 2 DESC;

/*
 The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!
 */
SELECT sales_reps.name,
       count(orders.id) AS total_number_of_orders,
       sum(orders.total_amt_usd) AS total_sales,
       CASE WHEN count(orders.id) > 200 OR
                 sum(orders.total_amt_usd) > 750000 THEN 'top'
            WHEN count(orders.id) > 150 OR
                 sum(orders.total_amt_usd) > 500000 THEN 'middle'
            ELSE 'low' END AS sales_rep_category
FROM public.orders
JOIN accounts ON orders.account_id = accounts.id
JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
GROUP BY 1
ORDER BY 3 DESC;