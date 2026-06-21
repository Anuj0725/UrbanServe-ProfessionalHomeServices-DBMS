package com.anuj.UrbanServe.dto;

import java.time.LocalDate;
import java.time.LocalTime;

// What the client sends when creating a new booking.
// Maps directly to the parameters of the place_booking() stored procedure.
public record BookingRequestDto(
        Integer customerId,
        Integer providerId,
        Integer addressId,
        Integer couponId,            // nullable — booking may not use a coupon
        LocalDate scheduledDate,
        LocalTime scheduledTime,
        Double totalAmount,
        String specialInstructions,
        Integer serviceId,
        Integer quantity,
        Double unitPrice
) {
}
