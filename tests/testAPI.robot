*** Settings ***
# Importation des bibliothèques nécessaires pour les tests d'API
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
# Définition de l'URL de base de notre API de test
${API_URL}    https://jsonplaceholder.typicode.com

*** Keywords ***
Configurer la Session API
    # Création d'une session avec les en-têtes par défaut pour JSON
    ${headers}=    Create Dictionary    Content-Type=application/json
    Create Session    jsonplaceholder    ${API_URL}    headers=${headers}    verify=True

*** Test Cases ***
Test Récupération d'un Post
    # Test de récupération d'un article spécifique
    Configurer la Session API
    ${response}=    GET On Session    jsonplaceholder    /posts/1
    
    # Vérification du code de statut
    Status Should Be    200    ${response}
    
    # Vérification de la structure de la réponse
    Dictionary Should Contain Key    ${response.json()}    title
    Dictionary Should Contain Key    ${response.json()}    body
    Dictionary Should Contain Key    ${response.json()}    userId

Test Création d'un Post
    # Test de création d'un nouvel article
    Configurer la Session API
    ${body}=    Create Dictionary    
    ...    title=Test Post    
    ...    body=This is a test post    
    ...    userId=1
    
    ${response}=    POST On Session    
    ...    jsonplaceholder    
    ...    /posts    
    ...    json=${body}
    
    # Vérification du code de statut pour la création
    Status Should Be    201    ${response}
    
    # Vérification que les données envoyées sont bien présentes dans la réponse
    Dictionary Should Contain Item    ${response.json()}    title    Test Post
    Dictionary Should Contain Item    ${response.json()}    body    This is a test post