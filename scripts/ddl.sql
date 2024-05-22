CREATE TABLE users
(
    user_id         SERIAL PRIMARY KEY,
    name            VARCHAR(100),
    email           VARCHAR(100) UNIQUE NOT NULL,
    password_hash   VARCHAR(255)        NOT NULL,
    phone_number    VARCHAR(20),
    address         TEXT,
    profile_picture TEXT,
    role            VARCHAR(50) CHECK (role IN ('Customer', 'ServiceProvider')),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE service_providers
(
    service_provider_id SERIAL PRIMARY KEY,
    user_id             INT REFERENCES users (user_id),
    service_type        VARCHAR(100),
    experience          INT,
    certifications      TEXT,
    hourly_rate         NUMERIC(10, 2),
    availability JSONB,
    service_area        TEXT,
    ratings             NUMERIC(3, 2),
    reviews             JSONB,
    verified            BOOLEAN   DEFAULT FALSE,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers
(
    customer_id SERIAL PRIMARY KEY,
    user_id     INT REFERENCES users (user_id),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE services
(
    service_id          SERIAL PRIMARY KEY,
    service_provider_id INT REFERENCES service_providers (service_provider_id),
    service_name        VARCHAR(100),
    description         TEXT,
    category            VARCHAR(100),
    duration            INTERVAL default null,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE bookings
(
    booking_id          SERIAL PRIMARY KEY,
    customer_id         INT REFERENCES customers (customer_id),
    service_id          INT REFERENCES services (service_id),
    service_provider_id INT REFERENCES service_providers (service_provider_id),
    booking_date        TIMESTAMP,
    status              VARCHAR(50) CHECK (status IN ('Pending', 'Confirmed', 'Completed', 'Cancelled')),
    total_cost          NUMERIC(10, 2),
    payment_status      VARCHAR(50) CHECK (payment_status IN ('Paid', 'Unpaid')),
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reviews
(
    review_id           SERIAL PRIMARY KEY,
    customer_id         INT REFERENCES customers (customer_id),
    service_provider_id INT REFERENCES service_providers (service_provider_id),
    rating              NUMERIC(3, 2),
    comments            TEXT,
    review_date         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments
(
    payment_id     SERIAL PRIMARY KEY,
    booking_id     INT REFERENCES bookings (booking_id),
    payment_date   TIMESTAMP,
    amount         NUMERIC(10, 2),
    payment_method VARCHAR(50),
    transaction_id VARCHAR(100),
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notifications
(
    notification_id SERIAL PRIMARY KEY,
    user_id         INT REFERENCES users (user_id),
    message         TEXT,
    type            VARCHAR(50),
    sent_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_status     BOOLEAN   DEFAULT FALSE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE messages
(
    message_id  SERIAL PRIMARY KEY,
    sender_id   INT REFERENCES users (user_id),
    receiver_id INT REFERENCES users (user_id),
    content     TEXT,
    sent_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_status BOOLEAN   DEFAULT FALSE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

