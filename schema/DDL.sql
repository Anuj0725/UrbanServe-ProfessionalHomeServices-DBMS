CREATE TABLE Users (
    user_id     INT PRIMARY KEY,
    email       VARCHAR(100) UNIQUE NOT NULL,
    password    VARCHAR(100) NOT NULL,
    role        VARCHAR(20)  NOT NULL CHECK (role IN ('Customer', 'Provider', 'Admin')),
    status      VARCHAR(20)  NOT NULL DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive', 'Suspended')),
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    user_id     INT UNIQUE NOT NULL,
    name        VARCHAR(100) NOT NULL,
    phone       VARCHAR(15) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE ServiceProvider (
    provider_id          INT PRIMARY KEY,
    user_id              INT UNIQUE NOT NULL,
    experience_years     INT NOT NULL CHECK (experience_years >= 0),
    bio                  TEXT,
    avg_rating           FLOAT NOT NULL DEFAULT 0.0 CHECK (avg_rating >= 0.0 AND avg_rating <= 5.0),
    verification_status  VARCHAR(50) NOT NULL DEFAULT 'Pending' CHECK (verification_status IN ('Pending', 'Verified', 'Rejected')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Admin (
    admin_id    INT PRIMARY KEY,
    user_id     INT UNIQUE NOT NULL,
    admin_role  VARCHAR(50) NOT NULL,
    permissions TEXT,
    department  VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE City (
    city_id   INT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    state     VARCHAR(100) NOT NULL,
    status    VARCHAR(20)  NOT NULL DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive'))
);

CREATE TABLE Area (
    area_id   INT PRIMARY KEY,
    city_id   INT NOT NULL,
    area_name VARCHAR(100) NOT NULL,
    pincode   VARCHAR(10)  NOT NULL,
    status    VARCHAR(20)  NOT NULL DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive')),
    FOREIGN KEY (city_id) REFERENCES City(city_id)
);

CREATE TABLE Address (
    address_id INT PRIMARY KEY,
    area_id    INT NOT NULL,
    street     VARCHAR(255) NOT NULL,
    landmark   VARCHAR(255),
    label      VARCHAR(50),
    latitude   FLOAT,
    longitude  FLOAT,
    FOREIGN KEY (area_id) REFERENCES Area(area_id)
);

CREATE TABLE Category (
    category_id   INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description   TEXT
);

CREATE TABLE Service (
    service_id   INT PRIMARY KEY,
    city_id      INT NOT NULL,
    category_id  INT NOT NULL,
    service_name VARCHAR(100) NOT NULL,
    description  TEXT,
    base_price   FLOAT NOT NULL CHECK (base_price >= 0),
    duration     INT NOT NULL CHECK (duration > 0),
    is_active    BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (city_id) REFERENCES City(city_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE ServiceVariant (
    variant_id   INT PRIMARY KEY,
    service_id   INT NOT NULL,
    variant_name VARCHAR(100) NOT NULL,
    price        FLOAT NOT NULL CHECK (price >= 0),
    duration     INT NOT NULL CHECK (duration > 0),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

CREATE TABLE ProviderAvailability (
    availability_id INT PRIMARY KEY,
    provider_id     INT NOT NULL,
    day_of_week     VARCHAR(20) NOT NULL CHECK (day_of_week IN
                        ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')),
    start_time      TIME NOT NULL,
    end_time        TIME NOT NULL,
    FOREIGN KEY (provider_id) REFERENCES ServiceProvider(provider_id),
    CHECK (end_time > start_time)
);

CREATE TABLE ProviderDocument (
    document_id          INT PRIMARY KEY,
    provider_id          INT NOT NULL,
    document_type        VARCHAR(50) NOT NULL,
    description          TEXT,
    file_url             TEXT NOT NULL,
    verification_status  VARCHAR(50) NOT NULL DEFAULT 'Pending' CHECK (verification_status IN ('Pending', 'Verified', 'Rejected')),
    uploaded_at           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (provider_id) REFERENCES ServiceProvider(provider_id)
);

CREATE TABLE Coupon (
    coupon_id      INT PRIMARY KEY,
    code           VARCHAR(50) UNIQUE NOT NULL,
    discount_type  VARCHAR(50) NOT NULL CHECK (discount_type IN ('Flat', 'Percent')),
    min_order      FLOAT NOT NULL CHECK (min_order >= 0),
    discount_value FLOAT NOT NULL CHECK (discount_value >= 0),
    usage_limit    INT NOT NULL CHECK (usage_limit >= 0),
    valid_from     DATE NOT NULL,
    valid_to       DATE NOT NULL,
    CHECK (valid_to >= valid_from)
);

CREATE TABLE Booking (
    booking_id            INT PRIMARY KEY,
    customer_id           INT NOT NULL,
    provider_id           INT NOT NULL,
    address_id            INT NOT NULL,
    coupon_id             INT,
    scheduled_date        DATE NOT NULL,
    scheduled_time        TIME NOT NULL,
    total_amount          FLOAT NOT NULL CHECK (total_amount >= 0),
    status                VARCHAR(20) NOT NULL DEFAULT 'Pending'
                              CHECK (status IN ('Pending','Confirmed','In-Progress','Completed','Cancelled')),
    special_instructions  TEXT,
    created_at            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (provider_id) REFERENCES ServiceProvider(provider_id),
    FOREIGN KEY (address_id) REFERENCES Address(address_id),
    FOREIGN KEY (coupon_id) REFERENCES Coupon(coupon_id)
);

CREATE TABLE BookingItem (
    booking_id   INT,
    item_no      INT,
    service_id   INT NOT NULL,
    quantity     INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    unit_price   FLOAT NOT NULL CHECK (unit_price >= 0),
    custom_price FLOAT CHECK (custom_price >= 0),
    PRIMARY KEY (booking_id, item_no),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

CREATE TABLE BookingStatusLog (
    log_id     INT PRIMARY KEY,
    booking_id INT NOT NULL,
    status     VARCHAR(50) NOT NULL CHECK (status IN ('Pending','Confirmed','In-Progress','Completed','Cancelled')),
    remarks    TEXT,
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Payment (
    payment_id     INT PRIMARY KEY,
    booking_id     INT UNIQUE NOT NULL,
    payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN ('UPI', 'Card', 'Cash')),
    amount         FLOAT NOT NULL CHECK (amount >= 0),
    gateway_ref    VARCHAR(100),
    status         VARCHAR(50) NOT NULL DEFAULT 'Pending' CHECK (status IN ('Paid', 'Pending', 'Failed', 'Refunded')),
    paid_at        TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Cancellation (
    cancel_id     INT PRIMARY KEY,
    booking_id    INT UNIQUE NOT NULL,
    reason        TEXT NOT NULL,
    refund_amount FLOAT NOT NULL DEFAULT 0 CHECK (refund_amount >= 0),
    refund_status VARCHAR(50) NOT NULL DEFAULT 'Pending' CHECK (refund_status IN ('Refunded', 'Pending', 'Rejected')),
    cancelled_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE ProviderReview (
    review_id   INT PRIMARY KEY,
    provider_id INT NOT NULL,
    booking_id  INT NOT NULL,
    rating      FLOAT NOT NULL CHECK (rating >= 0.0 AND rating <= 5.0),
    comment     TEXT,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (provider_id) REFERENCES ServiceProvider(provider_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE ServiceReview (
    review_id  INT PRIMARY KEY,
    service_id INT NOT NULL,
    booking_id INT NOT NULL,
    rating     FLOAT NOT NULL CHECK (rating >= 0.0 AND rating <= 5.0),
    comment    TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (service_id) REFERENCES Service(service_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Complaint (
    complaint_id     INT PRIMARY KEY,
    user_id          INT NOT NULL,
    subject          VARCHAR(100) NOT NULL,
    description      TEXT NOT NULL,
    priority         VARCHAR(20) NOT NULL DEFAULT 'Medium' CHECK (priority IN ('Low', 'Medium', 'High')),
    status           VARCHAR(20) NOT NULL DEFAULT 'Open' CHECK (status IN ('Open', 'Closed', 'Under Review')),
    resolution_notes TEXT,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
