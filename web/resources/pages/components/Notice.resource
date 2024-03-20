*** Settings ***
Documentation        Ações e elementos do Componente Notice

Library        Browser

*** Keywords ***

Notice should be 
    [Arguments]    ${target}    

    ${element}    Set Variable    css=form .notice
     Wait For Elements State
    ...    ${element}  
    ...    visible    10

    Get Text    ${element}  
    ...    equal    ${target}
