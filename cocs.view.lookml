- view: cocs
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: name
    sql: ${TABLE}.name

  - dimension: state
    sql: ${TABLE}.state

  - dimension: status
    type: yesno
    sql: ${TABLE}.status

  - measure: count
    type: count
    drill_fields: [id, name]

