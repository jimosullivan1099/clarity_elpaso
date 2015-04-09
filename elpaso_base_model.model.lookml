- connection: clarity_elpaso

- scoping: true           # for backward compatibility
- include: "*.view.lookml"       # include all views in this project
- include: "*.dashboard.lookml"  # include all dashboards in this project


- explore: base
  from: client_program_screening_base
  persist_for: 60 minutes
  label: 'HMIS Performance'
  conditionally_filter: 
    enrollments.start_date: 'before today'
    enrollments.end_date_or_today_date: 'after 3 months ago'
  access_filter_fields: [agencies.id]

  joins:
    - join: entry_screen
      sql_on: ${base.first_entry_screen_id} = ${entry_screen.id}   #need to figure out how to restrict data if private
      type: inner
      sql_always_where: ref_agency = 0
      
    - join: entry_custom
      type: inner
      fields: [entry_custom_fields*]
      sql_on:  ${entry_custom.ref_program} = ${entry_screen.ref_program} AND  ${entry_custom.ref_status} = ${entry_screen.id} 
        
#     - join: inbound_recidivism
#       sql_on: ${entry_screen.id} = ${inbound_recidivism.screen_id}

    - join: last_screen
      sql_on: ${base.last_screening_to_analyze} = ${last_screen.id}
      type: left_outer
      
    - join: last_custom
      type: left_outer
      fields: [last_custom_fields*]
      sql_on: ${last_screen.id} = ${last_custom.ref_status}      
      
    - join: outbound_recidivism
      type: left_outer
      sql_on: ${last_screen.id} = ${outbound_recidivism.screen_id}
    
    - join: enrollments
      sql_on: ${base.ref_program} = ${enrollments.id}
      
    - join: programs
      fields: [ref_agency, name, project_type_code, funder, id, agency_project_name, name_link_agency, list_of_program_names, status, added_date, description, count, name_link]
      sql_on: ${enrollments.ref_program} = ${programs.id}
      
    - join: agencies
      fields: [id, coc, name]
      sql_on: ${programs.ref_agency} = ${agencies.id}
      
    - join: household_makeup
      sql_on: ${enrollments.ref_household} = ${household_makeup.id}

    - join: clients
      sql_on: ${base.ref_client} = ${clients.id}

    - join: static_demographics
      from: client_demographics
      required_joins: clients
      fields: [id, gender, gender_text, ethnicity, ethnicity_text, ref_client, race , race_text, veteran, veteran_text]
      sql_on: ${clients.id} = ${static_demographics.ref_client}
      
    - join: static_demographics_custom
      from: client_custom
      fields: [static_demographics_custom.client_custom_fields*]
      sql_on:  ${base.ref_client} = ${static_demographics_custom.ref_client}
      
    - join: client_service_programs
      fields: []
      type: left_outer
      sql_on: ${enrollments.id} = ${client_service_programs.ref_client_program}
      
    - join: client_services
      fields: []
      type: inner
      sql_on: ${client_services.id} = ${client_service_programs.ref_client_service}
      
    - join: service_items
      fields: []
      type: inner
      required_joins: client_services
      sql_on: ${service_items.id} = ${client_services.ref_service_item}

    - join: services
      type: inner
      sql_on: ${service_items.ref_service} = ${services.id}


# - explore: population_agency
#   label: 'HMIS Population over Time'
#   access_filter_fields: [agencies.id]
#   joins:
#     - join: entry_screen
#       sql_on: ${population_agency.first_entry_screen_id} = ${entry_screen.id}
#       type: left_outer
# 
# #     - join: inbound_recidivism
# #       sql_on: ${entry_screen.id} = ${inbound_recidivism.screen_id}
# 
#     - join: last_screen
#       sql_on: ${population_agency.last_screening_to_analyze} = ${last_screen.id}
#       type: left_outer
#       
# #     - join: outbound_recidivism
# #       sql_on: ${last_screen.id} = ${outbound_recidivism.screen_id}
#     
#     - join: enrollments
#       sql_on: ${population_agency.ref_program} = ${enrollments.id}
#       
#     - join: programs
#       fields: [ref_agency, name, project_type_code, id, name_link_agency, funder, status, added_date, description, count, name_link]
#       sql_on: ${enrollments.ref_program} = ${programs.id}
#       
#     - join: agencies
#       fields: [id, name]
#       sql_on: ${programs.ref_agency} = ${agencies.id}
# 
#     - join: household_makeup
#       sql_on: ${enrollments.ref_household} = ${household_makeup.id}
#       
#     - join: clients
#       sql_on: ${population_agency.ref_client} = ${clients.id}
# 
#     - join: static_demographics
#       from: client_demographics
#       required_joins: clients
#       fields: [id, gender, gender_text, ethnicity, ethnicity_text, ref_client, race, race_text, veteran, veteran_text]
#       sql_on: ${clients.id} = ${static_demographics.ref_client}
