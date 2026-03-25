*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close Browser

*** Variables ***
${URL}    https://Kaddeye.github.io/SoftwareTesting/swag_labs.html
${BROWSER}    chrome

*** Test Cases ***
Full User Journey - Swag Labs

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage

    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window

    Input Text    id=username    standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button

    Wait Until Element Is Visible    id=products-grid    5s

    Click Button    xpath=(//button[contains(text(),'Add to Cart')])[1]
    Click Button    xpath=(//button[contains(text(),'Add to Cart')])[2]

    Click Element    css=.cart-icon

    Wait Until Element Is Visible    id=checkout-page    5s

    Click Button    xpath=(//button[contains(text(),'Remove')])[1]

    Input Text    id=first-name    Test
    Input Text    id=last-name    User
    Input Text    id=postal-code    12345

    Click Button    xpath=//button[contains(text(),'Complete Purchase')]

    Wait Until Element Is Visible    id=confirmation-page    5s
    Element Should Contain    id=confirmation-message    Thank you for your purchase

    Sleep    2s