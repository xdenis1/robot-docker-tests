*** Settings ***
Documentation     Test de vérification de l'environnement
Library           OperatingSystem

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