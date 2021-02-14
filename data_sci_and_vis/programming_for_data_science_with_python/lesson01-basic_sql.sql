SELECT *
FROM public.orders;

SELECT orders.id, orders.account_id, orders.occurred_at
FROM public.orders;

/*
 Try using LIMIT yourself below by writing a query that displays all the data in the occurred_at, account_id, and channel columns of the web_events table, and limits the output to only the first 15 rows.
 */
SELECT web_events.occurred_at, web_events.account_id, web_events.channel
FROM public.web_events
LIMIT 15;

/*
 Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.
 */
SELECT orders.id, orders.occurred_at, orders.total_amt_usd
FROM public.orders
ORDER BY orders.occurred_at
LIMIT 10;

/*
 Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.
 */
SELECT orders.id, orders.account_id, orders.total_amt_usd
FROM public.orders
ORDER BY orders.total_amt_usd DESC
LIMIT 5;

/*
 Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.
 */
SELECT orders.id,orders.account_id, orders.total_amt_usd
FROM public.orders
ORDER BY orders.total_amt_usd
LIMIT 20;

/*
 Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).
 */
SELECT orders.id, orders.account_id, orders.total_amt_usd
FROM public.orders
ORDER BY orders.account_id, orders.total_amt_usd DESC;

/*
 Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).
 */
SELECT orders.id, orders.account_id, orders.total_amt_usd
FROM public.orders
ORDER BY orders.total_amt_usd DESC, orders.account_id;

/*
 Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.
 */
SELECT *
FROM public.orders
WHERE orders.gloss_amt_usd >= 1000
LIMIT 5;

/*
 Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.
 */
SELECT *
FROM public.orders
WHERE orders.total_amt_usd < 500
LIMIT 10;

/*
 Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table.
 */
SELECT accounts.name, accounts.website, accounts.primary_poc
FROM public.accounts
WHERE accounts.name = 'Exxon Mobil';

/*
 Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.
 */
SELECT orders.id, orders.account_id, orders.standard_amt_usd / orders.standard_qty AS unit_price
FROM public.orders
LIMIT 10;

/*
 Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also. NOTE - you will receive an error with the correct solution to this question. This occurs because at least one of the values in the data creates a division by zero in your formula. You will learn later in the course how to fully handle this issue. For now, you can just limit your calculations to the first 10 orders, as we did in question #1, and you'll avoid that set of data that causes the problem.
 */
SELECT orders.id, orders.account_id, orders.poster_amt_usd / (orders.standard_amt_usd + orders.gloss_amt_usd + orders.poster_amt_usd) AS poster_percentage
FROM public.orders
LIMIT 10;

/*
 All the companies whose names start with 'C'.
 */
SELECT accounts.name
FROM public.accounts
WHERE accounts.name LIKE 'C%';

/*
 All companies whose names contain the string 'one' somewhere in the name.
 */
SELECT accounts.name
FROM public.accounts
WHERE accounts.name LIKE '%one%';

/*
 All companies whose names end with 's'.
 */
SELECT accounts.name
FROM public.accounts
WHERE accounts.name LIKE '%s';

/*
 Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
 */
SELECT accounts.name, accounts.primary_poc, accounts.sales_rep_id
FROM public.accounts
WHERE accounts.name IN ('Walmart', 'Target', 'Nordstrom');

/*
 Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.
 */
SELECT *
FROM public.web_events
WHERE web_events.channel IN ('organic', 'adwords');

/*
 Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.
 */
SELECT accounts.name, accounts.primary_poc, accounts.sales_rep_id
FROM public.accounts
WHERE accounts.name NOT IN ('Walmart', 'Target', 'Nordstrom');

/*
 Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
 */
SELECT *
FROM public.web_events
WHERE web_events.channel NOT IN ('organic', 'adwords');

/*
 All the companies whose names do not start with 'C'.
 */
SELECT accounts.name
FROM public.accounts
WHERE accounts.name NOT LIKE 'C%';

/*
 All companies whose names do not contain the string 'one' somewhere in the name.
 */
SELECT accounts.name
FROM public.accounts
WHERE accounts.name NOT LIKE '%one%';

/*
 All companies whose names do not end with 's'.
 */
SELECT accounts.name
FROM public.accounts
WHERE accounts.name NOT LIKE '%s';

/*
 Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
 */
SELECT *
FROM public.orders
WHERE orders.standard_qty > 1000 AND orders.poster_qty = 0 AND orders.gloss_qty = 0;

/*
 Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.
 */
SELECT *
FROM public.accounts
WHERE accounts.name NOT LIKE 'C%' AND accounts.name LIKE '%s';

/*
 When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the answer to this important question by writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.
 */
SELECT *
FROM public.orders
WHERE orders.gloss_qty >= 24 AND orders.gloss_qty <= 29;

SELECT *
FROM public.orders
WHERE orders.gloss_qty BETWEEN 24 AND 29;

/*
 Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.
 */
SELECT *
FROM public.web_events
WHERE web_events.channel IN ('organic', 'adwords') AND web_events.occurred_at BETWEEN '2016-01-01' AND '2016-12-31 23:59:59';

/*
 Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.
 */
SELECT orders.id
FROM public.orders
WHERE orders.gloss_qty > 4000 OR orders.poster_qty > 4000;

/*
 Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
 */
SELECT *
FROM public.orders
WHERE orders.standard_qty = 0 AND
      (orders.gloss_qty > 1000 OR orders.poster_qty > 1000);

/*
 Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
 */
SELECT *
FROM public.accounts
WHERE (accounts.name LIKE 'C%' OR accounts.name LIKE 'W%') AND
      ((accounts.primary_poc LIKE '%ana%' OR accounts.primary_poc LIKE '%Ana%') AND
       accounts.primary_poc NOT LIKE '%eana%');