## dynamicallly calculate cohort size based on filter conditions

view: cohort_size {
  derived_table:{
    sql:
      SELECT
        TO_CHAR(created_at,'YYYY-MM') AS created_month
        , COUNT(*) as cohort_size
      FROM users
      WHERE
        {% condition users.age %} age {% endcondition %}
        AND {% condition users.state %} state {% endcondition %}
        AND {% condition users.created_date %} created_month {% endcondition %}
      GROUP BY 1  ;;
  }

  dimension: created_month {
    primary_key: yes
  }

  dimension: cohort_size {
    type: number
  }

  measure: total_revenue_over_total_cohort_size {
    type: number
    sql: ${order_items.total_sales} / NULLIF(${total_cohort_size},0) ;;
    value_format_name: usd
  }

  measure: total_cohort_size {
    type: sum
    sql: ${cohort_size} ;;
  }
}
