- view: client_addresses
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension_group: added
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date

  - dimension: address1
    sql: ${TABLE}.address1

  - dimension: address2
    sql: ${TABLE}.address2

  - dimension: city
    sql: ${TABLE}.city

  - dimension: email
    sql: ${TABLE}.email

  - dimension_group: last_updated
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated

  - dimension: name
    sql: ${TABLE}.name

  - dimension: phone1
    sql: ${TABLE}.phone1

  - dimension: phone2
    sql: ${TABLE}.phone2

  - dimension: private
    type: yesno
    sql: ${TABLE}.private

  - dimension: ref_agency
    type: int
    sql: ${TABLE}.ref_agency

  - dimension: ref_client
    type: int
    sql: ${TABLE}.ref_client

  - dimension: ref_type
    type: int
    sql: ${TABLE}.ref_type

  - dimension: ref_user
    type: int
    sql: ${TABLE}.ref_user

  - dimension: ref_user_updated
    type: int
    sql: ${TABLE}.ref_user_updated

  - dimension: state
    sql: ${TABLE}.state

  - dimension: status
    type: yesno
    sql: ${TABLE}.status

  - dimension: zipcode
    type: int
    sql: ${TABLE}.zipcode

  - measure: count
    type: count
    drill_fields: [id, name]

