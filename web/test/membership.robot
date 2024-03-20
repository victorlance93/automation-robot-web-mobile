*** Settings ***
Documentation        Cenários de testes para adesão de matrículas

Resource             ../resources/Base.resource


Test Setup         Start session
Test Teardown      Take Screenshot
Library    Process
Library    XML

*** Test Cases ***
Deve poder realizar um nova matricula
    ${data}    Get Json fixture    memberships    create

    Delete Account By Email    ${data}[account][email]
    Insert Account             ${data}[account]

    SignIn admin    sac@smartbit.com    pwd123
    Go to membership Page
    Create new membership    ${data}
    Toast should be    Matrícula cadastrada com sucesso.
    Sleep    2

Não devo ter matrícula duplicada 
    [Tags]    dup
    ${data}    Get Json fixture    memberships    duplicate
    
    Insert membership    ${data}

    SignIn admin    sac@smartbit.com    pwd123
    Go to membership Page
    Create new membership    ${data}
    Toast should be    O usuário já possui matrícula.
    Sleep    2


Deve pesquisar matrícula 
    [Tags]    search

    ${data}    Get Json fixture    memberships    search

    Insert Membership    ${data}

    SignIn admin    sac@smartbit.com    pwd123
    Go to membership Page
    Search by name           ${data}[account][name]
    Should filter by name    ${data}[account][name]

Deve excluir uma matricula
    [Tags]    remove  
    ${data}    Get Json fixture    memberships    remove

    Insert Membership    ${data}

    SignIn admin    sac@smartbit.com    pwd123
    Go to membership Page  
    Click trash    ${data}[account][name]
    Confirm deletion 
    Toast should be    Matrícula removida com sucesso.
    Sleep    2
    Membership should not be visible    ${data}[account][name]