CREATE TABLE invoice_type
(
    id VARCHAR(36),
    PRIMARY KEY (id)
);

CREATE TABLE payment_provider
(
    id VARCHAR(36),
    PRIMARY KEY (id)
);

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