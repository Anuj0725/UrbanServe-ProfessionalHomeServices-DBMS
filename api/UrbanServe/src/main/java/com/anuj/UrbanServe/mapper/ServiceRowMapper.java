package com.anuj.UrbanServe.mapper;

import com.anuj.UrbanServe.dto.ServiceDto;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ServiceRowMapper implements RowMapper<ServiceDto> {

    @Override
    public ServiceDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new ServiceDto(
                rs.getInt("service_id"),
                rs.getInt("city_id"),
                rs.getInt("category_id"),
                rs.getString("service_name"),
                rs.getString("description"),
                rs.getDouble("base_price"),
                rs.getInt("duration"),
                rs.getBoolean("is_active")
        );
    }
}