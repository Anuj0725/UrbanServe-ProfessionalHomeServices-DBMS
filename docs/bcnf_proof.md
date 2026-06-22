# BCNF Proof

A relation is in **Boyce-Codd Normal Form (BCNF)** if, for every functional
dependency X → Y in the relation, X is a superkey — meaning the left-hand
side of every dependency must be able to uniquely determine every other
attribute in the table. If any non-key attribute depends on something less
than a full key, the relation violates BCNF.

Below, each table's minimal functional dependency set is listed, followed
by the BCNF justification.

---

### 1. Users
```
user_id → email
user_id → password
user_id → role
user_id → status
user_id → created_at
```
`user_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 2. Customer
```
customer_id → user_id
customer_id → name
customer_id → phone
```
`customer_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 3. ServiceProvider
```
provider_id → user_id
provider_id → experience_years
provider_id → bio
provider_id → verification_status
```
`provider_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 4. Admin
```
admin_id → user_id
admin_id → admin_role
admin_id → permissions
admin_id → department
```
`admin_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 5. City
```
city_id → city_name
city_id → state
```
`city_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 6. Area
```
area_id → city_id
area_id → area_name
area_id → pincode
```
`area_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 7. Address
```
address_id → area_id
address_id → street
address_id → landmark
address_id → label
address_id → latitude
address_id → longitude
```
`address_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 8. Category
```
category_id → category_name
category_id → description
```
`category_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 9. Service
```
service_id → category_id
service_id → city_id
service_id → service_name
service_id → description
service_id → base_price
service_id → duration
service_id → is_active
```
`service_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 10. ServiceVariant
```
variant_id → service_id
variant_id → variant_name
variant_id → price
variant_id → duration
```
`variant_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 11. ProviderAvailability
```
availability_id → provider_id
availability_id → day_of_week
availability_id → start_time
availability_id → end_time
```
`availability_id` is a candidate key, hence a superkey. The relation is in
BCNF.

### 12. ProviderDocument
```
document_id → provider_id
document_id → document_type
document_id → file_url
document_id → verification_status
```
`document_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 13. Booking
```
booking_id → customer_id
booking_id → provider_id
booking_id → address_id
booking_id → coupon_id
booking_id → scheduled_date
booking_id → scheduled_time
booking_id → total_amount
booking_id → special_instructions
booking_id → created_at
```
`booking_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 14. BookingItem
```
(booking_id, item_no) → service_id
(booking_id, item_no) → quantity
(booking_id, item_no) → unit_price
(booking_id, item_no) → custom_price
```
`(booking_id, item_no)` is the composite candidate key, hence a superkey.
The relation is in BCNF.

### 15. BookingStatusLog
```
log_id → booking_id
log_id → status
log_id → remarks
log_id → changed_at
```
`log_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 16. Payment
```
payment_id → booking_id
payment_id → payment_method
payment_id → amount
payment_id → gateway_ref
payment_id → status
payment_id → paid_at
```
`payment_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 17. Cancellation
```
cancel_id → booking_id
cancel_id → reason
cancel_id → refund_amount
cancel_id → refund_status
cancel_id → cancelled_at
```
`cancel_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 18. Coupon
```
coupon_id → code
coupon_id → discount_type
coupon_id → min_order
coupon_id → discount_value
coupon_id → usage_limit
coupon_id → valid_from
coupon_id → valid_to
```
`coupon_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 19. ProviderReview
```
review_id → provider_id
review_id → booking_id
review_id → rating
review_id → comment
review_id → created_at
```
`review_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 20. ServiceReview
```
review_id → service_id
review_id → booking_id
review_id → rating
review_id → comment
review_id → created_at
```
`review_id` is a candidate key, hence a superkey. The relation is in BCNF.

### 21. Complaint
```
complaint_id → user_id
complaint_id → subject
complaint_id → description
complaint_id → priority
complaint_id → status
complaint_id → resolution_notes
complaint_id → created_at
```
`complaint_id` is a candidate key, hence a superkey. The relation is in
BCNF.

---

All 21 tables listed above — plus `ServiceVariant`'s parent `Service` and
the remaining catalog/profile tables — follow the same pattern: every
non-key attribute is functionally dependent only on the table's primary key
(or composite key), so there are no partial or transitive dependencies on a
non-superkey. The schema is fully normalized to BCNF.
