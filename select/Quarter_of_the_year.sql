select q.month, case 
when q.month < 4 then 1
when q.month >= 4 and q.month < 7 then 2
when q.month >= 7 and q.month < 10 then 3
when q.month >= 10 and q.month < 13 then 4
end as res
from quarterof as q ;
