## Description
[KATA](https://www.codewars.com/kata/58113a64e10b53ec36000293/train/sql)
<br>
For this challenge you need to create a SELECT statement that will contain data
about departments that had a sale with a price over 98.00 dollars.
This SELECT statement will have to use an EXISTS to achieve the task.

---

### departments table schema
* id
* name

### sales table schema
* id
* department_id (department foreign key)
* name
* price
* card_name
* card_number
* transaction_date

### resultant table schema
* id
* name

---

## Solution

```js
select D.id, D.name from departments as D
where exists 
(select s.name from sales as S where S.department_id = D.id and S.price > 98.00);
```
