-- ============================================================
-- 04_security.sql
-- Row-Level Security (RLS): restricts which ROWS a database role
-- can see/modify, on top of the GRANT/REVOKE permissions that
-- control which TABLES a role can access at all.
--
-- Context: this app's Spring Boot backend connects to Postgres
-- using one application-level role (e.g. a single DB user/password
-- in application.properties). That role normally sees every row
-- in every table once connected — RLS adds a second layer so that,
-- even if a query is written carelessly or a future feature lets
-- end users send raw filters, the database itself enforces who is
-- allowed to see whose data.
--
-- Run AFTER 01_ddl.sql, seed.sql, 02_indexes.sql, 03_views_triggers.sql.
-- ============================================================

-- ------------------------------------------------------------
-- STEP 1: Enable RLS on tables containing personal/sensitive data.
-- Enabling RLS with NO policies means "deny all rows" by default —
-- so step 2 (writing policies) is required, or no one will see
-- anything, including your own application.
-- ------------------------------------------------------------
ALTER TABLE Users           ENABLE ROW LEVEL SECURITY;
ALTER TABLE Customer        ENABLE ROW LEVEL SECURITY;
ALTER TABLE ServiceProvider ENABLE ROW LEVEL SECURITY;
ALTER TABLE Booking         ENABLE ROW LEVEL SECURITY;
ALTER TABLE Payment         ENABLE ROW LEVEL SECURITY;
ALTER TABLE ProviderReview  ENABLE ROW LEVEL SECURITY;
ALTER TABLE Complaint       ENABLE ROW LEVEL SECURITY;

-- ------------------------------------------------------------
-- STEP 2: Define application roles.
-- Two Postgres roles representing how the app will eventually
-- connect on behalf of different users: one for customers, one
-- for providers. Both roles can log in; the policies below decide
-- what rows each one is allowed to touch.
--
-- In a real deployment, your Spring Boot backend would SET the
-- current role (or a session variable identifying the logged-in
-- user) per request, so Postgres knows whose data is being asked
-- for. The app_user_id setting below simulates that.
-- ------------------------------------------------------------
CREATE ROLE app_customer LOGIN;
CREATE ROLE app_provider LOGIN;

-- A session-level setting the app sets per request, e.g.:
--   SET app.current_user_id = '5';
-- before running queries on behalf of customer/user with id 5.
-- Policies below read this setting to decide row visibility.

-- ------------------------------------------------------------
-- STEP 3: Policies — Users
-- A logged-in user can only see/update their own Users row.
-- ------------------------------------------------------------
CREATE POLICY users_self_select ON Users
    FOR SELECT
    USING (user_id = current_setting('app.current_user_id', true)::INT);

CREATE POLICY users_self_update ON Users
    FOR UPDATE
    USING (user_id = current_setting('app.current_user_id', true)::INT);

-- ------------------------------------------------------------
-- STEP 4: Policies — Customer
-- A customer can only see/update their own Customer row, matched
-- via the user_id link back to Users.
-- ------------------------------------------------------------
CREATE POLICY customer_self_select ON Customer
    FOR SELECT
    USING (user_id = current_setting('app.current_user_id', true)::INT);

CREATE POLICY customer_self_update ON Customer
    FOR UPDATE
    USING (user_id = current_setting('app.current_user_id', true)::INT);

-- ------------------------------------------------------------
-- STEP 5: Policies — ServiceProvider
-- Providers can see and update their own profile. Unlike Customer,
-- provider profiles are also meant to be publicly browsable
-- (customers need to see providers to book them), so SELECT is
-- open to everyone, but UPDATE is restricted to the owning provider.
-- ------------------------------------------------------------
CREATE POLICY provider_public_select ON ServiceProvider
    FOR SELECT
    USING (true);

CREATE POLICY provider_self_update ON ServiceProvider
    FOR UPDATE
    USING (user_id = current_setting('app.current_user_id', true)::INT);

-- ------------------------------------------------------------
-- STEP 6: Policies — Booking
-- A customer sees only bookings they made; a provider sees only
-- bookings assigned to them. Implemented as two separate policies
-- on the same table — Postgres combines multiple permissive
-- policies with OR, so a row is visible if EITHER condition matches.
-- ------------------------------------------------------------
CREATE POLICY booking_customer_select ON Booking
    FOR SELECT
    USING (
        customer_id = (
            SELECT customer_id FROM Customer
            WHERE user_id = current_setting('app.current_user_id', true)::INT
        )
    );

CREATE POLICY booking_provider_select ON Booking
    FOR SELECT
    USING (
        provider_id = (
            SELECT provider_id FROM ServiceProvider
            WHERE user_id = current_setting('app.current_user_id', true)::INT
        )
    );

-- ------------------------------------------------------------
-- STEP 7: Policies — Payment
-- Same ownership logic as Booking, but resolved through Booking
-- since Payment doesn't store customer_id/provider_id directly.
-- ------------------------------------------------------------
CREATE POLICY payment_customer_select ON Payment
    FOR SELECT
    USING (
        booking_id IN (
            SELECT booking_id FROM Booking
            WHERE customer_id = (
                SELECT customer_id FROM Customer
                WHERE user_id = current_setting('app.current_user_id', true)::INT
            )
        )
    );

-- ------------------------------------------------------------
-- STEP 8: Policies — ProviderReview
-- Reviews are public to read (customers browsing a provider need
-- to see their reviews), but only the customer who made the
-- underlying booking can insert a review for it.
-- ------------------------------------------------------------
CREATE POLICY review_public_select ON ProviderReview
    FOR SELECT
    USING (true);

CREATE POLICY review_customer_insert ON ProviderReview
    FOR INSERT
    WITH CHECK (
        booking_id IN (
            SELECT booking_id FROM Booking
            WHERE customer_id = (
                SELECT customer_id FROM Customer
                WHERE user_id = current_setting('app.current_user_id', true)::INT
            )
        )
    );

-- ------------------------------------------------------------
-- STEP 9: Policies — Complaint
-- A user can only see and file complaints under their own user_id.
-- ------------------------------------------------------------
CREATE POLICY complaint_self_select ON Complaint
    FOR SELECT
    USING (user_id = current_setting('app.current_user_id', true)::INT);

CREATE POLICY complaint_self_insert ON Complaint
    FOR INSERT
    WITH CHECK (user_id = current_setting('app.current_user_id', true)::INT);

-- ------------------------------------------------------------
-- NOTE on Admin / backend access:
-- The Spring Boot backend, when acting as a trusted system process
-- (e.g. running scheduled jobs, admin dashboards, or the
-- place_booking() procedure itself) should connect using a
-- separate Postgres role that owns these tables or has the
-- BYPASSRLS attribute, so legitimate backend operations are never
-- blocked by the same policies meant to restrict end-user requests.
-- Example:
--   CREATE ROLE app_backend LOGIN BYPASSRLS;
-- ------------------------------------------------------------
