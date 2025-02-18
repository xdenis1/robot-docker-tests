*** Settings ***
Library    RequestsLibrary

*** Variables ***
${URL1}    https://api.open-meteo.com/v1/forecast?latitude=51.6108&longitude=5.2903&hourly=temperature_2m
${URL2}      https://www.google.com
${URL3}      https://restful-booker.herokuapp.com/ping
${URL4}      https://restful-booker.herokuapp.com/auth

*** Test Cases ***
Get Ping
    ${response}=    Get    ${URL3}
     log  ${response.elapsed}
Post Auth
    ${response}=    POST    ${URL4}
     log  ${response.elapsed}