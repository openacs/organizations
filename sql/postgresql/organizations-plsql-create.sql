-- packages/organization/sql/postgresql/organization-plsql.sql
--
-- @author Jon Griffin
-- @creation-date 24 February 2003
-- @cvs-id $Id$

-- What no comments?

create function inline_0 () 
returns integer as '  
begin 
    PERFORM acs_object_type__create_type (  
      ''organization'', -- object_type  
      ''Organization'', -- pretty_name 
      ''Organization'',  -- pretty_plural 
      ''party'',   -- supertype 
      ''organizations'',  -- table_name 
      ''organization_id'', -- id_column 
      ''organization'', -- package_name 
      ''f'', -- abstract_p 
      null, -- type_extension_table 
      null -- name_method 
  ); 
 
  return 0;  
end;' language 'plpgsql'; 

select inline_0 (); 

drop function inline_0 ();



------ start of oacs new proc
create or replace function organization__new ( varchar,varchar,text,integer,varchar, 
varchar,varchar,integer,varchar,integer )
returns integer as ' 
declare 
    p_legal_name         alias for $1; -- comment
    p_name               alias for $2; -- comment
    p_notes              alias for $3; -- comment
    p_organization_id    alias for $4; -- comment
    p_reg_number         alias for $5; -- comment
    p_email              alias for $6; -- email
    p_url                alias for $7;
    p_creation_user      alias for $8; -- comment
    p_creation_ip        alias for $9;
    p_context_id         alias for $10; -- comment

    -- local vars
    v_organization_id organizations.organization_id%TYPE; 
begin 
  v_organization_id := party__new (  
    null,              -- party_id
    ''organization'',
    now(), 
    p_creation_user,
    p_creation_ip,
    p_email, 
    p_url,
    p_context_id 
  );   
   

  insert into organizations (
    legal_name,
    name,
    notes,
    organization_id,
    reg_number 
  )  
  values ( 
    p_legal_name,
    p_name,
    p_notes,
    v_organization_id,
    p_reg_number 
  ); 

  PERFORM acs_permission__grant_permission (
     v_organization_id,
     p_creation_user,
     ''admin''
  );

   raise NOTICE ''Adding organization - %'',p_name;
  return v_organization_id;

end;' language 'plpgsql';

------ end new proc

create or replace function organization__del (integer) 
returns integer as ' 
declare 
 p_organization_id    alias for $1; 
 v_return integer := 0;  
begin 

   delete from acs_permissions 
     where object_id = p_organization_id; 

   delete from organizations 
     where organization_id = p_organization_id;

   raise NOTICE ''Deleting organization - %'',p_organization_id;

   PERFORM party_delete(p_organization_id);

   return v_return;

end;' language 'plpgsql';

create or replace function organization__set (varchar,varchar,text,integer,varchar)
returns integer as ' 
declare 
    p_legal_name         alias for $1; -- comment
    p_name               alias for $2; -- comment
    p_notes              alias for $3; -- comment
    p_organization_id    alias for $4; -- comment
    p_reg_number         alias for $5; -- comment

    v_return integer := 0; 
begin 

  update organizations
  set 
    legal_name = p_legal_name,
    name = p_name,
    notes = p_notes,
    organization_id = p_organization_id,
    reg_number = p_reg_number
  where organization_id = p_organization_id;

  raise NOTICE ''Updating  - organization - %'',organization_id;

return v_return;
end;' language 'plpgsql';