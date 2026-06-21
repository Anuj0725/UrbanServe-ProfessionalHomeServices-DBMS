package com.anuj.UrbanServe.mapper;

import com.anuj.UrbanServe.dto.ServiceProviderDto;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ServiceProviderRowMapper implements RowMapper<ServiceProviderDto> {

    @Override
    public ServiceProviderDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new ServiceProviderDto(
                rs.getInt("provider_id"),
                rs.getInt("user_id"),
                rs.getInt("experience_years"),
                rs.getString("bio"),
                rs.getDouble("avg_rating"),
                rs.getString("verification_status"),
                rs.getString("email")
        );
    }
}
