# Description
[Kata](https://www.codewars.com/kata/5a8f00745084d718940000c5/train/sql)
<br>
<br>
Make a <b>SELECT</b> query which will tell the <b>price per kg<b/> of the product.

Weight is in <b>grams</b>! Round the price_per_kg to 2 decimal places.

Order results by price_per_kg ascending, then by name ascending.

***Products table schema***
---
id (int)
<br>
name (string)
<br>
price (float)
<br>
stock (int)
<br>
weight (float)
<br>
producer (string)
<br>
country (string)
<br>

***Results table schema***
---
name (string)
<br>
weight (float)
<br>
price (float)
<br>
price_per_kg (float)
<br>
  
---
## Solution 
```js
SELECT name, weight, price, 
  ROUND((price*1000/weight)::numeric,2)::float AS price_per_kg
  -- instead of :: we can use CAST((price*1000/weight) as numeric(6, -2)) and again to float
FROM Products 
ORDER BY price_per_kg, name;
```
