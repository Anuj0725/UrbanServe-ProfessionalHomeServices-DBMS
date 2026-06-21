package com.anuj.UrbanServe.dto;

public record ServiceDto(
        Integer serviceId,
        Integer cityId,
        Integer categoryId,
        String serviceName,
        String description,
        Double basePrice,
        Integer duration,
        Boolean isActive) {
}
