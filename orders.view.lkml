view: orders {

  ## takes on the value of the user attribute in a comment in the generated SQL

  sql_table_name: -- hi there {{ _user_attributes['first_name'] }}
    demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  filter: date_filter {
    type: date
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

  ## Will display the start and end dates of the date range selected in date_filter


  dimension: date_filter_value {
  sql: concat(date_format({% date_start date_filter %}, '%b %e %Y'), " to ", date_format({% date_end date_filter %}, '%b %e %Y')) ;;
  }

  ## value formatting based on user region

  parameter: region {
    type: unquoted
    allowed_value: {
      label: "US"
      value: "us"
    }
    allowed_value: {
      label: "EU"
      value: "eu"
    }
  }

  # with parameter

  dimension: date_formatted {
    type: date
    sql: ${TABLE}.created_at ;;
    html: {% if parameter_value region == 'us'  %}
          {{ rendered_value | date: "%m/%d/%y" }}
          {% else %}
          {{rendered_value | date: "%d/%m/%y" }}
          {% endif %}
          ;;
  }

  # with user attributes

  dimension: attribute {
    type: date
    sql: ${TABLE}.created_at ;;
    html: {% if _user_attributes['region'] == 'us'  %}
          {{ rendered_value | date: "%m/%d/%y" }}
          {% elsif _user_attributes['region'] == 'eu' %}
          {{rendered_value | date: "%d/%m/%y" }}
          {% endif %}
          ;;
  }

  ## conditional formatting

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    html: {% if {{ value }} == 'cancelled' %}
    <div style="color: black; font-size:200%; background-color: salmon; text-align:center"><p> {{ value }} </p></div>
          {% elsif {{ value }} == 'complete' %}
    <div style="color: black; font-size:200%; background-color: lavender; text-align:center"><p> {{ value }} </p></div>
          {% elsif {{ value }} == 'pending' %}
    <div style="color: black; font-size:200%; background-color: yellowgreen; text-align:center"><p> {{ value }} </p></div>
          {% endif %};;
  }



  dimension_group: return_after_user_created {
    view_label: "Cohort Size"
    type: duration
    sql_start: ${users.created_raw} ;;
    sql_end: ${created_raw} ;;
  }


  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  parameter: filter_or_no {
    type: yesno
  }

  dimension: filter_value {
    type: yesno
    sql: {% parameter filter_or_no %} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
  }
}
