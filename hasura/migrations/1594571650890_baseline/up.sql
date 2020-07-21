CREATE SCHEMA likelib;
CREATE TABLE likelib.account_types (
    value character varying(255) NOT NULL
);
CREATE TABLE likelib.accounts (
    address character varying(255) NOT NULL,
    address_in_base58 character varying(255) NOT NULL,
    balance bigint,
    nonce integer,
    type character varying(255) NOT NULL
);
CREATE TABLE likelib.blocks (
    number bigint NOT NULL,
    hash character varying(255) NOT NULL,
    hash_in_base64 character varying(255) NOT NULL,
    "timestamp" timestamp without time zone,
    nonce integer,
    prev_block_hash character varying(255),
    prev_block_hash_in_base64 character varying(255),
    block_data_in_json character varying(5000) NOT NULL
);
CREATE TABLE likelib.transaction_statuses (
    value character varying(255) NOT NULL
);
CREATE TABLE likelib.transaction_types (
    value character varying(255) NOT NULL
);
CREATE TABLE likelib.transactions (
    hash character varying(255) NOT NULL,
    hash_in_base64 character varying(255) NOT NULL,
    "timestamp" timestamp without time zone,
    address_to character varying(255),
    address_to_in_base58 character varying(255),
    address_from character varying(255),
    address_from_in_base58 character varying(255),
    data bytea,
    amount bigint,
    sign character varying(500),
    sign_in_base64 character varying(500),
    fee bigint,
    block_height bigint,
    message character varying(500),
    message_in_base64 character varying(500),
    status character varying(255) NOT NULL,
    type character varying(255) NOT NULL
);
ALTER TABLE ONLY likelib.account_types
    ADD CONSTRAINT account_types_pkey PRIMARY KEY (value);
ALTER TABLE ONLY likelib.account_types
    ADD CONSTRAINT account_types_value_key UNIQUE (value);
ALTER TABLE ONLY likelib.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (address);
ALTER TABLE ONLY likelib.blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (number);
ALTER TABLE ONLY likelib.transaction_statuses
    ADD CONSTRAINT transaction_statuses_pkey PRIMARY KEY (value);
ALTER TABLE ONLY likelib.transaction_statuses
    ADD CONSTRAINT transaction_statuses_value_key UNIQUE (value);
ALTER TABLE ONLY likelib.transaction_types
    ADD CONSTRAINT transaction_types_pkey PRIMARY KEY (value);
ALTER TABLE ONLY likelib.transaction_types
    ADD CONSTRAINT transaction_types_value_key UNIQUE (value);
ALTER TABLE ONLY likelib.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (hash);
CREATE INDEX accounts_address_idx ON likelib.accounts USING btree (address);
CREATE INDEX accounts_address_in_base58_idx ON likelib.accounts USING btree (address_in_base58);
CREATE INDEX accounts_balance_idx ON likelib.accounts USING btree (balance);
CREATE INDEX accounts_nonce_idx ON likelib.accounts USING btree (nonce);
CREATE INDEX accounts_type_idx ON likelib.accounts USING btree (type);
CREATE INDEX blocks_hash_idx ON likelib.blocks USING btree (hash);
CREATE INDEX blocks_hash_in_base64_idx ON likelib.blocks USING btree (hash_in_base64);
CREATE INDEX blocks_nonce_idx ON likelib.blocks USING btree (nonce);
CREATE INDEX blocks_number_idx ON likelib.blocks USING btree (number);
CREATE INDEX blocks_prev_block_hash_idx ON likelib.blocks USING btree (prev_block_hash);
CREATE INDEX blocks_prev_block_hash_in_base64_idx ON likelib.blocks USING btree (prev_block_hash_in_base64);
CREATE INDEX blocks_timestamp_idx ON likelib.blocks USING btree ("timestamp");
CREATE INDEX transactions_address_from_idx ON likelib.transactions USING btree (address_from);
CREATE INDEX transactions_address_from_in_base58_idx ON likelib.transactions USING btree (address_from_in_base58);
CREATE INDEX transactions_address_to_idx ON likelib.transactions USING btree (address_to);
CREATE INDEX transactions_address_to_in_base58_idx ON likelib.transactions USING btree (address_to_in_base58);
CREATE INDEX transactions_amount_idx ON likelib.transactions USING btree (amount);
CREATE INDEX transactions_block_height_idx ON likelib.transactions USING btree (block_height);
CREATE INDEX transactions_fee_idx ON likelib.transactions USING btree (fee);
CREATE INDEX transactions_hash_idx ON likelib.transactions USING btree (hash);
CREATE INDEX transactions_hash_in_base64_idx ON likelib.transactions USING btree (hash_in_base64);
CREATE INDEX transactions_status_idx ON likelib.transactions USING btree (status);
CREATE INDEX transactions_timestamp_idx ON likelib.transactions USING btree ("timestamp");
CREATE INDEX transactions_type_idx ON likelib.transactions USING btree (type);
ALTER TABLE ONLY likelib.accounts
    ADD CONSTRAINT accounts_type_fkey FOREIGN KEY (type) REFERENCES likelib.account_types(value) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY likelib.transactions
    ADD CONSTRAINT transactions_address_from_fkey FOREIGN KEY (address_from) REFERENCES likelib.accounts(address);
ALTER TABLE ONLY likelib.transactions
    ADD CONSTRAINT transactions_address_to_fkey FOREIGN KEY (address_to) REFERENCES likelib.accounts(address);
ALTER TABLE ONLY likelib.transactions
    ADD CONSTRAINT transactions_status_fkey FOREIGN KEY (status) REFERENCES likelib.transaction_statuses(value) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY likelib.transactions
    ADD CONSTRAINT transactions_type_fkey FOREIGN KEY (type) REFERENCES likelib.transaction_types(value) ON UPDATE RESTRICT ON DELETE RESTRICT;
