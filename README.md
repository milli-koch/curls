# Liquid 101

## What?
>Liquid is an open-source, Ruby-based template language created by Shopify.
It can be used in conjunction with LookML to build a more flexible, dynamic code.

| Tags | Objects | Filters |
| :---: |:---:| :---:|
| {%      %} | {{      }} | \|  |
| used to create logic | output pieces of data | modify the output of numbers, strings, objects, and variables
| {% parameter category_filter %} | {{ value }} | {{ product.sale_price \| times: 100.0 }} |

---


## Where?
- Parameters that begin with sql (sql, sql_on, sql_table_name etc.)
- The html parameter
- The link parameter
- The label parameter of a field
- The description parameter of a field
- The action parameter


---

## Why?

#### Example Use Cases
- Using User Attributes for dynamic schema and table name Injection
- Creating dynamic links or rendering dynamic images
- Changing the label of a field based on the x being used
- Adding custom conditional formatting


---

## How?
LookML Objects        →    **value**
Liquid Tags             →    **{% parameter parameter_name %}**
Referencing Special LookML    →    **_user_attributes['name_of_attribute']**
Referencing Values in a Query   →    **view_name.field_name._is_filtered**

---

## Who?

YOU!

**Find and fix the broken syntax for practice troubleshooting liquid errors:**

1. [Broken dashboard drill](https://dcl.dev.looker.com/explore/curls_training/order_items?qid=pTEdR0vbs7c2BQ0Re7eLPu)

2. [Syntax error](https://dcl.dev.looker.com/explore/curls_training/users?toggle=fil&qid=RnXqDEb9cBlwX7kcoHA1Ff)

3. [Variable not found "parameter_value"](https://dcl.dev.looker.com/explore/curls_training/order_items?qid=DaOMl7hdQIyzmIbs0cKuZi)

4. [Variable not found "(?)"](https://dcl.dev.looker.com/explore/curls_training/order_items?qid=mYF3ZWbI2TrPNJicBfe8pF)

5. [sql_always_where not working](https://dcl.dev.looker.com/explore/curls_training/order_items?qid=7MDSoLXERuSmjmx50Hd8rq&toggle=fil)


---

## Resources

**Guru**

[SME LookML - Liquid Use Cases](https://app.getguru.com/card/i6E5AEyT/SME-LookML-Liquid-Use-Cases)

[Liquid](https://app.getguru.com/card/yinpooKi/Liquid)

**Discourse**

[Great Use Cases for Liquid Parameters](https://discourse.looker.com/t/great-use-cases-for-parameter-fields/6099)

[Conditional Formatting](https://discourse.looker.com/t/conditional-formatting-of-color-or-images-within-table-cells-using-html/278)

**Help Center**

[Custom Drilling](https://help.looker.com/hc/en-us/articles/360001288228-Custom-Drilling-Using-HTML-and-Link)

[Date Formatting](https://help.looker.com/hc/en-us/articles/360023800253-Easy-Date-Formatting-with-Liquid)

**Docs**

[Liquid Variable Reference](https://docs.looker.com/reference/liquid-variables)

[Templated Filters and Liquid Parameters](https://docs.looker.com/data-modeling/learning-lookml/templated-filters)

[Parameter](https://docs.looker.com/reference/field-params/parameter)

**Other**

[Cheat Sheet](http://cheat.markdunkley.com/)

[Liquid for Designers](https://github.com/Shopify/liquid/wiki/Liquid-for-Designers)
