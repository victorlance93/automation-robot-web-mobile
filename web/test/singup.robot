*** Settings ***
Documentation       Cenário de testes de pré-cadastro de clientes

Resource            ../resources/Base.resource

Test Setup         Start session
Test Teardown      Take Screenshot
Library    OperatingSystem

*** Test Cases ***
Deve preencher formulário de pré-cadastro
    [Tags]    smoke
    ${account}    Create Dictionary
    ...         name=Victor Lance
    ...         email=victorlance@yahoo.com
    ...         cpf=43797103000
    Delete Account By Email    ${account}[email]
    Submit signup form    ${account}
    Verify welcome message

Pré cadastro inválido    
    [Template]    Attempt signup
    ${EMPTY}        victor@gmail.com         56675370014       Por favor informe o seu nome completo
    Victor Hugo     ${EMPTY}                 56675370014       Por favor, informe o seu melhor e-mail
    Victor Hugo     victor@gmail.com         ${EMPTY}          Por favor, informe o seu CPF
    Victor Hugo     victor&gmail.com         56675370014       Oops! O email informado é inválido
    Victor Hugo     victor*gmail.com         56675370014       Oops! O email informado é inválido
    Victor Hugo     www.facebook.com         56675370014       Oops! O email informado é inválido
    Victor Hugo     victor2gmail.com         56675370014       Oops! O email informado é inválido
    Victor Hugo     victor@gmail.com         a1973639u6378     Oops! O CPF informado é inválido
    Victor Hugo     victor@gmail.com         000000000000      Oops! O CPF informado é inválido
    Victor Hugo     victor@gmail.com         1                 Oops! O CPF informado é inválido
    Victor Hugo     victor@gmail.com         @$#ˆ%$%$%%%&      Oops! O CPF informado é inválido
    

*** Keywords ***
Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}
        ${account}      Create Dictionary
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}

     Submit signup form    ${account}
     Notice should be    ${output_message}

