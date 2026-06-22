# API Reference

Base URL: `http://localhost:8080`

Interactive docs (Swagger UI): `/swagger-ui.html`

---

## Service

### `GET /api/services`
Active services in a city, cheapest first.

**Query params:** `cityId` (int, required)

**Response 200:**
```json
[
  {
    "serviceId": 1,
    "cityId": 1,
    "categoryId": 1,
    "serviceName": "Bathroom Cleaning",
    "description": "Deep bathroom cleaning with disinfection",
    "basePrice": 499.0,
    "duration": 60,
    "isActive": true
  }
]
```

### `GET /api/services/{id}`
Single service by ID.

**Response:** `200` with the service, or `404` if not found.

### `GET /api/services/search`
Keyword search on service name.

**Query params:** `keyword` (string, required)

**Response:** `200` with matches, or `404` if none found.

---

## Customer

### `GET /api/customers`
All active customers, joined with their `Users` email/status.

**Response 200:**
```json
[
  {
    "customerId": 1,
    "userId": 1,
    "name": "Rahul Sharma",
    "phone": "9000000001",
    "email": "cust1@gmail.com",
    "userStatus": "Active"
  }
]
```

### `GET /api/customers/{id}`
Single customer by ID.

**Response:** `200` with the customer, or `404` if not found.

---

## ServiceProvider

### `GET /api/providers`
Verified providers, highest rated first.

**Response 200:**
```json
[
  {
    "providerId": 10,
    "userId": 20,
    "experienceYears": 3,
    "bio": "Furniture Repair expert",
    "avgRating": 5.0,
    "verificationStatus": "Verified",
    "email": "prov10@gmail.com"
  }
]
```

### `GET /api/providers/{id}`
Single provider by ID.

**Response:** `200` with the provider, or `404` if not found.

### `GET /api/providers/leaderboard`
Top providers by rating, read from `mv_provider_leaderboard`.

**Query params:** `limit` (int, optional, default `5`)

---

## Booking

### `POST /api/bookings`
Creates a booking. Calls the `place_booking()` stored procedure —
inserts `Booking`, `BookingItem`, and `BookingStatusLog` as one transaction.

**Request body:**
```json
{
  "customerId": 1,
  "providerId": 2,
  "addressId": 3,
  "couponId": null,
  "scheduledDate": "2026-07-01",
  "scheduledTime": "10:00:00",
  "totalAmount": 599,
  "specialInstructions": "Test booking",
  "serviceId": 5,
  "quantity": 1,
  "unitPrice": 699
}
```

**Response 201:** full booking detail (from `v_booking_summary`), same
shape as `GET /api/bookings/{id}` below.

**Response 400:** if a constraint is violated (invalid FK, negative amount,
etc.) — returns the database error message.

### `GET /api/bookings/{id}`
Full booking detail, read from `v_booking_summary`.

**Response 200:**
```json
{
  "bookingId": 1,
  "bookingStatus": "Completed",
  "scheduledDate": "2026-04-01",
  "scheduledTime": "10:00:00",
  "totalAmount": 450.0,
  "customerId": 1,
  "customerName": "Rahul Sharma",
  "providerId": 1,
  "providerBio": "Electrician expert",
  "providerRating": 4.1,
  "cityName": "Ahmedabad",
  "areaName": "Gota",
  "pincode": "382481",
  "couponCode": "SAVE10",
  "discountValue": 10.0,
  "paymentMethod": "UPI",
  "paymentStatus": "Paid"
}
```

**Response:** `404` if not found.

### `GET /api/bookings/customer/{customerId}`
All bookings for a customer, most recent first.

---

## ProviderReview

### `POST /api/reviews`
Submits a review. Triggers `trg_update_provider_avg_rating`, which
recalculates the provider's `avg_rating` automatically.

**Request body:**
```json
{
  "providerId": 1,
  "bookingId": 1,
  "rating": 4.5,
  "comment": "Good work, very professional"
}
```

**Response 201:** the created review (see `GET /api/reviews/{id}` below).

**Response 400:** if a constraint is violated.

### `GET /api/reviews/{id}`
Single review by ID, with reviewer name and provider bio joined in.

**Response 200:**
```json
{
  "reviewId": 1,
  "providerId": 1,
  "providerBio": "Electrician expert",
  "bookingId": 1,
  "reviewerName": "Rahul Sharma",
  "rating": 4.1,
  "comment": "Good work, very professional",
  "createdAt": "2026-04-01T10:00:00"
}
```

**Response:** `404` if not found.

### `GET /api/reviews/provider/{providerId}`
All reviews for a provider, most recent first.

---

The remaining 17 tables (`Admin`, `City`, `Area`, `Address`, `Category`,
`ServiceVariant`, `ProviderAvailability`, `ProviderDocument`, `Coupon`,
`BookingItem`, `BookingStatusLog`, `Payment`, `Cancellation`,
`ServiceReview`, `Complaint`) don't have controllers. They're built,
constrained, and exercised by `queries/Queries.sql`, but aren't exposed
over REST.
