
--1. Revenue Performance by Product Category (Grouping & Aggregation)
--Objective: Discover which products drive the most volume and revenue.

SELECT 
    Product, 
    COUNT(OrderID) AS Total_Orders, 
    SUM(TotalPrice) AS Total_Revenue, 
    AVG(TotalPrice) AS Average_Order_Value
FROM sales_data
GROUP BY Product
ORDER BY Total_Revenue DESC;

--Insight: This uses GROUP BY to bucket the data by product and aggregates it to show exact financial health (SUM) and typicality (AVG).


--2. Identifying Revenue Leakage (Filtering & Grouping)
--Objective: Analyze how much potential revenue is lost to non-completed orders (Cancelled or Returned).

SELECT 
    OrderStatus, 
    COUNT(OrderID) AS Volume, 
    SUM(TotalPrice) AS Impact_Value
FROM sales_data
WHERE OrderStatus IN ('Cancelled', 'Returned')
GROUP BY OrderStatus
ORDER BY Impact_Value DESC;

--Insight: The WHERE clause acts as a funnel to isolate only the problematic order statuses before grouping them.


--3. High-Value Customer Acquisition (Advanced Filtering with HAVING)
--Objective: Find which marketing channels (ReferralSource) are bringing in the highest quality traffic (only showing channels that have generated over $50,000 in completed sales).

SELECT 
    ReferralSource, 
    COUNT(OrderID) AS Total_Referrals, 
    SUM(TotalPrice) AS Realized_Revenue
FROM sales_data
WHERE OrderStatus = 'Delivered'
GROUP BY ReferralSource
HAVING SUM(TotalPrice) > 50000
ORDER BY Realized_Revenue DESC;

--Insight: Remember the execution order: WHERE filters out raw rows (non-delivered orders) first, then GROUP BY buckets by source, and HAVING filters the aggregated buckets to only show top-performing channels.  


--4. VIP Order Tracking (Basic Filtering & Sorting)
--Objective: Extract a clean list of the top 10 highest-value individual purchases for the customer success team to review.

SELECT 
    OrderID, 
    CustomerID, 
    Date, 
    Product, 
    TotalPrice 
FROM sales_data
WHERE OrderStatus = 'Delivered'
ORDER BY TotalPrice DESC
LIMIT 10;

--Insight: ORDER BY finalizes the presentation layer by sorting the highest values to the top.