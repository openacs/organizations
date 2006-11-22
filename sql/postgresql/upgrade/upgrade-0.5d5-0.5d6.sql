alter table organizations add column client_id varchar(100);
create index organization_cliend_idx on organizations(client_id);
