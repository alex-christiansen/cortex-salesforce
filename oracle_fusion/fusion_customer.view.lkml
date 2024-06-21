view: fusion_customer {
  sql_table_name: `csg-data-platform-poc.UTILITY.FusionCustomer` ;;

  dimension: accountname {
    label: "Account Name"
    type: string
    sql: ${TABLE}.ACCOUNTNAME ;;
  }
  dimension: address1 {
    label: "Cust Address"
    type: string
    sql: ${TABLE}.ADDRESS1 ;;
  }
  dimension: city {
    label: "Cust City"
    type: string
    sql: ${TABLE}.CITY ;;
  }
  dimension: country {
    label: "Cust Country"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.COUNTRY ;;
  }

  dimension: partyid {
    type: number
    sql: ${TABLE}.PARTYID ;;
  }
  dimension: custaccountid {
    label: "Cust Account ID"
    primary_key: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.CUSTACCOUNTID ;;
  }
  dimension: hqcountry_name {
    label: "HQ Country Name"
    type: string
    sql: ${TABLE}.HQCountryName ;;
  }
  dimension: postalcode {
    label: "Postal Code"
    type: string
    sql: ${TABLE}.POSTALCODE ;;
  }
  dimension: state {
    label: "Cust State"
    type: string
    sql: ${TABLE}.STATE ;;
  }
  dimension: status {
    label: "Status"
    type: string
    sql: CASE WHEN RAND() <.25 THEN 'Active'
              WHEN RAND() <.5 THEN 'Churned'
              WHEN RAND() <.75 THEN 'Trial'
              WHEN RAND() <= 1 THEN 'Deliquent'
              END;;

    # ${TABLE}.STATUS ;;
  }
  dimension_group: w_create_dt {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.W_CREATE_DT ;;
  }
  dimension_group: w_update_dt {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    datatype: datetime
    sql: ${TABLE}.W_UPDATE_DT ;;
  }
  measure: count {
    type: count
  }
  measure: customer_count {
    label: "Total Customers"
    group_label: "Customer Counts"
    type: count_distinct
    sql: ${custaccountid} ;;
  }
  measure: active_customer_count {
    type: count_distinct
    group_label: "Customer Counts"
    sql: ${custaccountid} ;;
    filters: [status: "Active"]
  }
  measure: trial_customer_count {
    type: count_distinct
    group_label: "Customer Counts"
    sql: ${custaccountid} ;;
    filters: [status: "Trial"]
  }
  measure: churned_customer_count {
    type: count_distinct
    group_label: "Customer Counts"
    sql: ${custaccountid} ;;
    filters: [status: "Churned"]
  }
  measure: deliquent_customer_count {
    type: count_distinct
    sql: ${custaccountid} ;;
    group_label: "Customer Counts"
    filters: [status: "Delinquent"]
  }
  measure: customer_churn_rate {
    type: number
    sql: ${active_customer_count}/nullif(${customer_count},0);;
    value_format_name: percent_1
  }

}
