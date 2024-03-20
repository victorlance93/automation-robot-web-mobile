*** Settings ***
Documentation        Arquivo para testar o consumo da API com tasks

Resource    ./Services.resource

*** Tasks ***
Testando a API
    Set user token
    Get account by name    Tony Stark