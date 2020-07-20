CREATE SCHEMA likelib;

create table likelib.transaction_statuses (
    key                         int             not null,
    value                       varchar(255)    not null,
    primary key (key)
);

insert into likelib.transaction_statuses(key, value) values (0, 'Success');
insert into likelib.transaction_statuses(key, value) values (1, 'Pending');
insert into likelib.transaction_statuses(key, value) values (2, 'BadQueryForm');
insert into likelib.transaction_statuses(key, value) values (3, 'BadSign');
insert into likelib.transaction_statuses(key, value) values (4, 'NotEnoughBalance');
insert into likelib.transaction_statuses(key, value) values (5, 'Revert');
insert into likelib.transaction_statuses(key, value) values (6, 'Failed');

create table likelib.transaction_types (
    key                         int             not null,
    value                       varchar(255)    not null,
    primary key (key)
);

insert into likelib.transaction_types(key, value) values (0, 'None');
insert into likelib.transaction_types(key, value) values (1, 'Transfer');
insert into likelib.transaction_types(key, value) values (2, 'ContractCall');
insert into likelib.transaction_types(key, value) values (3, 'ContractCreation');



create table likelib.account_types (
    key                         int             not null,
    value                       varchar(255)    not null,
    primary key (key)
);

insert into likelib.account_types(key, value) values (0, 'Client');
insert into likelib.account_types(key, value) values (1, 'Contract');




create table likelib.blocks (
    number                      bigint          not null,
    hash                        varchar(255)    not null,
    hash_in_base64              varchar(255)    not null,
    timestamp                   timestamp,
    nonce                       int,
    prev_block_hash             varchar(255),
    prev_block_hash_in_base64   varchar(255),
    block_data_in_json          varchar(5000)   not null,
    primary key (number)
);

create table likelib.accounts (
    address                     varchar(255)    not null,
    address_in_base58           varchar(255)    not null,
    balance                     bigint,
    nonce                       int,
    type                        int,
    primary key (address),
    foreign key (type) references likelib.account_types(key)
);

create table likelib.transactions (
    hash                        varchar(255)    not null,
    hash_in_base64              varchar(255)    not null,
    timestamp                   timestamp,
    address_to                  varchar(255),
    address_to_in_base58        varchar(255),
    address_from                varchar(255),
    address_from_in_base58      varchar(255),
    data                        bytea,
    amount                      bigint,
    status                      int,
    sign                        varchar(500),
    sign_in_base64              varchar(500),
    fee                         bigint,
    block_height                bigint,
    type                        int,
    message                     varchar(500),
    message_in_base64           varchar(500),
    primary key (hash),
    foreign key (address_to) references likelib.accounts(address),
    foreign key (address_from) references likelib.accounts(address),
    foreign key (status) references likelib.transaction_statuses(key),
    foreign key (block_height) references likelib.blocks(number),
    foreign key (type) references likelib.transaction_types(key)
);

create index on likelib.blocks (number);
create index on likelib.blocks (hash);
create index on likelib.blocks (hash_in_base64);
create index on likelib.blocks (timestamp);
create index on likelib.blocks (nonce);
create index on likelib.blocks (prev_block_hash);
create index on likelib.blocks (prev_block_hash_in_base64);

create index on likelib.transactions (hash);
create index on likelib.transactions (hash_in_base64);
create index on likelib.transactions (timestamp);
create index on likelib.transactions (address_to);
create index on likelib.transactions (address_to_in_base58);
create index on likelib.transactions (address_from);
create index on likelib.transactions (address_from_in_base58);
create index on likelib.transactions (amount);
create index on likelib.transactions (status);
create index on likelib.transactions (fee);
create index on likelib.transactions (block_height);

create index on likelib.accounts (address);
create index on likelib.accounts (address_in_base58);
create index on likelib.accounts (balance);
create index on likelib.accounts (nonce);
create index on likelib.accounts (type);

