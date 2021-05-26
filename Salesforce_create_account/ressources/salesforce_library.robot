*** Settings ***
Library    RPA.Salesforce
Variables    variables.py

*** Keywords ***
SF Api auth
    Auth With Token    username=${USER_NAME}    password=${PASSWORD}    api_token=${TOKEN}


SF create new account
    [Arguments]        ${account_information}
    &{status}=    Create Salesforce Object    object_type=Account    object_data=${account_information}
    log     ${account_information.Name} ${status.success}     

SF update account


SF delete account


SF read account