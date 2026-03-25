*** Settings ***
Library    SeleniumLibrary

Suite Teardown    Close All Browsers

*** Variables ***

${URL}    https://Kaddeye.github.io/SoftwareTesting/swag_labs.html

*** Test Cases ***
Swag Labs E2E Flow
    Open Browser    ${URL}    chrome    options=add_argument("--headless")
    Maximize Browser Window

    # Login
    Wait Until Element Is Visible    id=username    5s
    Input Text    id=username    standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button

    # Products page
    Wait Until Element Is Visible    css:.product-card    5s

    # Add multiple items
    Click Button    xpath=(//button[contains(text(),"Add to Cart")])[1]
    Click Button    xpath=(//button[contains(text(),"Add to Cart")])[2]

    # Open checkout
    Click Element    css:.cart-icon

    Wait Until Element Is Visible    css:.cart-item    5s

    # Remove one item
    Click Button    xpath=(//button[contains(text(),"Remove")])[1]

    # Fill checkout form
    Input Text    id=first-name    Test
    Input Text    id=last-name    User
    Input Text    id=postal-code    12345

    Click Button    xpath=//button[contains(text(),"Complete Purchase")]

    # Confirm success
    Wait Until Element Is Visible    id=confirmation-message    5s
    Element Should Contain    id=confirmation-message    Thank you for your purchase

    Close Browser