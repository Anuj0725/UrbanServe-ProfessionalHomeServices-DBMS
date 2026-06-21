package com.anuj.UrbanServe.controller;

import com.anuj.UrbanServe.dto.BookingRequestDto;
import com.anuj.UrbanServe.dto.BookingResponseDto;
import com.anuj.UrbanServe.repository.BookingRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/bookings")
public class BookingController {

    private final BookingRepository bookingRepository;

    public BookingController(BookingRepository bookingRepository) {
        this.bookingRepository = bookingRepository;
    }

    // POST /api/bookings
    // Body: a BookingRequestDto as JSON.
    @PostMapping
    public ResponseEntity<?> createBooking(@RequestBody BookingRequestDto request) {
        try {
            Integer newBookingId = bookingRepository.placeBooking(request);
            BookingResponseDto created = bookingRepository.findById(newBookingId);
            return new ResponseEntity<>(created, HttpStatus.CREATED);
        } catch (Exception e) {
            // A CHECK constraint or FK violation from the database surfaces
            // here — return it as a 400 rather than crashing with a 500.
            return ResponseEntity.badRequest()
                    .body(Map.of("error", "Could not create booking: " + e.getMessage()));
        }
    }

    // GET /api/bookings/7
    @GetMapping("/{id}")
    public ResponseEntity<BookingResponseDto> getBookingById(@PathVariable("id") int bookingId) {
        BookingResponseDto booking = bookingRepository.findById(bookingId);
        if (booking == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(booking);
    }

    // GET /api/bookings/customer/3
    @GetMapping("/customer/{customerId}")
    public List<BookingResponseDto> getBookingsByCustomer(@PathVariable int customerId) {
        return bookingRepository.findByCustomerId(customerId);
    }
}
