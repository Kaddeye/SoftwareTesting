*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://kaddeye.github.io/SoftwareTesting/swag_labs.html

*** Test Cases ***
Swag Labs E2E Test
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage

    Create WebDriver    Chrome    options=${options}
    Go To    ${URL}

    Login
    Add Items To Cart
    Go To Checkout
    Checkout Process
    Verify Success Message

    [Teardown]    Close Browser


*** Keywords ***
Login
    Wait Until Page Contains Element    id=username    15s
    Input Text    id=username    standard_user
    Input Text    id=password    secret_sauce
    Click Button  id=login-button

    Wait Until Page Contains Element    id=product-page    15s


Add Items To Cart
    Wait Until Page Contains Element    xpath=//button[contains(text(), "Add to Cart")]    15s

    Click Button    xpath=(//button[contains(text(), "Add to Cart")])[1]
    Click Button    xpath=(//button[contains(text(), "Add to Cart")])[2]


Go To Checkout
    Wait Until Page Contains Element    id=cart-count    15s

    Click Element    xpath=//div[@class='cart-icon']

    Wait Until Page Contains Element    id=checkout-page    15s


Checkout Process
    Wait Until Page Contains Element    id=first-name    15s

    Input Text    id=first-name    Max
    Input Text    id=last-name     Mustermann
    Input Text    id=postal-code   12345

    Click Button    xpath=//button[contains(text(), "Complete Purchase")]

    Wait Until Page Contains Element    id=confirmation-page    15s


Verify Success Message
    Wait Until Page Contains    Thank You For Your Order!    15s