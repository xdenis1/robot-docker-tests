*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    headlesschrome
${URL}        https://www.google.com

*** Test Cases ***
Simple Test
    Open Browser    ${URL}    ${BROWSER}
    Title Should Contain    Google
    Close Browser
