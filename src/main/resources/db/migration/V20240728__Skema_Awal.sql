CREATE TABLE invoice_type
(
    id VARCHAR(36),
    PRIMARY KEY (id)
);

CREATE TABLE payment_provider
(
    id   VARCHAR(36),
    code VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE payment_provider
    ADD CONSTRAINT payment_provider_unique_code UNIQUE (code);

CREATE TABLE invoice
(
    id VARCHAR(36),
    PRIMARY KEY (id)
);

CREATE TABLE virtual_account
(
    id VARCHAR(36),
    PRIMARY KEY (id)
);

CREATE TABLE payment
(
    id VARCHAR(36),
    PRIMARY KEY (id)
);