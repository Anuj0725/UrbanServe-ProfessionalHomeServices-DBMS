package com.anuj.UrbanServe.repository;

import com.anuj.UrbanServe.dto.ServiceProviderDto;
import com.anuj.UrbanServe.mapper.ServiceProviderRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ServiceProviderRepository {

    private final JdbcTemplate jdbcTemplate;
    private final ServiceProviderRowMapper rowMapper = new ServiceProviderRowMapper();

    public ServiceProviderRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // All verified providers, highest rated first.
    public List<ServiceProviderDto> findVerifiedProviders() {
        String sql = """
                SELECT sp.provider_id, sp.user_id, sp.experience_years,
                       sp.bio, sp.avg_rating, sp.verification_status, u.email
                FROM ServiceProvider sp
                JOIN Users u ON sp.user_id = u.user_id
                WHERE sp.verification_status = 'Verified'
                ORDER BY sp.avg_rating DESC
                """;
        return jdbcTemplate.query(sql, rowMapper);
    }

    // Single provider by ID.
    public ServiceProviderDto findById(int providerId) {
        String sql = """
                SELECT sp.provider_id, sp.user_id, sp.experience_years,
                       sp.bio, sp.avg_rating, sp.verification_status, u.email
                FROM ServiceProvider sp
                JOIN Users u ON sp.user_id = u.user_id
                WHERE sp.provider_id = ?
                """;
        List<ServiceProviderDto> results = jdbcTemplate.query(sql, rowMapper, providerId);
        return results.isEmpty() ? null : results.get(0);
    }

    // Top 5 providers by avg_rating — reads directly from your
    // mv_provider_leaderboard materialized view instead of recomputing
    // the aggregation here. Note: this view has different/extra columns
    // (total_reviews, total_bookings, etc.) than ServiceProviderDto, so
    // a quick inline mapping is used here rather than the shared rowMapper.
    public List<ServiceProviderDto> findTopProviders(int limit) {
        String sql = """
                SELECT provider_id, email, bio, experience_years,
                       verification_status, avg_rating
                FROM mv_provider_leaderboard
                LIMIT ?
                """;
        return jdbcTemplate.query(sql, (rs, rowNum) -> new ServiceProviderDto(
                rs.getInt("provider_id"),
                null, // user_id not exposed by the leaderboard view
                rs.getInt("experience_years"),
                rs.getString("bio"),
                rs.getDouble("avg_rating"),
                rs.getString("verification_status"),
                rs.getString("email")
        ), limit);
    }
}
