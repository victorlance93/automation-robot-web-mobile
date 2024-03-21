*** Settings ***
Documentation         Arquivo principal do projeto Robot 

Variables           Env.py
Library             JSONLibrary
Library             Browser 
Library             ../../libs/Account.py
Library             ../../libs/Database.py
Resource            pages/Ladinng.resource
Resource            pages/Welcome.resource
Resource            pages/Login.resource
Resource            pages/Accounts.resource
Resource            pages/Memberships.resource
Resource            pages/components/Notice.resource
Resource            pages/components/Toast.resource
Resource            pages/components/Navbar.resource
Resource            pages/components/Modal.resource


*** Keywords ***

Start session
    New Browser    browser=chromium    headless=False
    New Page    ${BASE_URL}

Get Json fixture
    [Arguments]        ${file_name}    ${scenario}

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    
    [Return]    ${data}[${scenario}]

SignIn admin
    [Arguments]    ${email}    ${password}
    Go to login page
    Submit login form       ${email}   ${password}
    User is logged in       ${email}