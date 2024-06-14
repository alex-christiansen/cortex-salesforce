# The name of this view in Looker is "Leads Capture Conversion"
view: leads_capture_conversion {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `@{GCP_PROJECT_ID}.@{SFDC_DATASET}.LeadsCaptureConversions`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Lead ID" in Explore.

  dimension: lead_id {
    type: string
    #primary_key: yes
    sql: ${TABLE}.LeadID ;;

  }

  dimension: lead_id_target_currency {
    type: string
    primary_key: yes
    sql: CONCAT(${lead_id},${target_currency}) ;;
  }


  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: lead_first_response {
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
    sql: ${TABLE}.LeadFirstResponeDatestamp ;;
  }

  dimension: is_converted {
    type: yesno
    sql: ${TABLE}.IsLeadConverted ;;
  }

  dimension_group: lead_converted {
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
    datatype: date
    sql: ${TABLE}.LeadConvertedDate ;;
  }

  dimension: lead_country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.LeadCountry ;;
  }

  dimension_group: lead_created {
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
    sql: ${TABLE}.LeadCreatedDatestamp ;;
  }

  dimension: lead_first_name {
    type: string
    sql: ${TABLE}.LeadFirstName ;;
  }



  measure: count_of_lead_Id {
    type: count_distinct
    sql: ${lead_id} ;;
    value_format: "#,##0"
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  measure: count_of_lead_Id_converted {
    type: count_distinct
    filters: [is_converted: "Yes"]
    sql: ${lead_id} ;;
    value_format: "#,##0"
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  measure: count_of_lead_Id_status_new {
    type: count_distinct
    filters: [lead_status: "New"]
    sql: ${lead_id} ;;
    value_format: "#,##0"
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  measure: count_of_lead_Id_status_contacted {
    type: count_distinct
    filters: [lead_status: "Contacted"]
    sql: ${lead_id} ;;
    value_format: "#,##0"
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  measure: count_of_lead_Id_status_nurturing {
    type: count_distinct
    filters: [lead_status: "Nurturing"]
    sql: ${lead_id} ;;
    value_format: "#,##0"
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  measure: count_of_lead_Id_status_qualified {
    type: count_distinct
    filters: [lead_status: "Qualified"]
    sql: ${lead_id} ;;
    value_format: "#,##0"
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  measure: count_of_lead_Id_status_unqualified {
    type: count_distinct
    filters: [lead_status: "Unqualified"]
    sql: ${lead_id} ;;
    value_format: "#,##0"
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }



  dimension: lead_industry {
    type: string
    sql: ${TABLE}.LeadIndustry ;;
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  dimension: lead_last_name {
    type: string
    sql: ${TABLE}.LeadLastName ;;
  }

  dimension: lead_name {
    type: string
    sql: ${TABLE}.LeadName ;;
  }

  dimension: lead_owner {
    type: string
    sql: ${TABLE}.LeadOwnerId ;;
  }

  dimension: lead_source {
    type: string
    sql: ${TABLE}.LeadSource ;;
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  dimension: lead_status {
    type: string
    sql: ${TABLE}.LeadStatus ;;
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  dimension_group: opportunity_closed {
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
    datatype: date
    sql: ${TABLE}.OpportunityCloseDate ;;
  }

  dimension_group: opportunity_created {
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
    sql: ${TABLE}.OpportunityCreatedDatestamp ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.OpportunityID ;;
  }

  measure: count_of_opportunity_id {
    type: count_distinct
    filters: [is_converted: "Yes"]
    sql: ${opportunity_id} ;;
    value_format: "#,##0"
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.OpportunityName ;;
  }

  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}.OpportunityOwner ;;
  }

  dimension: opportunity_stage {
    type: string
    sql: ${TABLE}.OpportunityStage ;;
  }

  dimension: opportunity_type {
    type: string
    sql: ${TABLE}.OpportunityType ;;
  }

  dimension: probability {
    type: number
    sql: ${TABLE}.Probability ;;
  }

  dimension: total_sale_amount {
    type: number
    sql: ${TABLE}.TotalSaleAmountInTargetCurrency ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: Sum_of_Total_sale_amount {
    type: sum_distinct
    filters: [is_converted: "Yes"]
    sql_distinct_key: ${opportunity_id} ;;
    sql: ${total_sale_amount} ;;
    precision: 2
    value_format_name: Salesforce_Value_Format
    #value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0.00"
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }


  dimension: lead_owner_name {
    type: string
    sql:
    CASE
        WHEN ${lead_owner} = '0058a00000Lvvu1AAB' THEN 'Michael Moore'
        WHEN ${lead_owner} = '0058a00000LvkJcAAJ' THEN 'Daniel Anderson'
        WHEN ${lead_owner} = '0058a00000LvkJNAAZ' THEN 'Jane Anderson'
        WHEN ${lead_owner} = '0058a00000LvkJmAAJ' THEN 'Harper Anderson'
        WHEN ${lead_owner} = '0058a00000LvvtfAAB' THEN 'Daniel Garcia'
        WHEN ${lead_owner} = '0058a00000Lvvu3AAB' THEN 'William Brown'
        WHEN ${lead_owner} = '0058a00000LvvtRAAR' THEN 'Michael Smith'
        WHEN ${lead_owner} = '0058a00000LvvtgAAB' THEN 'Joseph Garcia'
        WHEN ${lead_owner} = '0058a00000LvvtdAAB' THEN 'James Williams'
        WHEN ${lead_owner} = '0058a00000LvvtYAAR' THEN 'Samuel Thomas'
        WHEN ${lead_owner} = '0058a00000LvkJhAAJ' THEN 'David Thompson'
        WHEN ${lead_owner} = '0058a00000LvvtbAAB' THEN 'Ava Brown'
        WHEN ${lead_owner} = '0058a00000LvvtcAAB' THEN 'Mia Davis'
        WHEN ${lead_owner} = '0058a00000Lvvu5AAB' THEN 'Amelia Williams'
        WHEN ${lead_owner} = '0058a00000LvvtXAAR' THEN 'James Thomas'
        WHEN ${lead_owner} = '0058a00000LvvtlAAB' THEN 'Emily Wilson'
        WHEN ${lead_owner} = '0058a00000LvvtaAAB' THEN 'Daniel Brown'
        WHEN ${lead_owner} = '0058a00000LvvtyAAB' THEN 'David Taylor'
        WHEN ${lead_owner} = '0058a00000LvvteAAB' THEN 'Evelyn White'
        WHEN ${lead_owner} = '0058a00000LvvtwAAB' THEN 'Benjamin Rodriguez'
        WHEN ${lead_owner} = '0058a00000LvkJXAAZ' THEN 'Matthew Johnson'
        WHEN ${lead_owner} = '0058a00000LvvtxAAB' THEN 'Ava Miller'
        WHEN ${lead_owner} = '0058a00000LvvtzAAB' THEN 'Ava Thomas'
        WHEN ${lead_owner} = '0058a00000LvvtvAAB' THEN 'Isabella Anderson'
        WHEN ${lead_owner} = '0058a00000LvvtWAAR' THEN 'Evelyn Brown'
        WHEN ${lead_owner} = '0058a00000LiM2BAAV' THEN 'John Thomas'
        WHEN ${lead_owner} = '0058a00000Lvvu2AAB' THEN 'Michael Moore'
        WHEN ${lead_owner} = '0058a00000Lvvu4AAB' THEN 'Ava Moore'
        WHEN ${lead_owner} = '0058a00000LvvtZAAR' THEN 'William Jones'
        WHEN ${lead_owner} = '0058a00000LvkJSAAZ' THEN 'David Hernandez'
        WHEN ${lead_owner} = '0058a00000Lvvu6AAB' THEN 'Matthew Thompson'
        WHEN ${lead_owner} = '0058a00000Lvvu0AAB' THEN 'James Anderson'
        ELSE 'Unknown' -- Optional: Handle cases where the ID is not found
    END ;;
    link: {
      label: "Leads Detailed Report"
      url: "/dashboards/cortex_salesforce::leads_capture__conversion_details?Lead+Created+Date={{_filters['leads_capture_conversion.lead_created_date']}}&Country={{_filters['leads_capture_conversion.lead_country']}}&Lead+Owner={{_filters['leads_capture_conversion.lead_owner_name']}}&Industry={{_filters['leads_capture_conversion.lead_industry']}}&Lead+Source={{_filters['leads_capture_conversion.lead_source']}}&Target+Currency={{_filters['leads_capture_conversion.target_currency']}}"
    }
  }

  dimension: target_currency {
    type: string
    sql: ${TABLE}.TargetCurrency ;;
  }

 measure: count {
    type: count
    drill_fields: [detail*]
  }



  measure: dash_nav {
    hidden: no
    label: "Navigation Bar"
    type: string
    sql: "";;
    html:
    <div style="background-color: #FFFFFF; height:525px;width:100%"></div>
      <div style="background-color: #FFFFFF; border: solid 1px #4285F4; border-radius: 5px; padding: 5px 10px; height: 60px; width:100%">
        <nav style="font-size: 18px; color: #4285F4">
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/cortex_salesforce::leads_capture__conversion" target=”_blank”>Leads Capture And Conversion</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/cortex_salesforce::opportunity_trends__pipeline" target=”_blank”>Opportunity Trends And Pipeline</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/cortex_salesforce::sales_activities__engagement" target=”_blank”>Sales Activities And Engagement</a>
        </nav>
        </nav>
      </div>
    <div style="background-color: #FFFFFF; height:500px;width:100%"></div>;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      lead_first_name,
      lead_owner_name,
      opportunity_name,
      lead_last_name,
      lead_name
    ]
  }
}
