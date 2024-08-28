CREATE TABLE invoice_type
(
    id character varying(255) NOT NULL,
    created_by character varying(255),
    created_date timestamp(6) without time zone,
    status_record character varying(255) NOT NULL,
    updated_by character varying(255),
    updated_date timestamp(6) without time zone,
    code character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT invoice_type_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);

ALTER TABLE ONLY invoice_type
    ADD CONSTRAINT invoice_type_pkey PRIMARY KEY (id);

CREATE TABLE payment_provider
(
    id character varying(255) NOT NULL,
    code character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_by character varying(255),
    created_date timestamp(6) without time zone,
    status_record character varying(255) NOT NULL,
    updated_by character varying(255),
    updated_date timestamp(6) without time zone,
    logo character varying(255),
    CONSTRAINT payment_provider_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);

ALTER TABLE ONLY payment_provider
    ADD CONSTRAINT payment_provider_pkey PRIMARY KEY (id);

ALTER TABLE payment_provider
    ADD CONSTRAINT payment_provider_unique_code UNIQUE (code);


CREATE TABLE invoice_type_provider (
    id_invoice_type character varying(36) NOT NULL,
    id_payment_provider character varying(36) NOT NULL
);

ALTER TABLE ONLY invoice_type_provider
    ADD CONSTRAINT invoice_type_provider_pkey PRIMARY KEY (id_invoice_type, id_payment_provider);

ALTER TABLE ONLY invoice_type_provider
    ADD CONSTRAINT fk_invoice_type_provider_type FOREIGN KEY (id_invoice_type) REFERENCES invoice_type(id);

ALTER TABLE ONLY invoice_type_provider
    ADD CONSTRAINT fk_invoice_type_provider_provider FOREIGN KEY (id_payment_provider) REFERENCES payment_provider(id);

CREATE TABLE invoice
(
    id character varying(255) NOT NULL,
    created_by character varying(255),
    created_date timestamp(6) without time zone,
    status_record character varying(255) NOT NULL,
    updated_by character varying(255),
    updated_date timestamp(6) without time zone,
    amount numeric(38,2) NOT NULL,
    description character varying(255) NOT NULL,
    due_date date NOT NULL,
    invoice_number character varying(100) NOT NULL,
    paid boolean NOT NULL,
    id_invoice_type character varying(255) NOT NULL,
    CONSTRAINT invoice_amount_check CHECK ((amount >= (0)::numeric)),
    CONSTRAINT invoice_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);

ALTER TABLE ONLY invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id);

ALTER TABLE ONLY invoice
    ADD CONSTRAINT fkco4sbxv9cj2oevm6cdpq76ffb FOREIGN KEY (id_invoice_type) REFERENCES invoice_type(id);


CREATE TABLE virtual_account
(
    id character varying(255) NOT NULL,
    created_by character varying(255),
    created_date timestamp(6) without time zone,
    status_record character varying(255) NOT NULL,
    updated_by character varying(255),
    updated_date timestamp(6) without time zone,
    account_number character varying(255) NOT NULL,
    company_id character varying(255) NOT NULL,
    id_invoice character varying(255) NOT NULL,
    id_payment_provider character varying(255) NOT NULL,
    CONSTRAINT virtual_account_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[])))
);

ALTER TABLE ONLY virtual_account
    ADD CONSTRAINT virtual_account_pkey PRIMARY KEY (id);

ALTER TABLE ONLY virtual_account
    ADD CONSTRAINT fkt3t7f64hvgk4xjblsovqqkpll FOREIGN KEY (id_payment_provider) REFERENCES payment_provider(id);

ALTER TABLE ONLY virtual_account
    ADD CONSTRAINT fkbbdwdxpgdisiikyyhf2xteblc FOREIGN KEY (id_invoice) REFERENCES invoice(id);

CREATE TABLE payment
(
    id character varying(255) NOT NULL,
    created_by character varying(255),
    created_date timestamp(6) without time zone,
    status_record character varying(255) NOT NULL,
    updated_by character varying(255),
    updated_date timestamp(6) without time zone,
    amount numeric(38,2) NOT NULL,
    provider_reference character varying(255) NOT NULL,
    transaction_time timestamp(6) without time zone NOT NULL,
    virtual_account_type character varying(255) NOT NULL,
    id_virtual_account character varying(255) NOT NULL,
    CONSTRAINT payment_amount_check CHECK ((amount >= (1)::numeric)),
    CONSTRAINT payment_status_record_check CHECK (((status_record)::text = ANY ((ARRAY['ACTIVE'::character varying, 'INACTIVE'::character varying])::text[]))),
    CONSTRAINT payment_virtual_account_type_check CHECK (((virtual_account_type)::text = ANY ((ARRAY['CLOSED'::character varying, 'OPEN'::character varying, 'INSTALLMENT'::character varying])::text[])))
);

ALTER TABLE ONLY payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);

ALTER TABLE ONLY payment
    ADD CONSTRAINT fkptriq88d7e8io9mhri8p10cq0 FOREIGN KEY (id_virtual_account) REFERENCES public.virtual_account(id);