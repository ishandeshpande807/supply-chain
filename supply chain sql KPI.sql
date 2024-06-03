
use supply_chain;


 select concat(round(sum(sales_amount)/1000000),'M') as sales from point_of_sales;
 
select monthname(sdate) as months , concat(round(sum(sales_amount)/1000000),'M') as sales
  from sales as s join point_of_sales as p on s.order_number=p.order_number
  group by months
  order by sales desc;
  
   select concat('Q', quarter(sdate)) as Quarters , concat(round(sum(sales_amount)/1000000),'M') as sales
  from sales as s join point_of_sales as p on s.order_number=p.order_number
  group by Quarters
  order by sales ;
  
     select  year(sdate) as years , concat(round(sum(sales_amount)/1000000),'M') as sales
  from sales as s join point_of_sales as p on s.order_number=p.order_number
  group by years
  order by sales desc;
  
  select  `Product Type`  , concat(round(sum(sales_amount)/1000000),'M') as sales
  from d_product as d join point_of_sales as p on d.`Product Key`=p.product_key
  group by `Product Type`
  order by sales desc;

    select  year(sdate) as years , 
   concat(round(( concat(round(sum(sales_amount)/1000000),'M') -
    lag(concat(round(sum(sales_amount)/1000000),'M')) over(order by year(sdate)))
    / lag(concat(round(sum(sales_amount)/1000000),'M')) over(order by year(sdate)) 
    * 100),'%') AS sales_growth_percentage
  from sales as s join point_of_sales as p on s.order_number=p.order_number
  group by years;
  

  select sdate  ,sales_amount as sales,
  avg(sales_amount) over (partition by sdate order by sdate rows between 6 preceding and current row) 
  as 7dayrollingavg
  from sales as s join point_of_sales as p on s.order_number=p.order_number
  order by sdate;
    
  select   `Store State` , concat(round(sum(sales_amount)/1000),'k') as sales
  from sales as s join point_of_sales as p on s.order_number=p.order_number
  join d_store as d on s.store_key=d.`Store Key`
  group by `Store State`
  order by sales ;

  select   `Store Name` , concat(round(sum(sales_amount)/1000000),'M') as sales
  from sales as s join point_of_sales as p on s.order_number=p.order_number
  join d_store as d on s.store_key=d.`Store Key`
  group by `Store Name`
  order by sales desc limit 5; 
  
    select   `Store Region` , concat(round(sum(sales_amount)/1000000),'M') as sales
  from sales as s join point_of_sales as p on s.order_number=p.order_number
  join d_store as d on s.store_key=d.`Store Key`
  group by `Store Region`
  order by sales desc; 
  
  select `Product Type`,sum(`Quantity on Hand`) as inventory
  from f_inventory_adjusted group by `Product Type`;
  
  select sum(`Quantity on Hand`) as total_inventory
  from f_inventory_adjusted;
  
    select concat(round(sum(`Cost Amount`)),'$') as total_inventory_value
  from f_inventory_adjusted;
  
  select `Product Type`,concat(round(sum(`Cost Amount`)),'$') as inventory_value
  from f_inventory_adjusted group by `Product Type`;
  
  select case
  when `Quantity on Hand` <= 0 then 'out of stock'
  when `Quantity on Hand`> 2 then 'over stock'
  else 'at stock'
  end as stock_status , sum(`Quantity on Hand`) as quantity
  from f_inventory_adjusted  group by stock_status ;
  
  
  


