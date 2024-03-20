*** Settings ***
Documentation        Ações e elementos do Componente Toast

Library        Browser

*** Keywords ***

Toast should be 
    [Arguments]    ${expected_text}

    ${element}     Set Variable    .Toastify__toast-body
    Wait For Elements State    css=${element}
    ...    visible    5
    Sleep    1
    Get Text        css=${element}
    ...    equal    ${expected_text}   
    Take Screenshot    selector=${element}