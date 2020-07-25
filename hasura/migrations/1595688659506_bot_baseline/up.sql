CREATE SCHEMA bot;
CREATE TABLE bot.superset_accounts (
    username character varying NOT NULL,
    password character varying NOT NULL
);
CREATE TABLE bot.favorites (
    favorite character varying NOT NULL,
    user_id character varying NOT NULL,
    message character varying
);
CREATE TABLE bot.users (
    id character varying NOT NULL,
    superset_account_username character varying
);
ALTER TABLE ONLY bot.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (favorite, user_id);
ALTER TABLE ONLY bot.superset_accounts
    ADD CONSTRAINT superset_accounts_pkey PRIMARY KEY (username);
ALTER TABLE ONLY bot.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY bot.users
    ADD CONSTRAINT users_superset_account_username_key UNIQUE (superset_account_username);
ALTER TABLE ONLY bot.favorites
    ADD CONSTRAINT favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES bot.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY bot.users
    ADD CONSTRAINT users_superset_account_username_fkey FOREIGN KEY (superset_account_username) REFERENCES bot.superset_accounts(username) ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE FUNCTION bot.get_free_superset_account() RETURNS SETOF bot.superset_accounts
    LANGUAGE sql STABLE
    AS $$
SELECT 
    bot.superset_accounts.username,
    bot.superset_accounts.password
FROM bot.superset_accounts
LEFT JOIN bot.users 
    on bot.superset_accounts.username = bot.users.superset_account_username
where bot.users.superset_account_username is null
limit 1
$$;
