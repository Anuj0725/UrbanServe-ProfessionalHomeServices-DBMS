package com.anuj.UrbanServe.mapper;

import com.anuj.UrbanServe.dto.BookingResponseDto;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BookingResponseRowMapper implements RowMapper<BookingResponseDto> {

    @Override
    public BookingResponseDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new BookingResponseDto(
                rs.getInt("booking_id"),
                rs.getString("booking_status"),
                rs.getDate("scheduled_date").toLocalDate(),
                rs.getTime("scheduled_time").toLocalTime(),
                rs.getDouble("total_amount"),
                rs.getInt("customer_id"),
                rs.getString("customer_name"),
                rs.getInt("provider_id"),
                rs.getString("provider_bio"),
                rs.getDouble("provider_rating"),
                rs.getString("city_name"),
                rs.getString("area_name"),
                rs.getString("pincode"),
                rs.getString("coupon_code"),
                rs.getDouble("discount_value"),
                rs.getString("payment_method"),
                rs.getString("payment_status")
        );
    }
}
