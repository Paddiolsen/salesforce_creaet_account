*** Settings ***
Library    RPA.Salesforce
Variables    variables.py

*** Keywords ***
SF Api auth
    Auth With Token    username=${USER_NAME}    password=${PASSWORD}    api_token=${TOKEN}


SF create new account
    [Arguments]        ${account_information}
    &{status}=    Create Salesforce Object
    ...            object_type=Account    
    ...            object_data=${account_information}     
    log     ${status}   
    [Return]    ${status}

SF update account
    [Arguments]    ${account_id}    ${account_information}
    ${status}=  Update Salesforce Object    
    ...    object_type=account    
    ...    object_id=${account_id}    
    ...    object_data=${account_information}
    
    Log    ${status}

SF delete account
    [Arguments]    ${account_id}
    Delete Salesforce Object    object_type=account    object_id=${account_id}
    Log    ${status}

SF read account
    [Arguments]    ${account_id}
    ${account_obj}=    Get Salesforce Object By Id    object_type=account    object_id=${account_id}
    Log    ${account_obj}


    # Requirements 
    #        Name=
    #        NumberOfEmployees=
    #        Type=Prospect
    #        Industry=
    #        Ownership=
    #        BillingCountry=
    #        BillingCity=
    #        Phone=
