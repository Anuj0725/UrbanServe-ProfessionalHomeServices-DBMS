package com.anuj.UrbanServe.controller;

import com.anuj.UrbanServe.dto.ServiceProviderDto;
import com.anuj.UrbanServe.repository.ServiceProviderRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/providers")
public class ServiceProviderController {

    private final ServiceProviderRepository providerRepository;

    public ServiceProviderController(ServiceProviderRepository providerRepository) {
        this.providerRepository = providerRepository;
    }

    // GET /api/providers
    @GetMapping
    public List<ServiceProviderDto> getVerifiedProviders() {
        return providerRepository.findVerifiedProviders();
    }

    // GET /api/providers/3
    @GetMapping("/{id}")
    public ResponseEntity<ServiceProviderDto> getProviderById(@PathVariable("id") int providerId) {
        ServiceProviderDto provider = providerRepository.findById(providerId);
        if (provider == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(provider);
    }

    // GET /api/providers/leaderboard?limit=5
    @GetMapping("/leaderboard")
    public List<ServiceProviderDto> getTopProviders(@RequestParam(defaultValue = "5") int limit) {
        return providerRepository.findTopProviders(limit);
    }
}
