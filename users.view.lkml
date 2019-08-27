view: users {
  sql_table_name: {% if _explore._name == "users" %}
  demo_db.{% parameter table_name %}
  {% else %}
  demo_db.users
  {% endif %};;

  parameter: table_name {
    type: string
    default_value: "users"
    allowed_value: {
      value: "users"
      label: "Users"
    }
    allowed_value: {
      value: "orders"
      label: "Orders"
    }
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: name {
    type: string
    sql: concat(${first_name}, " ", ${last_name}) ;;
    link: {
      label: "Drill to Dashboard"
      url: "/dashboards/437?f[users.name]={{ value }}&f[users.created_date]={{ _filters[users.created_date] }}
      &f[users.gender]={{ users.gender | url_encode }}"
    }
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, first_name, last_name, orders.count]
  }
}
