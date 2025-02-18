*** Settings ***
Documentation     Exemples de testing d'API avec Robot Framework
Library          RequestsLibrary

*** Variables ***
${BROWSER}    headlesschrome
${URL}        https://www.google.com

*** Test Cases ***
Quick Get Request Test
    ${response}=  GET  https://www.google.com  params=None

Quick Get params
    ${response}=  GET  https://www.google.com  params=q=robotframework&page=1

Quick Get params dictionnaire
    ${response}=  GET  https://www.google.com  params={'q': 'robotframework', 'page': 1}

Quick Get params expected status
    ${response}=  GET  https://www.google.com  expected_status=200

Quick Get params see content
    ${response}=  GET  https://www.google.com
    log  ${response.status_code}  
    log  ${response.headers}
    log  ${response.cookies}
    log  ${response.text}  
    log  ${response.elapsed}
    log  ${response.is_redirect}
    log  ${response.url}
               