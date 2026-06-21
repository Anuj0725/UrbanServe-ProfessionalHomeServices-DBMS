package com.anuj.UrbanServe.dto;

public record CustomerDto(
        Integer customerId,
        Integer userId,
        String name,
        String phone,
        String email,
        String userStatus
) {
}
