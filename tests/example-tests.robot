*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    DateTime
Library    Process 

*** Variables ***
${MyVar}   My ValueDenis

*** Keywords ***
Verify page title
    Title Should Be   JohnDoe Contracting

Verify section title
    Page Should Contain     Invoice Manager

My Keyword
    Log    ThisIsMyText

Logging
    [Arguments]    ${message}
    Log    ${message}

Add
    [Arguments]    ${a}    ${b}
    ${SUM}=    Evaluate    ${a} + ${b}
    [Return]    ${SUM}

Print Profile
    [Arguments]    ${name}
    Log    Printing profile for: ${name}

StartBrowser
    # Création des options Chrome de manière plus structurée
    ${chrome_options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver
    
    # Configuration des préférences Chrome pour l'environnement conteneurisé
    ${prefs}=    Create Dictionary
    ...    download.default_directory=/tmp
    ...    download.prompt_for_download=${FALSE}
    ...    download.directory_upgrade=${TRUE}
    
    # Configuration des arguments Chrome de manière séquentielle
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    no-sandbox
    Call Method    ${chrome_options}    add_argument    disable-gpu
    
    # Configuration des préférences
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    
    # Création du navigateur avec les options configurées
    Create Webdriver    Chrome    chrome_options=${chrome_options}

*** Test Cases ***
Verify Environment Variables
    [Documentation]    Vérifie les variables d'environnement critiques
    ${display}=    Get Environment Variable    DISPLAY    default=None
    Log    DISPLAY: ${display}
    
    ${chrome_path}=    Get Environment Variable    CHROME_BINARY_LOCATION    default=None
    Log    CHROME_BINARY_LOCATION: ${chrome_path}
    
    ${chromedriver_path}=    Get Environment Variable    CHROMEDRIVER_PATH    default=None
    Log    CHROMEDRIVER_PATH: ${chromedriver_path}

*** Test Cases ***
Verify Environment Setup
    [Documentation]    Vérifie que l'environnement est correctement configuré
    ${chrome_version}=    Run Process    chromium    --version
    Log    Chrome Version: ${chrome_version.stdout}
    
    ${chromedriver_version}=    Run Process    chromedriver    --version
    Log    ChromeDriver Version: ${chromedriver_version.stdout}
    
    # Vérification des permissions du répertoire de travail
    ${permissions}=    Run Process    ls    -la    ${EXECDIR}
    Log    Directory Permissions: ${permissions.stdout}

*** Variables ***
${CHROME_PROFILE_DIR}    ${EXECDIR}/temp-chrome-profile

*** Variables ***
${CHROME_OPTIONS}         --headless --disable-dev-shm-usage --no-sandbox --disable-gpu

*** Variables ***
@{CHROME_ARGS}    
...    --headless
...    --disable-dev-shm-usage
...    --no-sandbox
...    --disable-gpu

*** Test Cases ***
Create an invoice
    StartBrowser
    
    # Navigation vers l'URL cible
    Go To    http://inv.beaufortfairmont.com/
    
    # Ajout d'une pause pour assurer le chargement complet
    Sleep    2s
    
    # Vérification de la page
    Location Should Contain    inv.beaufortfairmont

    # Vérifier le titre de la page
    Verify page title

    # Vérifier le titre de la section
    Verify section title

    Log    MyVar: ${MyVar}
    My Keyword
    
    [Teardown]    Run Keywords
    ...    Capture Page Screenshot    AND
    ...    Close All Browsers

*** Test Cases ***
My Addition Test 1
    ${SUM}=    Add    2  3
    Should Be Equal As Integers    ${SUM}    5

My Addition Test 2
    ${NickName}=   Set Variable    Paul
    Print Profile    ${NickName}

My list of Variables
    [Documentation]    Test case to log chrome profile directory
    Logging    ${CHROME_PROFILE_DIR}
    # this is the comment
