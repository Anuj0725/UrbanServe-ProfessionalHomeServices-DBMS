package com.anuj.UrbanServe.controller;

import com.anuj.UrbanServe.dto.CustomerDto;
import com.anuj.UrbanServe.repository.CustomerRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/customers")
public class CustomerController {

    private final CustomerRepository customerRepository;

    public CustomerController(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    // GET /api/customers
    @GetMapping
    public List<CustomerDto> getActiveCustomers() {
        return customerRepository.findActiveCustomers();
    }

    // GET /api/customers/3
    @GetMapping("/{id}")
    public ResponseEntity<CustomerDto> getCustomerById(@PathVariable("id") int customerId) {
        CustomerDto customer = customerRepository.findById(customerId);
        if (customer == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(customer);
    }
}
