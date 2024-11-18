*** Settings ***
Resource    ../resources/keywords.robot
Resource    ../resources/variables.robot
Resource    ../resources/locators.robot
Library     SeleniumLibrary

*** Test Cases ***
Complete Product Purchase Flow
    [Documentation]    Test for purchasing two products
    Open Browser To Homepage
    Consent Data
    Go To Products Page
    Search For Product    shirts
    Scroll To Middle Of Page
    Add Products To Cart  2
    Go To Cart
    Verify Cart Is Not Empty
    Proceed To Checkout
    Click Element    ${REGISTER_LOGIN}
    Login    ${USERNAME}    ${PASSWORD}
    Verify User Is Logged In
    Go To Cart
    Proceed To Checkout
    Scroll To Middle Of Page
    Place Order
    Fill Payment Information    ${CARD_NAME_VAL}    ${CARD_NUMBER_VAL}    ${CVC}    ${EXPIRY_MONTH}    ${EXPIRY_YEAR}
    Verify Order Confirmation
    [Teardown]    Close Browser
