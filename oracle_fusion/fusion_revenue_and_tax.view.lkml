explore: fusion_rt{
  from: fusion_revenue_and_tax
}
view: fusion_revenue_and_tax {
  sql_table_name: `csg-data-platform-poc.UTILITY.FusionRevenueAndTax` ;;

  dimension: pk {
    type: string
    sql: concat(${accountnumber}, ${partyid}, ${racustomertrxlinelinenumber}, ${racustomertrxtrxnumber}) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: accountname {
    label: "Account Name"
    type: string
    sql: ${TABLE}.ACCOUNTNAME ;;
  }
  dimension: accountnumber {
    label: "Account Number"
    type: string
    sql: ${TABLE}.ACCOUNTNUMBER ;;
  }
  dimension: arr_amount {
    label: "ARR Amount"
    type: number
    sql: ${TABLE}.ARR_Amount ;;
  }
  dimension: arr_flag {
    label: "ARR Flag"
    type: string
    sql: ${TABLE}.ARR_Flag ;;
  }
  dimension: categorytranslationpeocategoryname {
    type: string
    sql: ${TABLE}.CATEGORYTRANSLATIONPEOCATEGORYNAME ;;
  }
  dimension: categorytranslationpeodescription {
    type: string
    sql: ${TABLE}.CATEGORYTRANSLATIONPEODESCRIPTION ;;
  }
  dimension: partyid {
    type: number
    sql: ${TABLE}.PARTYID ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.COUNTRY ;;
  }
  dimension: desc_gl_account_ {
    label: "GL Account Desc"
    type: string
    sql: ${TABLE}.DESC_GL_ACCOUNT_ ;;
  }
  dimension: gl_account_ {
    label: "GL Account"
    type: string
    sql: ${TABLE}.GL_ACCOUNT_ ;;
  }
  dimension_group: gldate {
    group_label: "GL Date"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.GLDATE ;;
  }
  dimension: itembasepeoitemnumber {
    type: string
    sql: ${TABLE}.ITEMBASEPEOITEMNUMBER ;;
  }
  dimension: itemtranslationpeodescription {
    type: string
    sql: ${TABLE}.ITEMTRANSLATIONPEODESCRIPTION ;;
  }
  dimension: period_name {
    type: string
    sql: ${TABLE}.PERIOD_NAME ;;
  }
  dimension: period_num {
    type: number
    sql: ${TABLE}.PERIOD_NUM ;;
  }
  dimension: racustomertrxcomments {
    type: string
    sql: ${TABLE}.RACUSTOMERTRXCOMMENTS ;;
  }
  dimension: racustomertrxcompleteflag {
    type: string
    sql: ${TABLE}.RACUSTOMERTRXCOMPLETEFLAG ;;
  }
  dimension: racustomertrxinvoicecurrencycode {
    type: string
    sql: ${TABLE}.RACUSTOMERTRXINVOICECURRENCYCODE ;;
  }
  dimension: racustomertrxlinedescription {
    type: string
    sql: ${TABLE}.RACUSTOMERTRXLINEDESCRIPTION ;;
  }
  dimension: racustomertrxlineextendedamount {
    type: number
    sql: ${TABLE}.RACUSTOMERTRXLINEEXTENDEDAMOUNT ;;
  }
  dimension: racustomertrxlinefreightcharge {
    type: number
    sql: ${TABLE}.RACUSTOMERTRXLINEFREIGHTCHARGE ;;
  }
  dimension: racustomertrxlinelinenumber {
    type: number
    sql: ${TABLE}.RACUSTOMERTRXLINELINENUMBER ;;
  }
  dimension: racustomertrxlinequantityinvoiced {
    type: number
    sql: ${TABLE}.RACUSTOMERTRXLINEQUANTITYINVOICED ;;
  }
  dimension: racustomertrxlinequantityordered {
    type: number
    sql: ${TABLE}.RACUSTOMERTRXLINEQUANTITYORDERED ;;
  }
  dimension: racustomertrxlineracustomertrxlineunitsellingprice {
    type: number
    sql: ${TABLE}.RACUSTOMERTRXLINERACUSTOMERTRXLINEUNITSELLINGPRICE ;;
  }
  dimension: racustomertrxlinerevenueamount {
    type: number
    sql: ${TABLE}.RACUSTOMERTRXLINEREVENUEAMOUNT ;;
  }
  dimension: racustomertrxlineunitstandardprice {
    type: number
    sql: ${TABLE}.RACUSTOMERTRXLINEUNITSTANDARDPRICE ;;
  }
  dimension_group: racustomertrxtrxdate {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.RACUSTOMERTRXTRXDATE ;;
  }
  dimension: racustomertrxtrxnumber {
    type: string
    sql: ${TABLE}.RACUSTOMERTRXTRXNUMBER ;;
  }
  dimension: transactiontypename {
    type: string
    sql: ${TABLE}.TRANSACTIONTYPENAME ;;
  }
  dimension: transactiontypetype {
    type: string
    sql: ${TABLE}.TRANSACTIONTYPETYPE ;;
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

  measure: total_arr {
    label: "Total ARR"
    type: sum
    value_format_name: decimal_0
    sql: arr_amount ;;
  }

  measure: total_revenue {
    type: sum
    sql: ${racustomertrxlineextendedamount} ;;
    value_format_name: usd  # Adjust format as needed
  }
  measure: total_freight_amount {
    type: sum
    sql: ${racustomertrxlinefreightcharge} ;;
    value_format_name: usd
  }
  measure: avg_transaction_value {
    type: average
    sql: ${racustomertrxlineextendedamount} ;;
    value_format_name: usd
  }
  measure: mrr {
    type: sum
    sql: CASE WHEN ${transactiontypetype} = 'Recurring' THEN ${racustomertrxlineextendedamount} ELSE 0 END;;
    value_format_name: usd
    hidden: yes
  }
  measure: revenue_growth_rate_mom {
    type: number
    sql: 100 * ((${total_revenue} - offset(${total_revenue}, -1)) / NULLIF(offset(${total_revenue}, -1), 0)) ;;
    value_format_name: percent_1
    hidden: yes
  }
  measure: new_arr_monthly {
    type: sum
    # hidden: yes
    sql: ${arr_amount} ;;
    value_format_name: usd
    filters: [arr_flag: "Yes", gldate_date: "2023-06"]
  }
  measure: total_transactions {
    type: count_distinct
    sql: ${racustomertrxtrxnumber} ;;
  }
  measure: avg_selling_price {
    type: average
    sql: ${racustomertrxlineracustomertrxlineunitsellingprice} ;;
    value_format_name: usd
  }

  measure: avg_standard_price {
    type: average
    sql: ${racustomertrxlineunitstandardprice} ;;
    value_format_name: usd
  }


  measure: count {
    type: count
    drill_fields: [period_name, transactiontypename, categorytranslationpeocategoryname, accountname]
  }
}
