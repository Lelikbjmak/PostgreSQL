## Description

[Kata](https://www.codewars.com/kata/5dac87a0abe9f1001f39e36d/train/sql)
<br>
Given the information about sales in a store, calculate the total revenue for each day, month, year, and product.

 **Notes:**
* The sales table stores only the dates for which any data has been recorded - the information about individual sales
(what was sold, and when) is stored in the sales_details table instead
* The sales_details table stores totals per product per date
* Order the result by the product_name, year, month, day columns
* We're interested only in the product-specific data, so you shouldn't return the total revenue from all sales

---

### Input tables 
```js
----------------------------------------
|    Table      |   Column   |  Type   |
|---------------+------------+---------|
| products      | id         | int     |
|               | name       | text    |
|               | price      | numeric |
|---------------+------------+---------|
| sales         | id         | int     |
|               | date       | date    |
|---------------+------------+---------|
| sales_details | id         | int     |
|               | sale_id    | int     |
|               | product_id | int     |
|               | count      | int     |
-----------------------------------------
```

### Output table

```js
--------------------------
|    Column    |  Type   |
|--------------+---------|
| product_name | text    |
| year         | int     |
| month        | int     |
| day          | int     |
| total        | numeric |
--------------------------
```

### Example output
```js
product_name | year | month | day | total
-------------+------+-------+-----+------
 milk        | 2019 | 01    | 01  | 200
 milk        | 2019 | 01    | 02  | 190
 milk        | 2019 | 01    |     | 390
 milk        | 2019 | 02    | 01  | 240
 milk        | 2019 | 02    |     | 240
 milk        | 2019 |       |     | 630
 milk        |      |       |     | 630
 ```
 ---
  
 ## Solution
 ```js
SELECT P.name as product_name, DATE_PART('YEAR', S.date) as year,
         DATE_PART('MONTH', S.date) as month,
         DATE_PART('DAY', S.date) as day, SUM(SD.count * P.price) as total
    from products as P
        left join sales_details as SD on (SD.product_id = P.id)
        left join sales as S on (S.id = SD.sale_id)
    GROUP BY ROLLUP(P.name, DATE_PART('YEAR', S.date),
            DATE_PART('MONTH', S.date),DATE_PART('DAY', S.date))
    ORDER BY(P.name, DATE_PART('YEAR', S.date),
            DATE_PART('MONTH', S.date),DATE_PART('DAY', S.date))
limit ( select count(*) - 1 from (select P.name from products as P
        left join sales_details as SD on (SD.product_id = P.id)
        left join sales as S on (S.id = SD.sale_id)
    GROUP BY ROLLUP(P.name, DATE_PART('YEAR', S.date),
            DATE_PART('MONTH', S.date),DATE_PART('DAY', S.date))
) as L);
 ```

## Best Practices

 ```js
select
  name as product_name,
  extract(year from date)::int as year,
  extract(month from date)::int as month,
  extract(day from date)::int as day,
  sum(price * count) as total
from sales_details sd
join sales s on sd.sale_id = s.id
join products p on sd.product_id = p.id
group by name, rollup(year, month, day)
order by product_name, year, month, day
 ```
