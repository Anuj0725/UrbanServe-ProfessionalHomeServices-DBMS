package com.anuj.UrbanServe.controller;

import com.anuj.UrbanServe.dto.ProviderReviewRequestDto;
import com.anuj.UrbanServe.dto.ProviderReviewResponseDto;
import com.anuj.UrbanServe.repository.ProviderReviewRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/reviews")
public class ProviderReviewController {

    private final ProviderReviewRepository reviewRepository;

    public ProviderReviewController(ProviderReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    // POST /api/reviews
    @PostMapping
    public ResponseEntity<?> addReview(@RequestBody ProviderReviewRequestDto request) {
        try {
            Integer newReviewId = reviewRepository.addReview(request);
            ProviderReviewResponseDto created = reviewRepository.findById(newReviewId);
            return ResponseEntity.status(201).body(created);
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(Map.of("error", "Could not add review: " + e.getMessage()));
        }
    }

    // GET /api/reviews/4
    @GetMapping("/{id}")
    public ResponseEntity<ProviderReviewResponseDto> getReviewById(@PathVariable("id") int reviewId) {
        ProviderReviewResponseDto review = reviewRepository.findById(reviewId);
        if (review == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(review);
    }

    // GET /api/reviews/provider/3
    @GetMapping("/provider/{providerId}")
    public List<ProviderReviewResponseDto> getReviewsByProvider(@PathVariable int providerId) {
        return reviewRepository.findByProviderId(providerId);
    }
}
