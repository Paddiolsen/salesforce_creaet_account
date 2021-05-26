*** Settings ***
Library    RPA.Salesforce
Variables    variables.py

*** Keywords ***
SF Api auth
    Auth With Token    username=${USER_NAME}    password=${PASSWORD}    api_token=${TOKEN}