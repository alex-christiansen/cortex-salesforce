explore: fusion_revenue_renewal {}
view: fusion_revenue_renewal {
  sql_table_name: `csg-data-platform-poc.UTILITY.FusionRevenueRenewal` ;;

  dimension: pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: concat(${accountname},${accountnumber},${arr_expiration_date},${gldate_date},${headerordereddate_date},${lineextendedamount},${linefulfilledqty},${lineshippedqty},${order_num_str},${potential_expiring_arr},${partyid},${partyname},${partynumber}) ;;
  }
  dimension: accountname {
    type: string
    sql: ${TABLE}.ACCOUNTNAME ;;
    link: {
      label: "Open in Salesforce"
      url: "www.salesforce.com/{{ accountnumber._value }}"
      icon_url: "https://www.salesforce.com/etc/designs/sfdc-www/en_us/favicon.ico"
    }
    link: {
      label: "Open in Oracle"
      url: "www.oracle.com/{{ accountnumber._value }}"
      icon_url: "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/oracle-icon.png"
    }
    # action: {
    #   label: "Update the Stage in Salesforce"

    # }

  }
  dimension: accountnumber {
    type: string
    sql: ${TABLE}.ACCOUNTNUMBER ;;
  }
  dimension_group: arr_expiration {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ARR_Expiration_Date ;;
  }
  dimension_group: gldate {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.GLDATE ;;
  }
  dimension_group: headerordereddate {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.HEADERORDEREDDATE ;;
  }
  dimension: lineextendedamount {
    type: number
    sql: ${TABLE}.LINEEXTENDEDAMOUNT ;;
  }
  measure: total_line_extended_amount {
    type: sum
    sql: ${lineextendedamount} ;;
    value_format_name: usd
  }
  dimension: linefulfilledqty {
    type: number
    sql: ${TABLE}.LINEFULFILLEDQTY ;;
  }
  measure: total_line_filled_quantity {
    type: sum
    sql: ${linefulfilledqty} ;;
  }
  dimension: lineorderedqty {
    type: number
    sql: ${TABLE}.LINEORDEREDQTY ;;
  }
  measure: total_line_ordered_quantity {
    type: sum
    sql: ${lineorderedqty} ;;
  }
  dimension: lineshippedqty {
    type: number
    sql: ${TABLE}.LINESHIPPEDQTY ;;
  }
  measure: total_line_shipped_quantity {
    type: sum
    sql: ${lineshippedqty} ;;
  }
  dimension: lineunitlistprice {
    type: number
    sql: ${TABLE}.LINEUNITLISTPRICE ;;
  }
  measure: total_line_unit_list_price {
    type: sum
    sql: ${lineunitlistprice} ;;
  }
  dimension: lineunitsellingprice {
    type: number
    sql: ${TABLE}.LINEUNITSELLINGPRICE ;;
  }
  measure: total_line_unit_selling_price {
    type: sum
    sql: ${lineunitsellingprice} ;;
    value_format_name: usd
  }
  dimension: order_num_str {
    type: string
    sql: ${TABLE}.OrderNumStr ;;
  }
  dimension: partyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PARTYID ;;
  }
  dimension: partyname {
    type: string
    sql: ${TABLE}.PARTYNAME ;;
  }
  dimension: partynumber {
    type: string
    sql: ${TABLE}.PARTYNUMBER ;;
  }
  dimension: potential_expiring_arr {
    type: number
    sql: ${TABLE}.Potential_Expiring_ARR ;;
  }
  measure: total_potential_expiring_arr {
    label: "Total Potential Expiring ARR"
    hidden: yes
    type: sum
    sql: case when ${potential_expiring_arr} = 0 then null else ${potential_expiring_arr} END ;;
    # value_format_name: usd
  }
  measure: formatted_total_potential_expiring_arr {
    type: number
    label: "Total Potential Expiring ARR"
    sql: CASE WHEN ROUND(${total_potential_expiring_arr},0) = 0 then NULL else ${total_potential_expiring_arr} END ;;
    value_format_name: usd_0
    drill_fields: [accountname, accountnumber]
  }
  dimension: racustomertrxlineextendedamount {
    type: number
    sql: ${TABLE}.RACUSTOMERTRXLINEEXTENDEDAMOUNT ;;
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
    drill_fields: [accountname, partyname, formatted_total_potential_expiring_arr]
  }
}
