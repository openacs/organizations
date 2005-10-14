<?xml version="1.0"?>
<queryset>
  <fullquery name="orgs_query">
    <querytext>
	SELECT
	o.organization_id,
	o.name,
	o.legal_name,
	o.reg_number,
	o.notes,
	ot.type as organization_type
	FROM
	organizations o
        INNER JOIN acs_objects ob ON o.organization_id = ob.object_id
        LEFT JOIN organization_type_map tm ON o.organization_id = tm.organization_id
	INNER JOIN organization_types ot ON ot.organization_type_id = tm.organization_type_id
        WHERE
        ob.context_id           = :package_id and
	o.organization_id       = tm.organization_id and
	tm.organization_type_id = ot.organization_type_id
	[template::list::filter_where_clauses -and -name "orgs"]
        [template::list::orderby_clause -orderby -name orgs]
    </querytext>
  </fullquery>

  <fullquery name="select_org_types">
    <querytext>
	SELECT
	type as org_type,
	organization_type_id
	FROM
	organization_types
	ORDER BY
	org_type
    </querytext>
  </fullquery>
</queryset>

