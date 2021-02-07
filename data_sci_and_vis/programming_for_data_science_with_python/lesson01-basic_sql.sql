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