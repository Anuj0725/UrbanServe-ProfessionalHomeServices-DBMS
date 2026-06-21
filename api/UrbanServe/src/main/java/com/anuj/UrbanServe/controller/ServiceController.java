package com.anuj.UrbanServe.controller;

import com.anuj.UrbanServe.dto.ServiceDto;
import com.anuj.UrbanServe.repository.ServiceRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/services")
public class ServiceController {

    private final ServiceRepository serviceRepository;

    // Constructor injection — Spring hands us the same ServiceRepository
    // bean it created earlier.
    public ServiceController(ServiceRepository serviceRepository) {
        this.serviceRepository = serviceRepository;
    }

    // GET /api/services?cityId=1
    @GetMapping
    public List<ServiceDto> getActiveServicesByCity(@RequestParam int cityId) {
        return serviceRepository.findActiveServicesByCity(cityId);
    }

    // GET /api/services/5
    @GetMapping("/{id}")
    public ResponseEntity<ServiceDto> getServiceById(@PathVariable("id") int serviceId) {
        ServiceDto service = serviceRepository.findById(serviceId);
        if (service == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(service);
    }

    // GET /api/services/search?keyword=repair
    @GetMapping("/search")
    public ResponseEntity<List<ServiceDto>> searchServices(@RequestParam String keyword) {
        List<ServiceDto> results = serviceRepository.searchByKeyword(keyword);
        if (results.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(results);
    }
}