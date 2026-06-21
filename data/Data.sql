-- 1. Users (30 rows)
INSERT INTO Users VALUES
(1,'cust1@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(2,'cust2@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(3,'cust3@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(4,'cust4@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(5,'cust5@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(6,'cust6@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(7,'cust7@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(8,'cust8@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(9,'cust9@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(10,'cust10@gmail.com','pass123','Customer','Active',CURRENT_TIMESTAMP),
(11,'prov1@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(12,'prov2@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(13,'prov3@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(14,'prov4@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(15,'prov5@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(16,'prov6@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(17,'prov7@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(18,'prov8@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(19,'prov9@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(20,'prov10@gmail.com','pass123','Provider','Active',CURRENT_TIMESTAMP),
(21,'admin1@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP),
(22,'admin2@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP),
(23,'admin3@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP),
(24,'admin4@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP),
(25,'admin5@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP),
(26,'admin6@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP),
(27,'admin7@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP),
(28,'admin8@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP),
(29,'admin9@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP),
(30,'admin10@gmail.com','admin123','Admin','Active',CURRENT_TIMESTAMP);

-- 2. Customer (10 rows — unique user_ids 1-10)
INSERT INTO Customer VALUES
(1,1,'Rahul Sharma','9000000001'),
(2,2,'Priya Patel','9000000002'),
(3,3,'Amit Shah','9000000003'),
(4,4,'Sneha Joshi','9000000004'),
(5,5,'Karan Mehta','9000000005'),
(6,6,'Neha Gupta','9000000006'),
(7,7,'Vikram Singh','9000000007'),
(8,8,'Ananya Reddy','9000000008'),
(9,9,'Rohan Desai','9000000009'),
(10,10,'Meera Iyer','9000000010');

-- 3. ServiceProvider (10 rows — unique user_ids 11-20)
-- avg_rating seeded to match the ProviderReview rows inserted later
-- (each provider here has exactly one review, so avg_rating = that rating).
INSERT INTO ServiceProvider
    (provider_id, user_id, experience_years, bio, avg_rating, verification_status)
VALUES
(1,11,5,'Electrician expert',4.1,'Verified'),
(2,12,4,'Cleaner expert',4.2,'Verified'),
(3,13,3,'Plumber expert',4.3,'Verified'),
(4,14,6,'Painter expert',4.4,'Verified'),
(5,15,2,'Mechanic expert',4.5,'Pending'),
(6,16,7,'AC Repair expert',4.6,'Verified'),
(7,17,8,'Laptop Repair expert',4.7,'Verified'),
(8,18,4,'TV Repair expert',4.8,'Verified'),
(9,19,5,'Washing Machine expert',4.9,'Pending'),
(10,20,3,'Furniture Repair expert',5.0,'Verified');

-- 4. Admin (10 rows — unique user_ids 21-30)
INSERT INTO Admin VALUES
(1,21,'SuperAdmin','ALL','Operations'),
(2,22,'Manager','LIMITED','Support'),
(3,23,'HR','EMP','HR'),
(4,24,'Ops','OPS','Operations'),
(5,25,'Lead','TEAM','Leadership'),
(6,26,'Auditor','VIEW','Audit'),
(7,27,'Tech','TECH','IT'),
(8,28,'Finance','FIN','Finance'),
(9,29,'Sales','SALE','Sales'),
(10,30,'Intern','MIN','Training');

-- 5. City (10 rows)
INSERT INTO City VALUES
(1,'Ahmedabad','Gujarat'),
(2,'Surat','Gujarat'),
(3,'Vadodara','Gujarat'),
(4,'Rajkot','Gujarat'),
(5,'Mumbai','Maharashtra'),
(6,'Pune','Maharashtra'),
(7,'Delhi','Delhi'),
(8,'Jaipur','Rajasthan'),
(9,'Indore','Madhya Pradesh'),
(10,'Bhopal','Madhya Pradesh');

-- 6. Area (10 rows)
INSERT INTO Area VALUES
(1,1,'Gota','382481'),
(2,1,'Satellite','380015'),
(3,2,'Adajan','395009'),
(4,2,'Vesu','395007'),
(5,3,'Akota','390020'),
(6,4,'Kalavad','360001'),
(7,5,'Andheri','400001'),
(8,6,'Hinjewadi','411057'),
(9,7,'Dwarka','110001'),
(10,8,'Malviya Nagar','302017');

-- 7. Address (10 rows)
INSERT INTO Address VALUES
(1,1,'Street 1','Near Mall','Home',23.1000,72.1000),
(2,2,'Street 2','Near Park','Office',23.0300,72.5600),
(3,3,'Street 3','Near School','Home',21.1960,72.8300),
(4,4,'Street 4','Near Temple','Office',21.1800,72.8100),
(5,5,'Street 5','Near Bank','Home',22.3000,73.2000),
(6,6,'Street 6','Near Lake','Office',22.2900,70.7800),
(7,7,'Street 7','Near Shop','Home',19.1130,72.8700),
(8,8,'Street 8','Near Club','Office',18.5900,73.7400),
(9,9,'Street 9','Near Bus Stop','Home',28.6100,77.2100),
(10,10,'Street 10','Near Garden','Office',26.9100,75.7900);

-- 8. Category (10 rows)
INSERT INTO Category VALUES
(1,'Cleaning','Home and office cleaning services'),
(2,'Electrical','Electrical repair and installation'),
(3,'Plumbing','Pipe, tap, and drainage services'),
(4,'Painting','Wall painting and waterproofing'),
(5,'Repair','General appliance repair'),
(6,'AC','AC servicing and installation'),
(7,'Laptop','Laptop and computer repair'),
(8,'TV','Television repair and mounting'),
(9,'Furniture','Furniture repair and assembly'),
(10,'Salon','Haircut, grooming and beauty services');

-- 9. Service (10 rows)
INSERT INTO Service VALUES
(1,1,1,'Bathroom Cleaning','Deep bathroom cleaning with disinfection',499,60,TRUE),
(2,1,2,'Fan Repair','Ceiling and table fan repair',299,30,TRUE),
(3,2,3,'Pipe Repair','Leaking pipe fix and replacement',399,45,TRUE),
(4,2,4,'Wall Painting','Interior wall painting per room',999,120,TRUE),
(5,3,5,'Bike Repair','Two-wheeler servicing and repair',699,90,TRUE),
(6,4,6,'AC Service','Split and window AC maintenance',899,90,TRUE),
(7,5,7,'Laptop Repair','Hardware and software troubleshooting',1499,120,TRUE),
(8,6,8,'TV Repair','LED and LCD TV panel repair',999,60,TRUE),
(9,7,9,'Chair Repair','Office and dining chair repair',499,40,TRUE),
(10,8,10,'Hair Cut','Men and women haircut and styling',299,30,TRUE);

-- 10. ServiceVariant (10 rows)
INSERT INTO ServiceVariant VALUES
(1,1,'Premium',699,90),
(2,2,'Advanced',499,45),
(3,3,'Emergency',599,60),
(4,4,'Luxury',1299,150),
(5,5,'Quick',799,60),
(6,6,'Gold',1099,100),
(7,7,'Expert',1999,180),
(8,8,'Smart',1499,90),
(9,9,'Wood Special',699,70),
(10,10,'VIP',499,45);

-- 11. ProviderAvailability (10 rows)
INSERT INTO ProviderAvailability VALUES
(1,1,'Monday','09:00','18:00'),
(2,2,'Tuesday','09:00','18:00'),
(3,3,'Wednesday','09:00','18:00'),
(4,4,'Thursday','09:00','18:00'),
(5,5,'Friday','09:00','18:00'),
(6,6,'Saturday','09:00','18:00'),
(7,7,'Sunday','09:00','18:00'),
(8,8,'Monday','10:00','17:00'),
(9,9,'Tuesday','10:00','17:00'),
(10,10,'Wednesday','10:00','17:00');

-- 12. ProviderDocument (10 rows)
INSERT INTO ProviderDocument VALUES
(1,1,'Aadhar','Government ID proof','a1.pdf','Verified',CURRENT_TIMESTAMP),
(2,2,'PAN','Tax identification','a2.pdf','Verified',CURRENT_TIMESTAMP),
(3,3,'License','Trade license','a3.pdf','Verified',CURRENT_TIMESTAMP),
(4,4,'Aadhar','Government ID proof','a4.pdf','Pending',CURRENT_TIMESTAMP),
(5,5,'PAN','Tax identification','a5.pdf','Verified',CURRENT_TIMESTAMP),
(6,6,'License','Trade license','a6.pdf','Verified',CURRENT_TIMESTAMP),
(7,7,'Aadhar','Government ID proof','a7.pdf','Verified',CURRENT_TIMESTAMP),
(8,8,'PAN','Tax identification','a8.pdf','Pending',CURRENT_TIMESTAMP),
(9,9,'License','Trade license','a9.pdf','Verified',CURRENT_TIMESTAMP),
(10,10,'Aadhar','Government ID proof','a10.pdf','Verified',CURRENT_TIMESTAMP);

-- 13. Coupon (10 rows)
INSERT INTO Coupon VALUES
(1,'SAVE10','Flat',100,10,50,'2026-01-01','2026-12-31'),
(2,'SAVE20','Flat',200,20,50,'2026-01-01','2026-12-31'),
(3,'SAVE30','Flat',300,30,50,'2026-01-01','2026-12-31'),
(4,'SAVE40','Flat',400,40,50,'2026-01-01','2026-12-31'),
(5,'SAVE50','Flat',500,50,50,'2026-01-01','2026-12-31'),
(6,'DISC5','Percent',100,5,100,'2026-01-01','2026-12-31'),
(7,'DISC10','Percent',200,10,100,'2026-01-01','2026-12-31'),
(8,'DISC15','Percent',300,15,100,'2026-01-01','2026-12-31'),
(9,'DISC20','Percent',400,20,100,'2026-01-01','2026-12-31'),
(10,'DISC25','Percent',500,25,100,'2026-01-01','2026-12-31');

-- 14. Booking (20 rows)
--     Bookings 1-7: Completed and paid
--     Booking 8: In-Progress (matches BookingStatusLog)
--     Booking 9: Confirmed (matches BookingStatusLog)
--     Booking 10: Pending (matches BookingStatusLog)
--     Bookings 11-20: Cancelled (no coupon used)
INSERT INTO Booking
    (booking_id, customer_id, provider_id, address_id, coupon_id,
     scheduled_date, scheduled_time, total_amount, status, special_instructions, created_at)
VALUES
(1,1,1,1,1,'2026-04-01','10:00',450,'Completed','Please be on time',CURRENT_TIMESTAMP),
(2,2,2,2,2,'2026-04-02','11:00',550,'Completed','Handle furniture carefully',CURRENT_TIMESTAMP),
(3,3,3,3,3,'2026-04-03','12:00',650,'Completed','Urgent repair needed',CURRENT_TIMESTAMP),
(4,4,4,4,4,'2026-04-04','13:00',750,'Completed','Use eco-friendly paint',CURRENT_TIMESTAMP),
(5,5,5,5,5,'2026-04-05','14:00',850,'Completed','Bring own tools',CURRENT_TIMESTAMP),
(6,6,6,6,6,'2026-04-06','15:00',950,'Completed','Call before arriving',CURRENT_TIMESTAMP),
(7,7,7,7,NULL,'2026-04-07','16:00',1050,'Completed','Ring the doorbell',CURRENT_TIMESTAMP),
(8,8,8,8,NULL,'2026-04-08','17:00',1150,'In-Progress','Parking available in basement',CURRENT_TIMESTAMP),
(9,9,9,9,NULL,'2026-04-09','18:00',1250,'Confirmed','Gate code is 4521',CURRENT_TIMESTAMP),
(10,10,10,10,NULL,'2026-04-10','19:00',1350,'Pending','Evening slot preferred',CURRENT_TIMESTAMP),
(11,1,2,1,NULL,'2026-04-11','10:00',499,'Cancelled','N/A',CURRENT_TIMESTAMP),
(12,2,3,2,NULL,'2026-04-12','11:00',599,'Cancelled','N/A',CURRENT_TIMESTAMP),
(13,3,4,3,NULL,'2026-04-13','12:00',699,'Cancelled','N/A',CURRENT_TIMESTAMP),
(14,4,5,4,NULL,'2026-04-14','13:00',799,'Cancelled','N/A',CURRENT_TIMESTAMP),
(15,5,6,5,NULL,'2026-04-15','14:00',899,'Cancelled','N/A',CURRENT_TIMESTAMP),
(16,6,7,6,NULL,'2026-04-16','15:00',999,'Cancelled','N/A',CURRENT_TIMESTAMP),
(17,7,8,7,NULL,'2026-04-17','16:00',1099,'Cancelled','N/A',CURRENT_TIMESTAMP),
(18,8,9,8,NULL,'2026-04-18','17:00',1199,'Cancelled','N/A',CURRENT_TIMESTAMP),
(19,9,10,9,NULL,'2026-04-19','18:00',1299,'Cancelled','N/A',CURRENT_TIMESTAMP),
(20,10,1,10,NULL,'2026-04-20','19:00',1399,'Cancelled','N/A',CURRENT_TIMESTAMP);

-- 15. BookingItem (10 rows — one item per completed booking, bookings 1-10)
--     Fixed: original data put all 10 rows under booking_id=1 (item_no 1-10).
--     Spread across bookings 1-10 instead, item_no=1 for each, so every
--     completed booking actually has a line item.
INSERT INTO BookingItem VALUES
(1,1,1,1,499,450),
(2,1,2,1,299,280),
(3,1,3,1,399,390),
(4,1,4,1,999,900),
(5,1,5,1,699,650),
(6,1,6,1,899,850),
(7,1,7,1,1499,1400),
(8,1,8,1,999,950),
(9,1,9,1,499,450),
(10,1,10,1,299,250);

-- 16. BookingStatusLog (10 rows — for completed bookings 1-10)
INSERT INTO BookingStatusLog VALUES
(1,1,'Completed','Service done successfully',CURRENT_TIMESTAMP),
(2,2,'Completed','Customer satisfied',CURRENT_TIMESTAMP),
(3,3,'Completed','Issue resolved',CURRENT_TIMESTAMP),
(4,4,'Completed','Painting finished',CURRENT_TIMESTAMP),
(5,5,'Completed','Repair done',CURRENT_TIMESTAMP),
(6,6,'Completed','AC serviced',CURRENT_TIMESTAMP),
(7,7,'Completed','Laptop fixed',CURRENT_TIMESTAMP),
(8,8,'In-Progress','Technician on site',CURRENT_TIMESTAMP),
(9,9,'Confirmed','Provider assigned',CURRENT_TIMESTAMP),
(10,10,'Pending','Awaiting provider confirmation',CURRENT_TIMESTAMP);

-- 17. Payment (10 rows — for completed bookings 1-10 only)
INSERT INTO Payment VALUES
(1,1,'UPI',450,'TXN001','Paid',CURRENT_TIMESTAMP),
(2,2,'Card',550,'TXN002','Paid',CURRENT_TIMESTAMP),
(3,3,'Cash',650,'TXN003','Paid',CURRENT_TIMESTAMP),
(4,4,'UPI',750,'TXN004','Paid',CURRENT_TIMESTAMP),
(5,5,'Card',850,'TXN005','Paid',CURRENT_TIMESTAMP),
(6,6,'Cash',950,'TXN006','Paid',CURRENT_TIMESTAMP),
(7,7,'UPI',1050,'TXN007','Paid',CURRENT_TIMESTAMP),
(8,8,'Card',1150,'TXN008','Paid',CURRENT_TIMESTAMP),
(9,9,'Cash',1250,'TXN009','Pending',CURRENT_TIMESTAMP),
(10,10,'UPI',1350,'TXN010','Pending',CURRENT_TIMESTAMP);

-- 18. Cancellation (10 rows — for cancelled bookings 11-20 only, no overlap with Payment)
INSERT INTO Cancellation VALUES
(1,11,'Provider unavailable',100,'Refunded',CURRENT_TIMESTAMP),
(2,12,'Schedule conflict',120,'Refunded',CURRENT_TIMESTAMP),
(3,13,'Customer changed mind',140,'Refunded',CURRENT_TIMESTAMP),
(4,14,'Service no longer needed',160,'Refunded',CURRENT_TIMESTAMP),
(5,15,'Found cheaper alternative',180,'Refunded',CURRENT_TIMESTAMP),
(6,16,'Emergency at home',200,'Pending',CURRENT_TIMESTAMP),
(7,17,'Provider did not show up',220,'Pending',CURRENT_TIMESTAMP),
(8,18,'Delayed response',240,'Pending',CURRENT_TIMESTAMP),
(9,19,'Wrong service booked',260,'Refunded',CURRENT_TIMESTAMP),
(10,20,'Relocated to new city',280,'Refunded',CURRENT_TIMESTAMP);

-- 19. ProviderReview (10 rows — reviews for completed bookings 1-10)
INSERT INTO ProviderReview VALUES
(1,1,1,4.1,'Good work, very professional',CURRENT_TIMESTAMP),
(2,2,2,4.2,'Nice and clean service',CURRENT_TIMESTAMP),
(3,3,3,4.3,'Best plumber I have hired',CURRENT_TIMESTAMP),
(4,4,4,4.4,'Great paint finish',CURRENT_TIMESTAMP),
(5,5,5,4.5,'Amazing repair skills',CURRENT_TIMESTAMP),
(6,6,6,4.6,'Excellent AC servicing',CURRENT_TIMESTAMP),
(7,7,7,4.7,'Fast laptop fix',CURRENT_TIMESTAMP),
(8,8,8,4.8,'Top-notch TV repair',CURRENT_TIMESTAMP),
(9,9,9,4.9,'Perfect furniture work',CURRENT_TIMESTAMP),
(10,10,10,5.0,'Outstanding salon experience',CURRENT_TIMESTAMP);

-- 20. ServiceReview (10 rows — reviews for services via bookings 1-10)
INSERT INTO ServiceReview VALUES
(1,1,1,4.0,'Bathroom sparkling clean',CURRENT_TIMESTAMP),
(2,2,2,4.1,'Fan works like new',CURRENT_TIMESTAMP),
(3,3,3,4.2,'No more leaking pipes',CURRENT_TIMESTAMP),
(4,4,4,4.3,'Walls look beautiful',CURRENT_TIMESTAMP),
(5,5,5,4.4,'Bike runs smoothly now',CURRENT_TIMESTAMP),
(6,6,6,4.5,'AC cooling perfectly',CURRENT_TIMESTAMP),
(7,7,7,4.6,'Laptop speed improved',CURRENT_TIMESTAMP),
(8,8,8,4.7,'TV picture quality restored',CURRENT_TIMESTAMP),
(9,9,9,4.8,'Chair is sturdy again',CURRENT_TIMESTAMP),
(10,10,10,4.9,'Best haircut in town',CURRENT_TIMESTAMP);

-- 21. Complaint (10 rows — various users filing complaints)
INSERT INTO Complaint VALUES
(1,1,'Late Arrival','Provider arrived 45 minutes late','Low','Open','Pending',CURRENT_TIMESTAMP),
(2,2,'Poor Quality','Cleaning was not thorough','High','Closed','Full refund issued',CURRENT_TIMESTAMP),
(3,3,'Rude Behavior','Provider was unprofessional','Medium','Open','Under investigation',CURRENT_TIMESTAMP),
(4,4,'Overcharged','Charged more than quoted price','Low','Closed','Price adjusted',CURRENT_TIMESTAMP),
(5,5,'Incomplete Work','Left without finishing the job','High','Open','Pending reassignment',CURRENT_TIMESTAMP),
(6,6,'Wrong Service','Sent electrician instead of plumber','Medium','Closed','Correct provider sent',CURRENT_TIMESTAMP),
(7,7,'No Show','Provider never showed up','Low','Open','Pending',CURRENT_TIMESTAMP),
(8,8,'Damage','Provider damaged kitchen tiles','High','Closed','Compensation provided',CURRENT_TIMESTAMP),
(9,9,'Delay','Service took 3x longer than estimated','Medium','Open','Pending review',CURRENT_TIMESTAMP),
(10,10,'Refund Issue','Refund not received after cancellation','High','Closed','Refund processed',CURRENT_TIMESTAMP);
