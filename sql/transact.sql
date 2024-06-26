create schema if not exists otus_hw_1;
drop schema if exists public;

create sequence if not exists otus_hw_1.housing_complex_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.housing_complex(
                                                        id bigint primary key default nextval('otus_hw_1.housing_complex_seq'),
                                                        name varchar(25) not null,
                                                        description varchar(25)
);

create index if not exists housing_complex_name on otus_hw_1.housing_complex(name);

comment on table otus_hw_1.housing_complex is 'Компания застройщика';


create sequence if not exists otus_hw_1.house_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.house(
                                              id bigint primary key default nextval('otus_hw_1.house_seq'),
                                              house_no int8 not null,
                                              floor_cnt int8 not null,
                                              building_no int8,
                                              housing_complex_id bigint not null,
                                              fias_id uuid not null,
                                              address varchar(200) not null,
                                              foreign key (housing_complex_id) references otus_hw_1.housing_complex(id)
);

create index if not exists house_fias_id on otus_hw_1.house(fias_id);
create index if not exists house_address on otus_hw_1.house(address);

comment on table otus_hw_1.house is 'Здание и его описание';
comment on column otus_hw_1.house.fias_id is 'Уникальный номер ГАР (FIAS ID)';

create sequence if not exists otus_hw_1.object_type_catalog_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.object_type_catalog(
                                                            id bigint primary key default nextval('otus_hw_1.object_type_catalog_seq'),
                                                            name varchar(25) not null default 'unknown',
                                                            slug varchar(25) not null
);

comment on table otus_hw_1.object_type_catalog is 'Тип объекта(квартиа, апартаменты...)';

create sequence if not exists otus_hw_1.object_status_catalog_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.object_status_catalog(
                                                              id bigint primary key default nextval('otus_hw_1.object_status_catalog_seq'),
                                                              name varchar(25) not null default 'unknown',
                                                              slug varchar(25) not null
);

comment on table otus_hw_1.object_status_catalog is 'Статус объекта(продан, свободен...)';

create sequence if not exists otus_hw_1.hb_object_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.hb_object(
                                                  id bigint primary key default nextval('otus_hw_1.hb_object_seq'),
                                                  object_type_catalog_id bigint not null,
                                                  hb_object_no int8 not null,
                                                  object_status_catalog_id bigint not null,
                                                  floor_no int8 not null,
                                                  room_cnt int8,
                                                  object_area float8 not null,
                                                  coast int8 not null,
                                                  salary_date date,
                                                  house_id bigint not null,
                                                  foreign key (house_id) references otus_hw_1.house(id),
                                                  foreign key (object_type_catalog_id) references otus_hw_1.object_type_catalog(id),
                                                  foreign key (object_status_catalog_id) references otus_hw_1.object_status_catalog(id)
);

create index if not exists hb_object_area on otus_hw_1.hb_object(object_area);
create index if not exists hb_object_coast on otus_hw_1.hb_object(coast);

comment on table otus_hw_1.hb_object is 'Объект(квартира)';

create sequence if not exists otus_hw_1.object_space_type_catalog_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.object_space_type_catalog(
                                                                  id bigint primary key default nextval('otus_hw_1.object_space_type_catalog_seq'),
                                                                  name varchar(25) not null default 'unknown',
                                                                  slug varchar(25) not null
);

comment on table otus_hw_1.object_space_type_catalog is 'Тип пространства в объекте';
--
create sequence if not exists otus_hw_1.object_space_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.object_space(
                                                     id bigint primary key default nextval('otus_hw_1.object_space_seq'),
                                                     space_width float8 not null,
                                                     space_length float8 not null,
                                                     hb_object_id bigint not null,
                                                     object_space_type_catalog_id bigint not null,
                                                     foreign key (hb_object_id) references otus_hw_1.hb_object(id),
                                                     foreign key (object_space_type_catalog_id) references otus_hw_1.object_space_type_catalog(id)
);

comment on table otus_hw_1.object_space is 'Пространство в объекте';


create sequence if not exists otus_hw_1.identify_doc_type_catalog_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.identify_doc_type_catalog(
                                                                  id bigint primary key default nextval('otus_hw_1.identify_doc_type_catalog_seq'),
                                                                  name varchar(25) not null default 'unknown',
                                                                  slug varchar(25) not null
);

comment on table otus_hw_1.identify_doc_type_catalog is 'Тип документа удостоверяющего личность(паспорт, загран. паспорт...)';

create sequence if not exists otus_hw_1.buyer_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.buyer(
                                              id bigint primary key default nextval('otus_hw_1.buyer_seq'),
                                              first_name varchar(25) not null,
                                              middle_name varchar(25),
                                              last_name varchar(25) not null,
                                              identify_doc_type_catalog_id bigint not null,
                                              identify_doc_series varchar(25) not null,
                                              identify_doc_no varchar(25) not null,
                                              foreign key(identify_doc_type_catalog_id) references otus_hw_1.identify_doc_type_catalog(id)
);

create index if not exists buyer_last_name on otus_hw_1.buyer(last_name);
create index if not exists buyer_identify_full_num on otus_hw_1.buyer(identify_doc_series, identify_doc_no);


comment on table otus_hw_1.buyer is 'Покупатель';


create sequence if not exists otus_hw_1.buyer_hb_object_link_seq as bigint increment 1 start 1;

create table if not exists otus_hw_1.buyer_hb_object_link(
                                                             id bigint primary key default nextval('otus_hw_1.buyer_hb_object_link_seq'),
                                                             hb_object_id bigint not null,
                                                             buyer_id bigint not null,
                                                             foreign key (hb_object_id) references otus_hw_1.hb_object(id),
                                                             foreign key (buyer_id) references otus_hw_1.buyer(id)
);

comment on table otus_hw_1.buyer_hb_object_link is 'Таблица для связи Покупателя и Объекта';
