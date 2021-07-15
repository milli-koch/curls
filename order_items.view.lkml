view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      week_of_year,
      month,
      month_num,
      quarter,
      quarter_of_year,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: returnedDate {
    type: date
    sql: ${TABLE}.returned_at ;;
  }




  ## dynamic timeframes & testing parameter parameter_name vs parameter_name._parameter_value

  parameter: timeframe_select {
    type: string
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
  }

  # parameter parameter_name: The value of the parameter filter you ask for with parameter_name.

  dimension: tag  {
    group_label: "parameter_name"
    sql: CASE
          WHEN {% parameter timeframe_select %} = 'Week' THEN ${returned_week}
          WHEN {% parameter timeframe_select %} = 'Month' THEN ${returned_month}
          WHEN {% parameter timeframe_select %} = 'Quarter' THEN ${returned_quarter}
          ELSE NULL
          END ;;
  }

  # parameter_name._parameter_value: Injects the value of the parameter filter you ask for with parameter_name into a logical statement.

  dimension: object  {
    group_label: "parameter_value"
    sql: CASE
          WHEN {{ timeframe_select._parameter_value }} = 'Week' THEN ${returned_week}
          WHEN {{ timeframe_select._parameter_value }} = 'Month' THEN ${returned_month}
          WHEN {{ timeframe_select._parameter_value }} = 'Quarter' THEN ${returned_quarter}
          ELSE NULL
          END ;;
  }

  # will return an error with "Variable not found 'parameter'" because it's in a conditional

  # dimension: conditional_object {
  #   view_label: "parameter_name"
  #   sql:
  #   {% if parameter timeframe_select == "'Week'" %}
  #     ${returned_week}
  #   {% elsif parameter timeframe_select == "'Month'" %}
  #     ${returned_month}
  #   {% elsif parameter timeframe_select == "'Quarter'" %}
  #     ${returned_quarter}
  #   {% else %}
  #     ${returned_date}
  #   {% endif %};;
  # }

  # will work – note the double and single quotes for parameter of type string

  dimension: conditional_tag {
    group_label: "parameter_value"
    sql:
    {% if timeframe_select._parameter_value == "'Week'" %}
      ${returned_week}
    {% elsif timeframe_select._parameter_value == "'Month'" %}
      ${returned_month}
    {% elsif timeframe_select._parameter_value == "'Quarter'" %}
      ${returned_quarter}
    {% else %}
      ${returned_date}
    {% endif %};;
  }

  ## for testing

  dimension: parameter_object {
    group_label: "parameter_value"
    sql: {{ timeframe_select._parameter_value }} ;;
  }

  dimension: parameter_tag {
    group_label: "parameter_name"
    sql: {% parameter timeframe_select %} ;;
  }

  ## parameters with html

  parameter: color_select {
    type: unquoted
    allowed_value: {
      label: "Red"
      value: "salmon"
    }
    allowed_value: {
      label: "Green"
      value: "yellowgreen"
    }
  }

  # will not work

  dimension: sale_price_tag {
    group_label: "parameter_name"
    type: number
    sql: ${TABLE}.sale_price ;;
    html: <div style="color: black; font-size:200%; background-color: {% parameter color_select %}; text-align:center"><p> {{ value }} </p></div>;;
  }

  # will work

  dimension: sale_price {
    group_label: "parameter_value"
    type: number
    sql: ${TABLE}.sale_price ;;
    html: <div style="color: black; font-size:200%; background-color: {{ color_select._parameter_value }}; text-align:center"><p> {{ value }} </p></div>;;
  }




  measure: total_sales {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
