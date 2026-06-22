# UrbanServe — Professional Home Services Database

Home services marketplace — customers book verified providers for plumbing,
electrical, cleaning, AC repair, and similar services. PostgreSQL schema +
Spring Boot REST API.

Repo: [UrbanServe-ProfessionalHomeServices-DBMS](https://github.com/Anuj0725/UrbanServe-ProfessionalHomeServices-DBMS)

## Contents

- [Schema](#schema)
- [Structure](#structure)
- [Setup](#setup)
- [Database Features](#database-features)
- [REST API](docs/API.md)
- [Query Index](#query-index)
- [Sample Data](#sample-data)
- [Relational Schema](docs/relational_schema.pdf)
- [BCNF Proof](docs/bcnf_proof.md)
- [ER Diagram](docs/ER_Diagram.pdf)

---

## Schema

22 tables, 7 modules, BCNF.

| Module | Tables |
|---|---|
| Identity & Roles | `Users`, `Customer`, `ServiceProvider`, `Admin` |
| Location | `City`, `Area`, `Address` |
| Service Catalog | `Category`, `Service`, `ServiceVariant` |
| Provider Ops | `ProviderAvailability`, `ProviderDocument` |
| Booking Lifecycle | `Coupon`, `Booking`, `BookingItem`, `BookingStatusLog` |
| Transactions | `Payment`, `Cancellation` |
| Feedback | `ProviderReview`, `ServiceReview`, `Complaint` |

Notes:
- `Users` is shared login/role. `Customer`/`ServiceProvider`/`Admin` are
  separate profile tables, linked via `user_id`. Different ID sequence than
  `customer_id`/`provider_id` — matters for joins and RLS.
- `avg_rating` on `ServiceProvider` is stored, updated by trigger.
- `Booking.status` = current state. `BookingStatusLog` = full history.
- CHECK constraints on statuses, ratings, amounts — enforced at the DB.

---

## Structure

```
UrbanServe-ProfessionalHomeServices-DBMS/
├── schema/
│   ├── DDL.sql
│   ├── Indexes.sql
│   ├── views_triggers.sql
│   └── security.sql
├── data/Data.sql
├── queries/Queries.sql
├── docs/
│   ├── relational_schema.pdf
│   ├── bcnf_proof.md
│   ├── ER_Diagram.pdf
│   └── API.md
├── api/                  # Spring Boot, JdbcTemplate
└── README.md
```

---

## Setup

```bash
createdb your_db_name

psql -d your_db_name -f schema/DDL.sql
psql -d your_db_name -f data/Data.sql
psql -d your_db_name -f schema/Indexes.sql
psql -d your_db_name -f schema/views_triggers.sql
psql -d your_db_name -f schema/security.sql

psql -d your_db_name -c "REFRESH MATERIALIZED VIEW mv_provider_leaderboard;"
psql -d your_db_name -c "REFRESH MATERIALIZED VIEW mv_city_revenue_summary;"
```

Or run each file in pgAdmin's Query Tool, same order.

```sql
-- Dedicated app role instead of superuser
CREATE ROLE app_backend WITH LOGIN PASSWORD 'your_password' BYPASSRLS;
GRANT USAGE ON SCHEMA public TO app_backend;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_backend;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO app_backend;
```

**API:**
```bash
cd api
mvn spring-boot:run
```
`DB_PASSWORD` env var required. Runs on `localhost:8080`. Swagger at
`/swagger-ui.html`.

---

## Database Features

**Trigger** — `trg_update_provider_avg_rating`: fires on
INSERT/UPDATE/DELETE to `ProviderReview`, recalculates
`ServiceProvider.avg_rating`.

**Views**
| View | Purpose |
|---|---|
| `v_booking_summary` | Booking + customer + provider + location + payment, joined |
| `mv_provider_leaderboard` | Materialized — providers ranked by rating |
| `mv_city_revenue_summary` | Materialized — revenue/bookings per city |

**Stored procedure**
```sql
SELECT place_booking(
    customer_id, provider_id, address_id, coupon_id,
    scheduled_date, scheduled_time, total_amount,
    special_instructions, service_id, quantity, unit_price
);
```
Inserts Booking + BookingItem + BookingStatusLog as one transaction. Returns
`booking_id`.

**Row-Level Security** — enabled on `Users`, `Customer`, `ServiceProvider`,
`Booking`, `Payment`, `ProviderReview`, `Complaint`. Ownership policies — a
customer only sees their own bookings, a provider only theirs. Tables
without a direct `user_id` resolve ownership through a subquery
(`Booking` → `Customer`/`ServiceProvider`). Catalog tables (`City`,
`Service`, etc.) skip RLS — nothing to restrict there.

---

## REST API

5 of 22 entities exposed:

- `Service` — browse by city, search by keyword
- `Customer` — list, get by ID
- `ServiceProvider` — verified list, leaderboard
- `Booking` — create (`place_booking()`), get, list by customer
- `ProviderReview` — submit, get by provider

JdbcTemplate, no ORM. Full endpoints: [`docs/API.md`](docs/API.md).

Remaining 17 tables are schema-only — built and tested via the queries
below, no controller.

---

## Query Index

| # | Query | Concepts |
|---|---|---|
| 1 | Active customers — name, phone, email | JOIN, WHERE |
| 2 | Active services in a city | JOIN, ORDER BY |
| 3 | Services with variant pricing | Multi-table JOIN |
| 4 | Line items per booking with totals | JOIN, computed column |
| 5 | Price stats per category | GROUP BY, MIN/MAX/AVG |
| 6 | Keyword search on service name | ILIKE, OR |
| 7 | Booking counts by status | GROUP BY, COUNT |
| 8 | Status timeline for one booking | WHERE, ORDER BY |
| 9 | Cancelled bookings with refund info | JOIN |
| 10 | Bookings with no status log entry | LEFT JOIN, IS NULL |
| 11 | Successful payments with customer | JOIN, WHERE |
| 12 | Daily revenue | GROUP BY, SUM |
| 13 | Coupon usage counts | LEFT JOIN, COUNT |
| 14 | Provider reviews with reviewer name | Multi-table JOIN |
| 15 | Top 5 providers by rating | GROUP BY, AVG, LIMIT |

---

## Sample Data

| Table | Rows |
|---|---|
| Users | 30 (10 customers, 10 providers, 10 admins) |
| Customer / ServiceProvider / Admin | 10 / 10 / 10 |
| City / Area / Address | 10 / 10 / 10 |
| Category / Service / ServiceVariant | 10 / 10 / 10 |
| ProviderAvailability / ProviderDocument | 10 / 10 |
| Coupon | 10 |
| Booking | 20 (7 completed, 1 in-progress, 1 confirmed, 1 pending, 10 cancelled) |
| BookingItem / BookingStatusLog | 10 / 10 |
| Payment / Cancellation | 10 / 10 |
| ProviderReview / ServiceReview | 10 / 10 |
| Complaint | 10 |

---

## Normalization

Relational schema (table-by-table attributes and FKs) in
[`docs/relational_schema.pdf`](docs/relational_schema.pdf). All 22 tables in
BCNF — proof in [`docs/bcnf_proof.md`](docs/bcnf_proof.md).
