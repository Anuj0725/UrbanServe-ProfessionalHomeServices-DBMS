package com.anuj.UrbanServe.dto;

import java.time.LocalDate;
import java.time.LocalTime;

// What the API returns when reading booking details.
// Maps to columns from the v_booking_summary view.
public record BookingResponseDto(
        Integer bookingId,
        String bookingStatus,
        LocalDate scheduledDate,
        LocalTime scheduledTime,
        Double totalAmount,
        Integer customerId,
        String customerName,
        Integer providerId,
        String providerBio,
        Double providerRating,
        String cityName,
        String areaName,
        String pincode,
        String couponCode,
        Double discountValue,
        String paymentMethod,
        String paymentStatus
) {
}
