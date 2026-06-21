package com.anuj.UrbanServe.repository;

import com.anuj.UrbanServe.dto.ServiceDto;
import com.anuj.UrbanServe.mapper.ServiceRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ServiceRepository {

    private final JdbcTemplate jdbcTemplate;
    private final ServiceRowMapper rowMapper = new ServiceRowMapper();

    // Constructor injection — Spring automatically provides the JdbcTemplate bean here.
    public ServiceRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // All active services in a given city, cheapest first.
    // Mirrors Queries.sql #2.
    public List<ServiceDto> findActiveServicesByCity(int cityId) {
        String sql = """
                SELECT *
                FROM Service
                WHERE is_active = TRUE AND city_id = ?
                ORDER BY base_price ASC
                """;
        return jdbcTemplate.query(sql, rowMapper, cityId);
    }

    // Single service by ID.
    public ServiceDto findById(int serviceId) {
        String sql = """
                SELECT *
                FROM Service
                WHERE service_id = ?
                """;
        List<ServiceDto> results = jdbcTemplate.query(sql, rowMapper, serviceId);
        return results.isEmpty() ? null : results.get(0);
    }

    // Keyword search across service names.
    // Mirrors Queries.sql #6.
    public List<ServiceDto> searchByKeyword(String keyword) {
        String sql = """
                SELECT *
                FROM Service
                WHERE service_name ILIKE ?
                ORDER BY base_price ASC
                """;
        return jdbcTemplate.query(sql, rowMapper, "%" + keyword + "%");
    }
}