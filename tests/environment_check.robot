*** Settings ***
Documentation     Test de vérification de l'environnement
Library           OperatingSystem
Library           SeleniumLibrary

*** Test Cases ***
Vérifier l'environnement Python
    [Documentation]    Vérifie que Python et Robot Framework sont correctement installés
    ${result}=    Run    python --version
    Should Contain    ${result}    Python 3
    Log    Version Python trouvée: ${result}
    
    ${rf_version}=    Run    robot --version
    Should Contain    ${rf_version}    Robot Framework
    Log    Version Robot Framework trouvée: ${rf_version}

Vérifier la structure des dossiers
    [Documentation]    Vérifie que les dossiers nécessaires existent
    Directory Should Exist    ${CURDIR}
    Directory Should Exist    ${CURDIR}/resources
    Directory Should Exist    ${CURDIR}/../results
    Log    Structure des dossiers vérifiée avec succès

Verify Selenium Setup
    ${chrome_options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Go To    http://inv.beaufortfairmont.com/
    Close Browser