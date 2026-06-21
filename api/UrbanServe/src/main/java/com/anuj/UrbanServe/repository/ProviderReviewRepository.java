package com.anuj.UrbanServe.repository;

import com.anuj.UrbanServe.dto.ProviderReviewRequestDto;
import com.anuj.UrbanServe.dto.ProviderReviewResponseDto;
import com.anuj.UrbanServe.mapper.ProviderReviewRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

@Repository
public class ProviderReviewRepository {

    private final JdbcTemplate jdbcTemplate;
    private final ProviderReviewRowMapper rowMapper = new ProviderReviewRowMapper();

    public ProviderReviewRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Inserts a new review. review_id is a plain INT PK (not SERIAL),
    // so the next ID is computed manually — same approach used inside
    // place_booking() for booking_id/log_id.
    // No manual avg_rating update needed here — trg_update_provider_avg_rating
    // (from 03_views_triggers_v2.sql) fires automatically on this INSERT
    // and recalculates ServiceProvider.avg_rating on its own.
    public Integer addReview(ProviderReviewRequestDto request) {
        Integer newReviewId = jdbcTemplate.queryForObject(
                "SELECT COALESCE(MAX(review_id), 0) + 1 FROM ProviderReview",
                Integer.class
        );

        String sql = """
                INSERT INTO ProviderReview (review_id, provider_id, booking_id, rating, comment, created_at)
                VALUES (?, ?, ?, ?, ?, ?)
                """;
        jdbcTemplate.update(
                sql,
                newReviewId,
                request.providerId(),
                request.bookingId(),
                request.rating(),
                request.comment(),
                Timestamp.valueOf(java.time.LocalDateTime.now())
        );

        return newReviewId;
    }

    // Single review by ID, with reviewer name and provider bio joined in.
    public ProviderReviewResponseDto findById(int reviewId) {
        String sql = """
                SELECT pr.review_id, pr.provider_id, sp.bio AS provider_bio,
                       pr.booking_id, cu.name AS reviewer_name,
                       pr.rating, pr.comment, pr.created_at
                FROM ProviderReview pr
                JOIN ServiceProvider sp ON pr.provider_id = sp.provider_id
                JOIN Booking b          ON pr.booking_id  = b.booking_id
                JOIN Customer cu        ON b.customer_id  = cu.customer_id
                WHERE pr.review_id = ?
                """;
        List<ProviderReviewResponseDto> results = jdbcTemplate.query(sql, rowMapper, reviewId);
        return results.isEmpty() ? null : results.get(0);
    }

    // All reviews for a given provider, most recent first.
    // Mirrors Queries.sql #14.
    public List<ProviderReviewResponseDto> findByProviderId(int providerId) {
        String sql = """
                SELECT pr.review_id, pr.provider_id, sp.bio AS provider_bio,
                       pr.booking_id, cu.name AS reviewer_name,
                       pr.rating, pr.comment, pr.created_at
                FROM ProviderReview pr
                JOIN ServiceProvider sp ON pr.provider_id = sp.provider_id
                JOIN Booking b          ON pr.booking_id  = b.booking_id
                JOIN Customer cu        ON b.customer_id  = cu.customer_id
                WHERE pr.provider_id = ?
                ORDER BY pr.created_at DESC
                """;
        return jdbcTemplate.query(sql, rowMapper, providerId);
    }
}