

# Define the database connection to be used for this model.
connection: "@{CONNECTION_NAME}"

# include all the views
include: "/LookML_Dashboard/*.dashboard.lookml"
include: "/salesforce/*.view.lkml"
include: "/oracle_fusion/*.view.lkml"

datagroup: cortex_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: cortex_default_datagroup

named_value_format: Salesforce_Value_Format {
  value_format: "[>=1000000000]0.00,,,\"B\";[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0.00"
}

explore: case_management{}

explore: opportunity_pipeline {}

explore: leads_capture_conversion {}

explore:sales_activities_engagement  {
join: sales_rep {
  view_label: "SalesActivitiesUser"
  type: full_outer
  sql_on:${sales_activities_engagement.sales_rep_owner_id}=${sales_rep.sales_rep_id} ;;
  relationship: many_to_one
  }

  join: account_country {
    view_label: "AccountCountry"
    type: left_outer
    sql_on: ${sales_activities_engagement.account_id}=${account_country.account_id} ;;
    relationship:  many_to_one
  }

  join: account_industry {
    type: left_outer
    sql_on: ${sales_activities_engagement.account_id}=${account_industry.account_id} ;;
    relationship: many_to_one
  }

  }

explore: sales_activities_engagement_opportunity_pipeline {
  join: sales_rep {
  view_label: "SalesActivitiesUser"
  type: left_outer
  sql_on: ${sales_activities_engagement_opportunity_pipeline.user_full_name}=${sales_rep.sales_rep} ;;
  relationship: many_to_one
}

  join: account_country {
    view_label: "AccountCountry"
    type: left_outer
    sql_on: ${sales_activities_engagement_opportunity_pipeline.account_id}=${account_country.account_id} ;;
    relationship:  many_to_one
  }

  join: account_industry {
    type: left_outer
    sql_on: ${sales_activities_engagement_opportunity_pipeline.account_id}=${account_industry.account_id} ;;
    relationship: many_to_one
  }

  join: sales_activities_engagement{
    type: left_outer
    sql_on: ${sales_activities_engagement.opportunity_id}=${sales_activities_engagement_opportunity_pipeline.opportunity_id}
            AND ${sales_activities_engagement.target_currency}=${sales_activities_engagement_opportunity_pipeline.target_currency};;
    relationship: one_to_many
  }
}

connection: "csg_poc_bigquery"

explore: fusion_customer {}

# explore: fusion_revenue_and_tax {}

# explore: fusion_revenue_renewal {}

explore: fusion_revenue_and_tax {
  join: customer_bridge {
    relationship: many_to_one
    sql_on: ${customer_bridge.fusion_party_id} = ${fusion_revenue_and_tax.partyid} ;;
    type: left_outer
  }
  join: fusion_customer {
    relationship: many_to_one
    sql_on: ${fusion_customer.partyid} = ${fusion_revenue_and_tax.partyid} ;;
  }
  join: fusion_revenue_renewal {
    sql_on: ${fusion_revenue_and_tax.accountnumber}=${fusion_revenue_renewal.accountnumber} ;;
    relationship: many_to_many
    type: inner
  }
}

explore: customer_360 {
  # symmetric_aggregates: no
  from: fusion_revenue_renewal
  view_name: fusion_revenue_renewal
  join: customer_bridge {
    sql_on: ${fusion_revenue_renewal.partyid}=${customer_bridge.fusion_party_id} ;;
    relationship: many_to_one
  }
  # join: opportunity_pipeline {
  #   sql_on:  ${customer_bridge.salesforce_account_id} = ${opportunity_pipeline.account_id};;
  #   type: left_outer
  #   relationship: one_to_many

  # }
}
