package com.anuj.UrbanServe.mapper;

import com.anuj.UrbanServe.dto.ProviderReviewResponseDto;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProviderReviewRowMapper implements RowMapper<ProviderReviewResponseDto> {

    @Override
    public ProviderReviewResponseDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new ProviderReviewResponseDto(
                rs.getInt("review_id"),
                rs.getInt("provider_id"),
                rs.getString("provider_bio"),
                rs.getInt("booking_id"),
                rs.getString("reviewer_name"),
                rs.getDouble("rating"),
                rs.getString("comment"),
                rs.getTimestamp("created_at").toLocalDateTime()
        );
    }
}
