package com.anuj.UrbanServe.repository;

import com.anuj.UrbanServe.dto.CustomerDto;
import com.anuj.UrbanServe.mapper.CustomerRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CustomerRepository {

    private final JdbcTemplate jdbcTemplate;
    private final CustomerRowMapper rowMapper = new CustomerRowMapper();

    public CustomerRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // All active customers with email pulled in via a join to Users.
    // Mirrors Queries.sql #1.
    public List<CustomerDto> findActiveCustomers() {
        String sql = """
                SELECT cu.customer_id, cu.user_id, cu.name, cu.phone,
                       u.email, u.status
                FROM Customer cu
                JOIN Users u ON cu.user_id = u.user_id
                WHERE u.status = 'Active'
                ORDER BY cu.name ASC
                """;
        return jdbcTemplate.query(sql, rowMapper);
    }

    // Single customer by ID, same join.
    public CustomerDto findById(int customerId) {
        String sql = """
                SELECT cu.customer_id, cu.user_id, cu.name, cu.phone,
                       u.email, u.status
                FROM Customer cu
                JOIN Users u ON cu.user_id = u.user_id
                WHERE cu.customer_id = ?
                """;
        List<CustomerDto> results = jdbcTemplate.query(sql, rowMapper, customerId);
        return results.isEmpty() ? null : results.get(0);
    }
}
