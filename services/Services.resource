*** Settings ***
Documentation    Camada de integração com a API 

Library      RequestsLibrary
Variables    Env.py

*** Keywords ***
Set user token

    ${payload}        Create Dictionary
    ...               email=sac@smartbit.com
    ...               password=pwd123
    
    ${response}        POST
    ...         url=${API_URL}/sessions
    ...         json=${payload}
    
    ${token}    Set Variable    Bearer ${response.json()}[token]
 
     Set Suite Variable    ${token}

Get account by name 
    [Arguments]    ${name}

    ${headers}    Create Dictionary
    ...            Authorization=${token}
    
    ${params}    Create Dictionary
    ...            name=${name}

    
    ${response}    GET
    ...            url=${API_URL}/accounts
    ...            params=${params}
    ...            headers=${headers}
    [return]    ${response.json()}[data][0]