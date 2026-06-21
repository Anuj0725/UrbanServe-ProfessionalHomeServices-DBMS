package com.anuj.UrbanServe.dto;

// What the client sends when submitting a review for a provider.
public record ProviderReviewRequestDto(
        Integer providerId,
        Integer bookingId,
        Double rating,
        String comment
) {
}
