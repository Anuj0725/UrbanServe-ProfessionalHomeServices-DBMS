package com.anuj.UrbanServe.dto;

public record ServiceProviderDto(
        Integer providerId,
        Integer userId,
        Integer experienceYears,
        String bio,
        Double avgRating,
        String verificationStatus,
        String email
) {
}
