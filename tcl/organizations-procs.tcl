# 

ad_library {
    
    Procs for organizations
    
    @author Jade Rubick (jader@bread.com)
    @creation-date 2004-05-24
    @arch-tag: 1d9b7e33-1d9f-43e5-a85e-47dc870fedb9
    @cvs-id $Id$
}

namespace eval organization {}
namespace eval organizations {}

ad_proc -public organizations::name {
    {-organization_id:required}
} {
    Returns the organization name when given the organization_id
    
    @author Jade Rubick (jader@bread.com)
    @creation-date 2004-05-24
    
    @param organization_id

    @return organization name
    
    @error returns an empty string
} {
    return [db_string get_name {
        SELECT
        name
        FROM
        organizations
        WHERE
        organization_id = :organization_id
    } -default ""]
}

ad_proc -public organization::get_by_name {
    {-name:required}
} {
    Return the organization_id of the organization with the given name. Uses
    a lowercase comparison so we do not allow organizations to differ only 
    in case. Returns empty string if no organization found.

    @author Matthew Geddert (openacs@geddert.com)
    @creation-date 2005-07-06
    
    @return organization_id
} {
    return [db_string get_by_name { select organization_id from organizations where lower(name) = lower(:name) } -default {}]
}

ad_proc -public organization::new {
    {-organization_id ""}
    {-legal_name ""}
    {-name:required}
    {-notes ""}
    {-organization_type_id ""}
    {-reg_number ""}
    {-email ""}
    {-url ""}
    {-user_id ""}
    {-peeraddr ""}
    {-package_id ""}
} {
    Creates a new organization
    
    @author Matthew Geddert (openacs@geddert.com)
    @creation-date 2004-06-14
    
    @return organization_id
    
    @error returns an empty string
} {
    if { ![exists_and_not_null user_id] } {
	set user_id [ad_conn user_id]
    }
    if { ![exists_and_not_null peeraddr] } {
	set peeraddr [ad_conn peeraddr]
    }
    if { ![exists_and_not_null package_id] } {
	set package_id [ad_conn package_id]
    }

    set organization_id [db_exec_plsql create_organization {
	select organization__new ( 
				  :legal_name,
				  :name,
				  :notes,
				  :organization_id,
				  :organization_type_id,
				  :reg_number,
				  :email,
				  :url,
				  :user_id,
				  :peeraddr,
				  :package_id
				  )
    }]

    return $organization_id
}



