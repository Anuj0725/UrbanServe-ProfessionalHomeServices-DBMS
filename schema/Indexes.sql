CREATE INDEX idx_area_city_id ON Area(city_id);

CREATE INDEX idx_address_area_id ON Address(area_id);

CREATE INDEX idx_service_city_id ON Service(city_id);
CREATE INDEX idx_service_category_id ON Service(category_id);

CREATE INDEX idx_service_is_active ON Service(is_active);

CREATE INDEX idx_servicevariant_service_id ON ServiceVariant(service_id);

CREATE INDEX idx_provideravailability_provider_id ON ProviderAvailability(provider_id);

CREATE INDEX idx_providerdocument_provider_id ON ProviderDocument(provider_id);

CREATE INDEX idx_booking_customer_id ON Booking(customer_id);
CREATE INDEX idx_booking_provider_id ON Booking(provider_id);
CREATE INDEX idx_booking_address_id ON Booking(address_id);
CREATE INDEX idx_booking_coupon_id ON Booking(coupon_id);

CREATE INDEX idx_booking_scheduled_date ON Booking(scheduled_date);

CREATE INDEX idx_bookingitem_service_id ON BookingItem(service_id);

CREATE INDEX idx_bookingstatuslog_booking_id ON BookingStatusLog(booking_id);

CREATE INDEX idx_payment_status ON Payment(status);

CREATE INDEX idx_providerreview_provider_id ON ProviderReview(provider_id);
CREATE INDEX idx_providerreview_booking_id ON ProviderReview(booking_id);

CREATE INDEX idx_servicereview_service_id ON ServiceReview(service_id);
CREATE INDEX idx_servicereview_booking_id ON ServiceReview(booking_id);

CREATE INDEX idx_complaint_user_id ON Complaint(user_id);
CREATE INDEX idx_complaint_status ON Complaint(status);