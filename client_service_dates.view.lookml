- view: client_service_dates
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: added
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date

  - dimension_group: date
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.date

  - dimension_group: last_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated

  - dimension: ref_client_service
    type: int
    sql: ${TABLE}.ref_client_service

  - dimension: ref_user
    type: int
    sql: ${TABLE}.ref_user

  - dimension: ref_user_updated
    type: int
    sql: ${TABLE}.ref_user_updated

  - dimension: time
    sql: ${TABLE}.time

  - measure: count
    type: count
    drill_fields: [id]

