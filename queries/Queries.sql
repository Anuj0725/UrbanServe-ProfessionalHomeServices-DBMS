1.Active customers with name, phone, email

SELECT cu.customer_id, cu.name, cu.phone, u.email, u.status
FROM Customer cu
JOIN Users u ON cu.user_id = u.user_id
WHERE u.status = 'Active'
ORDER BY cu.name ASC;



2.Active services in a given city

SELECT s.service_id, s.service_name, s.description,
       s.base_price, s.duration, ci.city_name
FROM Service s
JOIN City ci ON s.city_id = ci.city_id
WHERE s.is_active = TRUE AND ci.city_id = 1
ORDER BY s.base_price ASC;



3.Services under a category with price variants

SELECT c.category_name, s.service_name, s.base_price AS standard_price,  sv.variant_name, sv.price AS variant_price, sv.duration AS variant_mins
FROM Category c
JOIN Service s       ON c.category_id  = s.category_id
JOIN ServiceVariant sv ON s.service_id = sv.service_id
ORDER BY c.category_name, sv.price ASC;



4.Services inside each booking with line totals

SELECT b.booking_id, cu.name AS customer_name,
       s.service_name, cat.category_name,
       bi.quantity, bi.unit_price, bi.custom_price,
       (bi.quantity * bi.custom_price) AS line_total
FROM Booking b
JOIN Customer    cu  ON b.customer_id  = cu.customer_id
JOIN BookingItem bi  ON b.booking_id   = bi.booking_id
JOIN Service     s   ON bi.service_id  = s.service_id
JOIN Category    cat ON s.category_id  = cat.category_id
ORDER BY b.booking_id;



5.Price statistics per category

SELECT c.category_name,
       COUNT(s.service_id)                   AS total_services,
       MIN(s.base_price)                     AS cheapest,
       MAX(s.base_price)                     AS priciest,
       ROUND(AVG(s.base_price)::NUMERIC, 2)  AS avg_price
FROM Category c
JOIN Service s ON c.category_id = s.category_id
GROUP BY c.category_name
ORDER BY avg_price DESC;



6.Services matching keywords

SELECT service_id, service_name, base_price, duration
FROM Service
WHERE service_name ILIKE '%repair%'
   OR service_name ILIKE '%clean%'
ORDER BY base_price ASC;



7.Status breakdown — bookings per status

SELECT status, COUNT(*) AS booking_count
FROM BookingStatusLog
GROUP BY status
ORDER BY booking_count DESC;



8.Status log timeline for a specific booking

SELECT log_id, booking_id, status, remarks, changed_at 
FROM BookingStatusLog
WHERE booking_id = 3
ORDER BY changed_at  ASC;



9.Cancelled bookings with reason and refund status
SELECT b.booking_id, b.scheduled_date, b.total_amount,cn.reason, cn.refund_amount, cn.refund_status, cn.cancelled_at
FROM Cancellation cn
JOIN Booking b ON cn.booking_id = b.booking_id
ORDER BY cn.cancelled_at DESC;



10.Bookings with no status log entry
SELECT b.booking_id, b.scheduled_date, b.total_amount
FROM Booking b
LEFT JOIN BookingStatusLog bsl ON b.booking_id = bsl.booking_id
WHERE bsl.log_id IS NULL
ORDER BY b.booking_id;



11.Successful payments with customer details

SELECT p.payment_id, cu.name AS customer_name, b.booking_id,
       p.payment_method, p.amount, p.gateway_ref, p.paid_at
FROM Payment p
JOIN Booking  b  ON p.booking_id  = b.booking_id
JOIN Customer cu ON b.customer_id = cu.customer_id
WHERE p.status = 'Paid'
ORDER BY p.paid_at DESC;



12.Daily revenue report

SELECT b.scheduled_date,
       COUNT(p.payment_id) AS payments_on_day,
       SUM(p.amount)       AS daily_revenue
FROM Payment p
JOIN Booking b ON p.booking_id = b.booking_id
WHERE p.status = 'Paid'
GROUP BY b.scheduled_date
ORDER BY b.scheduled_date ASC;



13.Coupon usage statistics

SELECT cp.code, cp.discount_type, cp.discount_value,
       COUNT(b.booking_id) AS times_used
FROM Coupon cp
LEFT JOIN Booking b ON cp.coupon_id = b.coupon_id
GROUP BY cp.coupon_id, cp.code, cp.discount_type, cp.discount_value
ORDER BY times_used DESC;



14.Provider reviews with reviewer name and booking date 

SELECT pr.review_id, cu.name AS reviewer, sp.bio AS provider,
       pr.rating, pr.comment, b.scheduled_date
FROM ProviderReview pr
JOIN Booking         b   ON pr.booking_id  = b.booking_id
JOIN Customer        cu  ON b.customer_id  = cu.customer_id
JOIN ServiceProvider sp  ON pr.provider_id = sp.provider_id
ORDER BY pr.rating DESC;



15.Top 5 providers by average rating

SELECT sp.provider_id, sp.bio,
       ROUND(AVG(pr.rating)::NUMERIC, 2) AS avg_rating
FROM ServiceProvider sp
JOIN ProviderReview pr ON sp.provider_id = pr.provider_id
GROUP BY sp.provider_id, sp.bio
ORDER BY avg_rating DESC
LIMIT 5;
