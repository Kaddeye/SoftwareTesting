*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close Browser

*** Variables ***
${URL}    https://Kaddeye.github.io/SoftwareTesting/swag_labs.html
${BROWSER}    chrome

*** Test Cases ***
Full User Journey - Swag Labs

    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    # 1. Login
    Input Text    id=username    standard_user
    Input Text    id=password    secret_sauce
    Click Button    id=login-button

    Wait Until Element Is Visible    id=products-grid    5s

    # 2. Add multiple items
    Click Button    xpath=(//button[contains(text(),'Add to Cart')])[1]
    Click Button    xpath=(//button[contains(text(),'Add to Cart')])[2]

    Sleep    1s

    # 3. Go to checkout
    Click Element    css=.cart-icon

    Wait Until Element Is Visible    id=checkout-page    5s

    # Remove one item
    Click Button    xpath=(//button[contains(text(),'Remove')])[1]

    Sleep    1s

    # 4. Fill checkout form
    Input Text    id=first-name    Test
    Input Text    id=last-name    User
    Input Text    id=postal-code    12345

    Click Button    xpath=//button[contains(text(),'Complete Purchase')]

    # 5. Verify confirmation
    Wait Until Element Is Visible    id=confirmation-page    5s
    Element Should Contain    id=confirmation-message    Thank you for your purchase

    Sleep    2s