{#- a custom GENERIC test: a macro-style block that returns FAILING rows.
    saved in tests/generic/, called from any properties yml like the
    built-ins. OPTIONAL on camera; deep patterns in supporter (B.2). -#}

{% test non_negative(model, column) %}
  select *
  from {{ model }}
  where {{ column }} < 0
{% endtest %}