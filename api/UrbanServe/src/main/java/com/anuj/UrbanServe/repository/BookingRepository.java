package com.anuj.UrbanServe.repository;

import com.anuj.UrbanServe.dto.BookingRequestDto;
import com.anuj.UrbanServe.dto.BookingResponseDto;
import com.anuj.UrbanServe.mapper.BookingResponseRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BookingRepository {

    private final JdbcTemplate jdbcTemplate;
    private final BookingResponseRowMapper rowMapper = new BookingResponseRowMapper();

    public BookingRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Calls the place_booking() stored procedure. Postgres executes the
    // Booking + BookingItem + BookingStatusLog inserts as one atomic
    // transaction inside the function itself — if anything inside fails,
    // all three roll back together. This call either returns a new
    // booking_id, or the database throws (e.g. a CHECK constraint
    // violation), which propagates up as a Java exception.
    public Integer placeBooking(BookingRequestDto request) {
        String sql = "SELECT place_booking(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.queryForObject(
                sql,
                Integer.class,
                request.customerId(),
                request.providerId(),
                request.addressId(),
                request.couponId(),
                request.scheduledDate(),
                request.scheduledTime(),
                request.totalAmount(),
                request.specialInstructions(),
                request.serviceId(),
                request.quantity(),
                request.unitPrice()
        );
    }

    // Full booking detail, read from v_booking_summary — one query
    // instead of manually joining 6 tables here in Java.
    public BookingResponseDto findById(int bookingId) {
        String sql = """
                SELECT * FROM v_booking_summary
                WHERE booking_id = ?
                """;
        List<BookingResponseDto> results = jdbcTemplate.query(sql, rowMapper, bookingId);
        return results.isEmpty() ? null : results.get(0);
    }

    // All bookings for a given customer, most recent first.
    public List<BookingResponseDto> findByCustomerId(int customerId) {
        String sql = """
                SELECT * FROM v_booking_summary
                WHERE customer_id = ?
                ORDER BY scheduled_date DESC
                """;
        return jdbcTemplate.query(sql, rowMapper, customerId);
    }
}
