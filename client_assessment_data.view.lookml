- view: client_assessment_data
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: added
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date

  - dimension: custom_data
    sql: ${TABLE}.custom_data

  - dimension_group: last_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated

  - dimension: ref_client_assessment_demographics
    type: int
    sql: ${TABLE}.ref_client_assessment_demographics

  - dimension: ref_user
    type: int
    sql: ${TABLE}.ref_user

  - dimension: ref_user_updated
    type: int
    sql: ${TABLE}.ref_user_updated

  - measure: count
    type: count
    drill_fields: [id]

