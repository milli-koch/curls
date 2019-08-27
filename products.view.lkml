view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    link: {
      label: "Google {{ value }}"
      url: "http://www.google.com/search?q={{ value }}"
    }
  }

  ## templated filter and dynamic filtered measure

  filter: category_filter {
    type: string
    suggest_dimension: products.category
    suggest_explore: order_items
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: hidden_category_filter {
    hidden: yes
    type: yesno
    sql: {% condition category_filter %} ${category} {% endcondition %} ;;
  }

  measure: category_count {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: hidden_category_filter
      value: "Yes"
    }
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  ## drill to a scatterplot

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count, product_facts.count]
    link: {
      label: "Drill as scatter plot"
      url: "
      {% assign vis_config = '{\"type\": \"looker_scatter\"}' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

}
