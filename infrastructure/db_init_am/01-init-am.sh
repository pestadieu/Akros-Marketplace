#!/bin/bash
set -e
export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
  \connect $POSTGRES_DB $POSTGRES_USER
  BEGIN;

create table category
(
  category_id           serial,
  key                   varchar(50) not null,
  constraint category_pk primary key (category_id)
);


create table field_type_definition
(
  field_type_definition_id  integer not null,
  description               varchar(1000) not null,
  constraint field_type_definition_pk primary key (field_type_definition_id)
);


create table field
(
  field_id                  serial,
  field_type_definition_id  integer not null,
  category_id               integer not null,
  key                       varchar(50) not null,
  min_value                 integer,
  max_value                 integer,
  sort_number               integer not null,
  required                  boolean default false not null,
  searchable                boolean default false not null,
  request                   boolean default false not null,
  offer                     boolean default false not null,
  creation                  boolean default false not null,
  constraint field_pk primary key (field_id),
  constraint field_category_fk foreign key (category_id) references category(category_id),
  constraint field_field_type_definition_fk foreign key (field_type_definition_id) references field_type_definition(field_type_definition_id)
);


create table field_option
(
  field_option_id       serial,
  field_id              integer not null,
  key                   varchar(50) not null,
  sort_number           integer not null,
  constraint field_option_pk primary key (field_option_id),
  constraint field_option_field_fk foreign key (field_id) references field(field_id)
);


create table advertiser
(
  advertiser_id  serial,
  first_name     varchar(100) not null,
  last_name       varchar(100) not null,
  email          varchar(100) not null,
  phone_number   varchar(50) not null,
  constraint advertiser_pk primary key (advertiser_id)
);


create table topic
(
  topic_id              serial,
  advertiser_id         integer not null,
  category_id           integer not null,
  valid_from            date not null,
  valid_to              date not null,
  request_or_offer      varchar(6) check(request_or_offer in ('REQUEST', 'OFFER')) not null,
  constraint topic_pk primary key (topic_id),
  constraint topic_category_fk foreign key (category_id) references category(category_id),
  constraint topic_advertiser_fk foreign key (advertiser_id) references advertiser(advertiser_id)
);


create table topic_value
(
  topic_value_id        serial,
  topic_id              integer not null,
  category_id           integer not null,
  field_id              integer not null,
  value                 varchar(4000),
  constraint topic_value_pk primary key (topic_value_id),
  constraint topic_value_topic_fk foreign key (topic_id) references topic(topic_id),
  constraint topic_value_category_fk foreign key (category_id) references category(category_id),
  constraint topic_value_field_fk foreign key (field_id) references field(field_id)
);

create table address
(
  address_id     serial,
  region         varchar(100),
  street_name    varchar(100) not null,
  street_number  varchar(20) not null,
  postal_code    varchar(20) not null,
  city           varchar(100) not null,
  constraint address_pk primary key (address_id)
);

  
-- Field Type Definition

insert into field_type_definition values (1, 'Number');
insert into field_type_definition values (2, 'Text (single line)');
insert into field_type_definition values (3, 'Text (multi line)');
insert into field_type_definition values (4, 'Address');
insert into field_type_definition values (5, 'Select (single option)');
insert into field_type_definition values (6, 'Select (multi option)');
insert into field_type_definition values (7, 'Boolean');
insert into field_type_definition values (8, 'Email');
insert into field_type_definition values (9, 'Phone Number');
insert into field_type_definition values (10, 'Picture');
insert into field_type_definition values (11, 'Date');
insert into field_type_definition values (12, 'Price');
insert into field_type_definition values (13, 'Select counter');

-- categories
insert into category (key) values ('accomodation');
insert into category (key) values ('carShare');

-- Field
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (2, 1, 'title', 1, 100, 1, true, false, true, true, true);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (3, 1, 'description', 1, 1000, 2, true, false, true, true, true);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (11, 1, 'fromDate', null, null, 3, true, true, true, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (11, 1, 'toDate', null, null, 4, false, true, true, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (13, 1, 'rooms', 1, 10, 3, true, false, false, true, true);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (13, 1, 'fromRooms', 1, 10, 5, true, true, false, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (13, 1, 'toRooms', 1, 10, 6, true, true, false, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (12, 1, 'price', 1, 1000, 7, true, false, false, true, true);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (12, 1, 'fromPrice', 1, 1000, 7, true, true, false, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (12, 1, 'toPrice', 1, 1000, 8, true, true, false, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (1, 1, 'size', 1, 1000, 8, true, false, false, true, true);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (1, 1, 'fromSize', 1, 1000, 9, true, true, false, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (1, 1, 'toSize', 1, 1000, 10, true, true, false, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (5, 1, 'type', null, null, 1, true, true, true, true, true);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (2, 1, 'region', 1, 100, 2, true, true, true, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (3, 1, 'address', 1, 100, 3, true, false, true, true, true);

insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (5, 2, 'fromRegion', 1, 100, 1, true, true, true, true, false);
insert into field (field_type_definition_id, category_id, key, min_value, max_value, sort_number, required, searchable, request, offer, creation) values (5, 2, 'toRegion', 2, 100, 1, true, true, true, true, false);

-- Field Option
insert into field_option (field_id, key, sort_number) values (14, 'room', 1);
insert into field_option (field_id, key, sort_number) values (14, 'apartment', 2);
insert into field_option (field_id, key, sort_number) values (14, 'house', 3);
insert into field_option (field_id, key, sort_number) values (14, 'parking', 4);

-- Advertiser
insert into advertiser (first_name, last_name, email, phone_number) values ('J', 'R', 'j.r@world.com', '0123456789' );
  
  COMMIT;
EOSQL