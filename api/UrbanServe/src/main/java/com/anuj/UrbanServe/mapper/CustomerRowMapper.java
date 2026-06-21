package com.anuj.UrbanServe.mapper;

import com.anuj.UrbanServe.dto.CustomerDto;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerRowMapper implements RowMapper<CustomerDto> {

    @Override
    public CustomerDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new CustomerDto(
                rs.getInt("customer_id"),
                rs.getInt("user_id"),
                rs.getString("name"),
                rs.getString("phone"),
                rs.getString("email"),
                rs.getString("status")
        );
    }
}
