*** Settings ***
Documentation    Ações e elementos da página de matrícula

Library        Browser

*** Keywords ***
Create new membership
    [Arguments]    ${data}
    Go to membership form
    Select account          ${data}[account][name]        ${data}[account][cpf]
    Select plan             ${data}[plan][name]
    Fill card value         ${data}[credit_card]
    
    Click    css=button[type=submit] >> text=Cadastrar
Go to membership form
     Click                   css=a[href="/memberships/new"]
     Wait For Elements State    css=h1 >> text=Nova matrícula
    ...    visible         5
    
Select account 
    [Arguments]    ${name}    ${cpf}
    Fill Text    css=input[aria-label=select_account]    ${name} 
    Click        css=[data-testid="${cpf}"]

Select plan 
    [Arguments]    ${plan}
    Fill Text    css=input[aria-label=select_plan]    ${plan}
    Click    css=div[class$=option] >> text=${plan}

Fill card value
    [Arguments]    ${credit_card}    
    Fill Text    css=input[name=card_number]        ${credit_card}[card_number]
    Fill Text    css=input[name=card_holder]        ${credit_card}[holder] 
    Fill Text    css=input[name=card_month]         ${credit_card}[month]
    Fill Text    css=input[name=card_year]          ${credit_card}[year]
    Fill Text    css=input[name=card_cvv]           ${credit_card}[cvv]

Search by name
    [Arguments]    ${name}
    Fill Text    css=input[placeholder]    ${name}
    Wait For Elements State    css=strong >> text=Total: 1
    ...     visible    5 

Should filter by name 
    [Arguments]    ${name}
    Wait For Elements State    css=table tbody tr >> text=${name}
    ...     visible    5 

Click trash 
    [Arguments]    ${name}
    Click    xpath=//td[text()="${name}"]/..//button

Membership should not be visible
    [Arguments]    ${name}
    Wait For Elements State    css=table tbody tr >> text=${name}
    ...    detached    5