explore: customer_bridge {}
view: customer_bridge {
  sql_table_name: `csg-data-platform-poc.UTILITY.Customer_Bridge` ;;

  dimension: fusion_party_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.Fusion_Party_ID ;;
  }
  dimension: salesforce_account_id {
    type: string
    sql: ${TABLE}.Salesforce_AccountID ;;
  }
  measure: count {
    type: count
  }
}
