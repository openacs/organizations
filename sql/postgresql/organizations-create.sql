-- @cvs-id $Id$

create table organization_types (
    organization_type_id  serial
                          constraint company_types_pk
                              primary key, 
    type                  varchar (40)
                          constraint company_type_name_uq
                              unique
                          constraint company_type_name_nn
                              not null
);

comment on table organization_types is '
This is a lookup table displaying organization types.
';

comment on column organization_types.organization_type_id is '
Primary key.
';

comment on column organization_types.type is '
Pretty name.
';

-- add some data
insert into organization_types values (acs_object_id_seq.nextval,'Vendor');
insert into organization_types values (acs_object_id_seq.nextval,'Customer');
insert into organization_types values (acs_object_id_seq.nextval,'Prospect');
insert into organization_types values (acs_object_id_seq.nextval,'Misc.');

-- organization
-- this will be a party
-- probably should be it's own package

create table organizations (
    organization_id   integer
                      constraint organization_id_pk
                          primary key
                      constraint organization_id_fk
                          references parties(party_id),
    name              varchar(200)
                      constraint organization_name_nn
                          not null
                      constraint organization_name_uq
                          unique,
    -- usually the same as name
    legal_name        varchar(200),
    -- this can be ein/ssn/vat
    reg_number        varchar(100),
    notes             text
); 

create index organization_name_ix on organizations(name);
\i organizations-plsql-create.sql
