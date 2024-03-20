*** Settings ***

Documentation        Cenários de teste Login ${SPACE}

Resource    ../resources/Base.resource

Test Setup       Start session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve logar como gestor de academia 
    Go to login page
    Submit login form       sac@smartbit.com    pwd123
    User is logged in       sac@smartbit.com

Não devo logar com senha incorreta
    [Tags]    inv_pass
    Go to login page
    Submit login form        sac@smartbit.com    abc123
    Toast should be          As credenciais de acesso fornecidas são inválidas. Tente novamente!
  
    # Código para pegar HTML e inspecionar elemento
    # ${temp}    Get Page Source
    # Log        ${temp}       

Não devo logar com usuario não cadastrado
    [Tags]    inv_pass
    Go to login page
    Submit login form        404@smartbit.com    pwd123123
    Toast should be          As credenciais de acesso fornecidas são inválidas. Tente novamente!

Tentativa de login com dados incorretos
    [Template]    Login with verify notice
    ${EMPTY}            ${EMPTY}    Os campos email e senha são obrigatórios.
    ${EMPTY}            pwd123      Os campos email e senha são obrigatórios.
    sac@smartbit.com    ${EMPTY}    Os campos email e senha são obrigatórios.
    www.smartbit.com    pwd123      Oops! O email informado é inválido
    smartbit*.com       pwd123      Oops! O email informado é inválido
    gayfdyuhskjnsihj    pwd123      Oops! O email informado é inválido
    &*&*&*&*&*&*&*&*&   pwd123      Oops! O email informado é inválido
    52426723773868787   pwd123      Oops! O email informado é inválido
    Facebok.com.br      pwd123      Oops! O email informado é inválido
    @testest.com.br     pwd123      Oops! O email informado é inválido



*** Keywords ***
Login with verify notice 
    [Arguments]    ${email}    ${password}    ${output_message}

    Go to login page
    Submit login form    ${email}    ${password} 
    Notice should be     ${output_message}