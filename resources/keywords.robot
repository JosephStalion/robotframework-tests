*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
Open Browser To Homepage
    Open Browser    ${URL}    edge
    Maximize Browser Window

Consent Data
    [Documentation]    Clicks the consent button to accept data policy.
    Wait Until Element Is Visible    ${CONSENT_BUTTON}    20s
    Click Element    ${CONSENT_BUTTON}
    Wait Until Element Is Not Visible    xpath=//div[@class="fc-dialog-overlay"]    10s

Go To Products Page
    [Documentation]  Clicks on the element Products to navigate to it
    Click Element    ${PRODUCTS_PAGE}

Search For Product
    [Documentation]     Searches for the product
    [Arguments]    ${product_name}
    Input Text      ${SEARCH_BOX}    ${product_name}
    Click Button    ${SEARCH_BUTTON}
    Wait Until Element Is Visible    ${SEARCH_RESULTS}

Scroll To Middle Of Page
    [Documentation]  Scrolls to the middle of the page to make the the "Add to Cart" visible
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight / 2);

Add Products To Cart
    [Documentation]  Adds product to the cart
    [Arguments]    ${quantity}
    FOR    ${index}    IN RANGE    1    ${quantity}+1
        # Wait for the "Add to Cart" button to be visible
        Wait Until Element Is Visible    ${ADD_TO_CART.replace("{index}", str(${index}))}    10s
        # Click on the "Add to Cart" button
        Click Element    ${ADD_TO_CART.replace("{index}", str(${index}))}
        Sleep    1s

        # Wait for the popup to appear and "Continue Shopping" to be visible
        Wait Until Element Is Visible    ${CONTINUE_SHOPPING}    10s
        # Click "Continue Shopping" to close the popup
        Click Element    ${CONTINUE_SHOPPING}
        Sleep    1s
    END

Go To Cart
    [Documentation]  Navigates to the Cart Page
    Click Element    ${CART_BUTTON}
    Wait Until Page Contains Element    ${PROCEED_TO_CHECKOUT}

Verify Cart Is Not Empty
    [Documentation]    This keyword verifies that the cart contains at least one item by checking the presence of a product in the cart.
    ${cart_item}=    Run Keyword And Return Status    Element Should Not Be Visible    ${EMPTY_CART}
    Should Be True    ${cart_item}    Cart is empty, no products found in the cart.

Proceed To Checkout
    [Documentation]  Navigates to the checkout page
    Click Element    ${PROCEED_TO_CHECKOUT}

Login
    [Arguments]    ${email}    ${password}
    Input Text      ${LOGIN_EMAIL}    ${email}
    Input Text      ${LOGIN_PASSWORD}    ${password}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    //a[text()=' Logged in as ']

Verify User Is Logged In
    [Documentation]  Verifies that the user is logged in by checking the presence of the 'Logged in as text.
    Wait Until Element Is Visible  ${LOGGED_IN_TEXT}   10s
    Element Should Contain  ${LOGGED_IN_TEXT}   Logged in as autexercise

Scroll To Bottom Of Page
    [Documentation]    Scrolls to the bottom of the page using JavaScript.
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)

Place Order
    [Documentation]    Scrolls the page to the "Place Order" button to make it clickable.
    Scroll Element Into View    ${PLACE_ORDER}
    Click Element    ${PLACE_ORDER}

Fill Payment Information
    [Documentation]  Fills Payment Information, name, card, CVC, expiry month, expiry year and confirms the order
    [Arguments]    ${name}    ${number}    ${cvc}    ${expiry_month}    ${expiry_year}
    Input Text      ${CARD_NAME}         ${name}
    Input Text      ${CARD_NUMBER}       ${number}
    Input Text      ${CVC}               ${CVC_VALUE}
    #Wait Until Element Is Visible    ${EXPIRY_MONTH}    30s    0.5s
    Input Text      ${EXPIRY_MONTH}      ${EXPIRY_MONTH_VALUE}
    Input Text      ${EXPIRY_YEAR}       ${EXPIRY_YEAR_VALUE}
    Click Element   ${CONFIRM_ORDER}

Verify Order Confirmation
    [Documentation]  It confirms that through the keyword that Order is confirmed
    Wait Until Page Contains Element    ${ORDER_CONFIRMED}
