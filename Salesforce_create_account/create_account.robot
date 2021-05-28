*** Settings ***
Documentation   Denne bot skal illustrer en medarbejder som laver opslag i 
...             cvr registret for at fremskaffe data på en kunde.
Library         RPA.Dialogs
Library         RPA.Excel.Files
Library         RPA.Browser.Selenium
Library         RPA.Tables
Library         RPA.Robocloud.Secrets
Library         RPA.Tasks

# Own librarys
Resource    ressources/salesforce_library.robot

# Test only
Library         RPA.core.notebook
Library    RPA.JSON


*** Variables ***
${DATA_SHEET}=    ${CURDIR}${/}data.xlsx
${CVR_URL}=     https://datacvr.virk.dk/data/
${CVR_LONG_URL}=  https://datacvr.virk.dk/data/visenhed?enhedstype=virksomhed&id=
${CVR_ERROR_PAGE}=  https://datacvr.virk.dk/data/fejlside


*** Keywords ***
Open Excel file and get cvr row
    Open Workbook   ${DATA_SHEET}
    ${worksheet}=   Read Worksheet As Table     header=True  
    
    FOR    ${row}    IN    @{worksheet}        
        Go To       ${CVR_LONG_URL}${row}[cvr]
        ${error_page}=  Is Location    ${CVR_ERROR_PAGE}
        Run Keyword If  ${error_page}== ${FALSE}
        ...             Extract data and update excel   ${row}
    END
    
    Close Workbook

*** Keywords ***
Extract data and update excel
    [arguments]      ${row}  
    Wait Until Element Is Visible       css:DIV.row.dataraekker:nth-child(2) > DIV.col-sm-6:nth-child(2)
    ${address}          Get Text        css:DIV.row.dataraekker:nth-child(2) > DIV.col-sm-6:nth-child(2)
    ${zipcode}          Get Text        css:DIV.row.dataraekker:nth-child(3) > DIV.col-sm-6:nth-child(2)
    ${company_type}     Get Text        css:DIV.row.dataraekker:nth-child(5) > DIV.col-sm-6:nth-child(2)
    
    
    &{dict}    Create Dictionary
    ...    Name=
    ...    Type= ${company_type}
    ...    Industry=     #Branche kode
    ...    BillingCity= ${address} ${zipcode}
    ...    Phone=         #Telefonnummer
    ...    Description=     #CVR nummer




*** Tasks ***
Get data from cvr
    [Setup]     Open Available Browser      ${CVR_URL}     
    Open Excel file and get cvr row
    ${sheet}=    Read Worksheet As Table    ${DATA_SHEET}    
Auth Salesforce
    [Setup]    SF Api auth

conver to csv
    ${workbook}=    Open Workbook    /home/patrick/Robots/Examples/Salesforce_create_account/Salesforce_create_account/data.xlsx
    ${dict}=    Read Worksheet     header=True

    Log    ${dict}

Insert bulk data
    ${status}=    Execute Dataloader Insert    ${dict}    mapping_object    object_type