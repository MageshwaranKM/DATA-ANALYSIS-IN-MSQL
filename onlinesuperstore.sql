create database onlinesuperstore_analysis;
use onlinesuperstore_analysis;

show databases;

desc onlinesuperstore;
select * from  onlinesuperstore; 

select CustomerID,CustomerName ,Segment,Country,region from onlinesuperstore;
## total orders :
select count(orderID) as totalorders from onlinesuperstore;

##qus1: what is the total sales and profit in each of regions?

select region ,sum(Sales) as Sales,
sum(Profit) as Profit
 from onlinesuperstore group by region;

##qus2:what is the total sales and profit in each of coutry?

select State ,round(sum(Sales)) as Sales, round(sum(Profit)) as Profit from onlinesuperstore group by State order by profit desc;

##qus3:what are the states on the top 5 in sales?
select State , Sales from onlinesuperstore order by sales desc limit 5;

##qus4:what are  the states on the least 5 in sales?
select State , Sales from onlinesuperstore order by sales asc limit 5;

##qus5:top profitable state in country? and least profitable country?

select State , profit from onlinesuperstore order by profit desc limit 1;


select State , profit from onlinesuperstore order by profit asc limit 1;

#qus6:how many products in the furnicher category and which product is on highest sale?

 select count(*) as furniture_products from onlinesuperstore where category ='Furniture';
 
 select * from onlinesuperstore where category = 'Furniture' order by sales desc limit 1;

select * from onlinesuperstore where category = 'Furniture' order by profit desc limit 1;

##qus7: category wise total profit and sale?

select ss.Category ,sum(sales) as totalsales ,sum(profit) as totalprofit,
 RANK() OVER (ORDER BY SUM(sales) DESC) AS CategoryRank from onlinesuperstore ss group by Category order by totalprofit desc ;

##qus8: Who are the top 5 customers based on their total spending?

SELECT ss.productID, ss.ProductName , sum(sales) as totalsales   from onlinesuperstore ss group by ProductName  order by totalsales desc limit 5;



##qus9:Product Category Ranking: Rank product categories by total sales in descending order using window functions.

SELECT sub_category, Round(SUM(sales)) AS TotalSales,
 RANK() OVER (ORDER BY SUM(sales) DESC) AS CategoryRank
FROM onlinesuperstore
GROUP BY sub_category
ORDER BY TotalSales DESC;

/*qus9:find level of purchase  from sales */
select orderID,customerID,customerName,city, 
case 
when sales > 1000 then 'goodsales'
when sales > 500 then 'avg sales'
else 'low sales'
end as saleslevel from onlinesuperstore;
