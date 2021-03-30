
select 
    orders.customer_id,
    orders.order_id,
    order_amounts.total amount

from
    (
        select
            min(order_id) as order_id,
            sum(amount) as total
        from (
            select * from {{ref('stg_payments')}}
            where status = 'success'
        )
        group by order_id
    ) order_amounts
    inner join (select * from {{ref('stg_orders')}}) orders on order_amounts.order_id=orders.order_id
