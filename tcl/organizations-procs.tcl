# 

ad_library {
    
    Procs for organizations
    
    @author Jade Rubick (jader@bread.com)
    @creation-date 2004-05-24
    @arch-tag: 1d9b7e33-1d9f-43e5-a85e-47dc870fedb9
    @cvs-id $Id$
}


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
