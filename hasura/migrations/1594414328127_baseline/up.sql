CREATE SCHEMA application;
CREATE TABLE application.dashboards (
    element_id integer NOT NULL
);
CREATE TABLE application.elements (
    id integer NOT NULL,
    name character varying NOT NULL,
    last_update timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    user_id integer NOT NULL
);
CREATE TABLE application.elements_tags (
    tag_name character varying NOT NULL,
    element_id integer NOT NULL
);
CREATE TABLE application.favorites (
    user_id integer NOT NULL,
    element_id integer NOT NULL
);
CREATE TABLE application.interfaces (
    id integer NOT NULL,
    name character varying NOT NULL
);
CREATE TABLE application.likelib_columns (
    name character varying NOT NULL,
    type character varying,
    likelib_table_name character varying NOT NULL
);
CREATE TABLE application.likelib_tables (
    name character varying NOT NULL
);
CREATE TABLE application.queries (
    element_id integer NOT NULL,
    query character varying NOT NULL,
    result character varying
);
CREATE TABLE application.tags (
    name character varying NOT NULL
);
CREATE TABLE application.users (
    id integer NOT NULL,
    username character varying NOT NULL,
    name character varying,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying NOT NULL
);
CREATE TABLE application.users_elements (
    user_id integer NOT NULL,
    element_id integer NOT NULL
);
CREATE TABLE application.votes (
    user_id integer NOT NULL,
    element_id integer NOT NULL,
    mark integer NOT NULL
);
CREATE TABLE application.widgets (
    element_id integer NOT NULL,
    interface_id integer NOT NULL,
    query_id integer NOT NULL,
    size integer NOT NULL,
    refresh_rate integer
);
CREATE TABLE application.widgets_dashboards (
    dashboard_id integer NOT NULL,
    widget_id integer NOT NULL
);
ALTER TABLE ONLY application.dashboards
    ADD CONSTRAINT dashboards_pkey PRIMARY KEY (element_id);
ALTER TABLE ONLY application.elements
    ADD CONSTRAINT elements_pkey PRIMARY KEY (id);
ALTER TABLE ONLY application.elements_tags
    ADD CONSTRAINT elements_tags_pkey PRIMARY KEY (tag_name, element_id);
ALTER TABLE ONLY application.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (user_id, element_id);
ALTER TABLE ONLY application.interfaces
    ADD CONSTRAINT interfaces_name_key UNIQUE (name);
ALTER TABLE ONLY application.interfaces
    ADD CONSTRAINT interfaces_pkey PRIMARY KEY (id);
ALTER TABLE ONLY application.likelib_columns
    ADD CONSTRAINT likelib_columns_pkey PRIMARY KEY (likelib_table_name, name);
ALTER TABLE ONLY application.likelib_tables
    ADD CONSTRAINT likelib_tables_name_key UNIQUE (name);
ALTER TABLE ONLY application.likelib_tables
    ADD CONSTRAINT likelib_tables_pkey PRIMARY KEY (name);
ALTER TABLE ONLY application.queries
    ADD CONSTRAINT queries_pkey PRIMARY KEY (element_id);
ALTER TABLE ONLY application.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);
ALTER TABLE ONLY application.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (name);
ALTER TABLE ONLY application.users_elements
    ADD CONSTRAINT users_elements_pkey PRIMARY KEY (user_id, element_id);
ALTER TABLE ONLY application.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE ONLY application.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY application.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
ALTER TABLE ONLY application.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (user_id, element_id);
ALTER TABLE ONLY application.widgets_dashboards
    ADD CONSTRAINT widgets_dashboards_pkey PRIMARY KEY (dashboard_id, widget_id);
ALTER TABLE ONLY application.widgets
    ADD CONSTRAINT widgets_pkey PRIMARY KEY (element_id);
ALTER TABLE ONLY application.dashboards
    ADD CONSTRAINT dashboards_element_id_fkey FOREIGN KEY (element_id) REFERENCES application.elements(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.elements_tags
    ADD CONSTRAINT elements_tags_element_id_fkey FOREIGN KEY (element_id) REFERENCES application.elements(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.elements_tags
    ADD CONSTRAINT elements_tags_tag_name_fkey FOREIGN KEY (tag_name) REFERENCES application.tags(name) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.elements
    ADD CONSTRAINT elements_user_id_fkey FOREIGN KEY (user_id) REFERENCES application.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.favorites
    ADD CONSTRAINT favorites_element_id_fkey FOREIGN KEY (element_id) REFERENCES application.elements(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.favorites
    ADD CONSTRAINT favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES application.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.likelib_columns
    ADD CONSTRAINT likelib_columns_likelib_table_name_fkey FOREIGN KEY (likelib_table_name) REFERENCES application.likelib_tables(name) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.queries
    ADD CONSTRAINT queries_element_id_fkey FOREIGN KEY (element_id) REFERENCES application.elements(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.users_elements
    ADD CONSTRAINT users_elements_element_id_fkey FOREIGN KEY (element_id) REFERENCES application.elements(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.users_elements
    ADD CONSTRAINT users_elements_user_id_fkey FOREIGN KEY (user_id) REFERENCES application.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.votes
    ADD CONSTRAINT votes_element_id_fkey FOREIGN KEY (element_id) REFERENCES application.elements(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.votes
    ADD CONSTRAINT votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES application.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.widgets_dashboards
    ADD CONSTRAINT widgets_dashboards_dashboard_id_fkey FOREIGN KEY (dashboard_id) REFERENCES application.dashboards(element_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.widgets_dashboards
    ADD CONSTRAINT widgets_dashboards_widget_id_fkey FOREIGN KEY (widget_id) REFERENCES application.widgets(element_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.widgets
    ADD CONSTRAINT widgets_element_id_fkey FOREIGN KEY (element_id) REFERENCES application.elements(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.widgets
    ADD CONSTRAINT widgets_interface_id_fkey FOREIGN KEY (interface_id) REFERENCES application.interfaces(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY application.widgets
    ADD CONSTRAINT widgets_query_id_fkey FOREIGN KEY (query_id) REFERENCES application.queries(element_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
