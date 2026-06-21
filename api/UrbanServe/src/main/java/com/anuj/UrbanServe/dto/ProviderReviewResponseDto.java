package com.anuj.UrbanServe.dto;

import java.time.LocalDateTime;

// What the API returns when reading a review — includes reviewer and
// provider context, not just the raw review row.
public record ProviderReviewResponseDto(
        Integer reviewId,
        Integer providerId,
        String providerBio,
        Integer bookingId,
        String reviewerName,
        Double rating,
        String comment,
        LocalDateTime createdAt
) {
}
