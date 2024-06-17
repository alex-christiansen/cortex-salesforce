# The name of this view in Looker is "Case Management"
view: case_management {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `@{GCP_PROJECT_ID}.@{SFDC_DATASET}.CaseManagement`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: account_created {
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
    sql: ${TABLE}.AccountCreatedDatestamp ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account ID" in Explore.

  dimension: account_id {
    type: string
    sql: ${TABLE}.AccountId ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.AccountName ;;
  }

  dimension: account_owner {
    type: string
    sql: ${TABLE}.AccountOwnerId ;;
  }

  dimension: account_owner_name {
    type: string
    sql: ${TABLE}.AccountOwnerName ;;
  }

  dimension: account_phone {
    type: string
    sql: ${TABLE}.AccountPhone ;;
  }

  dimension: account_type {
    type: string
    sql: ${TABLE}.AccountType ;;
  }

  # dimension: annual_revenue {
  #   type: number
  #   sql: ${TABLE}.AnnualRevenue ;;
  # }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_annual_revenue {
  #   type: sum
  #   sql: ${annual_revenue} ;;
  # }

  # measure: average_annual_revenue {
  #   type: average
  #   sql: ${annual_revenue} ;;
  # }

  dimension: billing_country {
    type: string
    sql: ${TABLE}.AccountBillingCountry ;;
  }

  dimension_group: case_closed {
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
    sql: ${TABLE}.CaseClosedDatestamp ;;
  }

  # dimension: case_closed_trend {
  #   type: number
  #   sql: ${TABLE}.CaseClosedTrend ;;
  # }

  dimension_group: case_created {
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
    sql: ${TABLE}.CaseCreatedDatestamp ;;
  }

dimension: subject {
  type: string
  sql: ${TABLE}.CaseSubject ;;
}

  dimension: case_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.CaseId ;;
  }

  measure: count_caseId {
    type: count_distinct
    sql: ${TABLE}.CaseId ;;
  }

  measure: count_Owner {
    type: count_distinct
    sql: ${TABLE}.CaseOwnerId ;;
  }

  #measure: Avg_cases_per_agent{
  #  type: number
  #  sql: ${count_caseId}/${count_Owner} ;;
 # }

  dimension: case_age {
    type: number
    sql: Date_Diff(CURRENT_DATETIME(),${case_created_date},DAY) ;;
  }

  dimension: case_resolution_time{
    type: number
    sql: Date_Diff(${case_closed_date},${case_created_date},DAY);;
  }

measure: avg_resolution_time {
  type: average
  sql: ${case_resolution_time} ;;
}

  dimension: case_is_closed {
    type: yesno
    sql: ${TABLE}.IsCaseClosed ;;
  }

dimension: agent_is_assigned {
  type: yesno
  sql: ${TABLE}.IsAgentAssigned ;;
}

  dimension: case_number {
    type: string
    sql: ${TABLE}.CaseNumber ;;
  }

  dimension: case_origin {
    type: string
    sql: ${TABLE}.CaseOrigin ;;
  }

  dimension: case_owner {
    type: string
    sql: ${TABLE}.CaseOwnerId ;;
  }

  dimension: case_status {
    type: string
    sql: ${TABLE}.CaseStatus ;;
  }

  dimension: case_type {
    type: string
    sql: ${TABLE}.CaseType ;;
  }

  # dimension: closed_cases_by_owner {
  #   type: number
  #   sql: ${TABLE}.ClosedCasesByOwner ;;
  # }

  # dimension: count_of_open_cases {
  #   type: number
  #   sql: ${TABLE}.CountOfOpenCases ;;
  # }

  # dimension: customers_by_closed_cases {
  #   type: number
  #   sql: ${TABLE}.CustomersByClosedCases ;;
  # }

  # dimension: customers_by_high_priority_open_cases {
  #   type: number
  #   sql: ${TABLE}.CustomersByHighPriorityOpenCases ;;
  # }

  # dimension: customers_by_open_cases {
  #   type: number
  #   sql: ${TABLE}.CustomersByOpenCases ;;
  # }

  # dimension: customers_with_escalated_cases {
  #   type: number
  #   sql: ${TABLE}.CustomersWithEscalatedCases ;;
  # }

  # dimension: employees {
  #   type: number
  #   sql: ${TABLE}.Employees ;;
  # }

  dimension: industry {
    type: string
    sql: ${TABLE}.AccountIndustry ;;
  }

  # dimension: open_cases_by_channel {
  #   type: number
  #   sql: ${TABLE}.OpenCasesByChannel ;;
  # }

  # dimension: open_cases_by_high_priority {
  #   type: number
  #   sql: ${TABLE}.OpenCasesByHighPriority ;;
  # }

  # dimension: open_cases_by_owner {
  #   type: number
  #   sql: ${TABLE}.OpenCasesByOwner ;;
  # }

  # dimension: open_cases_by_priority {
  #   type: number
  #   sql: ${TABLE}.OpenCasesByPriority ;;
  # }

  # dimension: open_cases_by_rep {
  #   type: number
  #   sql: ${TABLE}.OpenCasesByRep ;;
  # }

  # dimension: open_cases_by_status {
  #   type: number
  #   sql: ${TABLE}.OpenCasesByStatus ;;
  # }

  # dimension: open_cases_by_type {
  #   type: number
  #   sql: ${TABLE}.OpenCasesByType ;;
  # }

  # dimension: parent_account_id {
  #   type: string
  #   sql: ${TABLE}.ParentAccountId ;;
  # }

  dimension: priority {
    type: string
    sql: ${TABLE}.CasePriority ;;
  }

  dimension: shipping_country {
    type: string
    sql: ${TABLE}.AccountShippingCountry ;;
  }

  # dimension_group: status_change_date {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.CaseStatusChangeDateTime ;;
  # }

  # dimension: user_country {
  #   type: string
  #   sql: ${TABLE}.UserCountry ;;
  # }

  # dimension_group: user_created {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.UserCreatedDate ;;
  # }

  # dimension: user_department {
  #   type: string
  #   sql: ${TABLE}.UserDepartment ;;
  # }

  # dimension: user_employee_number {
  #   type: string
  #   sql: ${TABLE}.UserEmployeeNumber ;;
  # }

  # dimension: user_first_name {
  #   type: string
  #   sql: ${TABLE}.UserFirstName ;;
  # }

  # dimension: user_full_name {
  #   type: string
  #   sql: ${TABLE}.CaseOwnerName ;;
  # }

  # dimension: user_id {
  #   type: string
  #   sql: ${TABLE}.UserId ;;
  # }

  # dimension: user_is_active {
  #   type: yesno
  #   sql: ${TABLE}.UserIsActive ;;
  # }

  # dimension: user_last_name {
  #   type: string
  #   sql: ${TABLE}.UserLastName ;;
  # }

  dimension: case_owner_name_original {
    type: string
    sql: ${TABLE}.CaseOwnerName ;;
  }

  dimension: case_owner_name {
    type: string
    sql: CASE
          WHEN RIGHT(${case_number},2) BETWEEN '01' AND '04' THEN 'Michael Moore'
          WHEN RIGHT(${case_number},2) BETWEEN '05' AND '08' THEN 'Daniel Anderson'
          WHEN RIGHT(${case_number},2) BETWEEN '08' AND '11' THEN 'Jane Anderson'
          WHEN RIGHT(${case_number},2) BETWEEN '12' AND '15' THEN 'Harper Anderson'
          WHEN RIGHT(${case_number},2) BETWEEN '16' AND '19' THEN 'Daniel Garcia'
          WHEN RIGHT(${case_number},2) BETWEEN '20' AND '23' THEN 'William Brown'
          WHEN RIGHT(${case_number},2) BETWEEN '24' AND '27' THEN 'Michael Smith'
          WHEN RIGHT(${case_number},2) BETWEEN '28' AND '31' THEN 'Joseph Garcia'
          WHEN RIGHT(${case_number},2) BETWEEN '32' AND '35' THEN 'James Williams'
          WHEN RIGHT(${case_number},2) BETWEEN '36' AND '39' THEN 'Samuel Thomas'
          WHEN RIGHT(${case_number},2) BETWEEN '40' AND '43' THEN 'David Thompson'
          WHEN RIGHT(${case_number},2) BETWEEN '44' AND '47' THEN 'Ava Brown'
          WHEN RIGHT(${case_number},2) BETWEEN '48' AND '51' THEN 'Mia Davis'
          WHEN RIGHT(${case_number},2) BETWEEN '52' AND '55' THEN 'Amelia Williams'
          WHEN RIGHT(${case_number},2) BETWEEN '56' AND '59' THEN 'James Thomas'
          WHEN RIGHT(${case_number},2) BETWEEN '60' AND '63' THEN 'Emily Wilson'
          WHEN RIGHT(${case_number},2) BETWEEN '64' AND '67' THEN 'Daniel Brown'
          WHEN RIGHT(${case_number},2) BETWEEN '68' AND '71' THEN 'David Taylor'
          WHEN RIGHT(${case_number},2) BETWEEN '72' AND '75' THEN 'Evelyn White'
          WHEN RIGHT(${case_number},2) BETWEEN '76' AND '79' THEN 'Benjamin Rodriguez'
          WHEN RIGHT(${case_number},2) BETWEEN '80' AND '83' THEN 'Matthew Johnson'
          WHEN RIGHT(${case_number},2) BETWEEN '84' AND '87' THEN 'Ava Thomas'
          WHEN RIGHT(${case_number},2) BETWEEN '88' AND '91' THEN 'John Thomas'
          WHEN RIGHT(${case_number},2) BETWEEN '92' AND '95' THEN 'Matthew Thompson'
          WHEN RIGHT(${case_number},2) BETWEEN '96' AND '99' THEN 'David Hernandez'
          ELSE 'Unknown' END;;
  }


  # dimension: user_type {
  #   type: string
  #   sql: ${TABLE}.UserType ;;
  # }

  # dimension: volume_of_case_created {
  #   type: number
  #   sql: ${TABLE}.VolumeOfCaseCreated ;;
  # }

  measure: dash_nav {
    hidden: no
    label: "Navigation Bar"
    type: string
    sql: "";;
    html:
    <div style="background-color: #FFFFFF; height:525px;width:100%"></div>
      <div style="background-color: #FFFFFF; border: solid 1px #4285F4; border-radius: 5px; padding: 5px 10px; height: 60px; width:100%">
        <nav style="font-size: 18px; color: #4285F4">
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/cortex_salesforce::case_overview__trends" target=”_blank”>Case Overview And Trends</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/cortex_salesforce::case_management__resolution" target=”_blank”>Case Management And Resolution</a>
          <a style="padding: 5px; float: center; line-height: 40px; margin-left: 8px; color: #4285F4" href="/dashboards/cortex_salesforce::accounts_with_cases" target=”_blank”>Accounts With Cases</a>
        </nav>
        </nav>
      </div>
    <div style="background-color: #FFFFFF; height:500px;width:100%"></div>;;
  }

  measure: count {
    type: count
    drill_fields: [case_owner_name, account_name, case_owner_name]
  }
}
