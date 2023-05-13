*** Settings ***
Documentation       Playwright Travel Site Example

Library             RPA.Browser.Playwright
Library             String
# +


*** Variables ***
${TRAVEL_URL}           https://blazedemo.com/

${FROM_PORT}            //select[@name="fromPort"]
${TO_PORT}              //select[@name="toPort"]
${FIND_FLIGHT_BTN}      //input[@value="Find Flights"]

${PRICE_LIST}           //td[contains(text(), "$")]
${CHOOSE_FLIGHT_BTN}    //td[contains(text(), "PRICE")]//parent::tr//input[@value='Choose This Flight']

${T_A}                  [placeholder=\"First Last\"]
${PURCHASE}             text=Purchase Flight

${CONFIRM_TXT}          //h1[contains(text(), 'Thank you for your purchase today!')]

# +


*** Tasks ***
Book Flight Task Example
    Launch Site    ${TRAVEL_URL}
    Search Flight    Boston    London
    Book Flight Below Price    250
    Close Site


*** Keywords ***
Launch Site
    [Arguments]    ${url}
    New Browser    browser=chromium    headless=False
    New Context    acceptDownloads=True
    # Set Browser Timeout    timeout=120
    New Page    url=${url}

Search Flight
    [Arguments]    ${from_port_name}    ${to_port_name}
    Select Options By    ${FROM_PORT}    text    ${from_port_name}
    Select Options By    ${TO_PORT}    text    ${to_port_name}
    Click    selector=${FIND_FLIGHT_BTN}

Book Flight Below Price
    [Arguments]    ${price}
    @{ElemList} =    Get Elements    ${PRICE_LIST}
    FOR    ${elem}    IN    @{ElemList}
        ${text} =    Get Text    ${elem}
        ${actual_price} =    Convert Price Flight    ${text}
        IF    ${actual_price}<=${price}
            ${status} =    Book Flight    ${text}
        ELSE
            ${status} =    Set Variable    ${None}
        END
        IF    ${status}            BREAK
    END

Book Flight
    [Arguments]    ${text}
    ${selector} =    Replace String    ${CHOOSE_FLIGHT_BTN}    PRICE    ${text}
    Click    ${selector}
    Type Text    selector=${T_A}    txt=Sandip Ganguli    clear=True
    Click    selector=${PURCHASE}
    Wait For Elements State    selector=${CONFIRM_TXT}    state=visible
    RETURN    True

Convert Price Flight
    [Arguments]    ${pricetext}
    @{words_a} =    Split String    ${pricetext}    .
    @{words_b} =    Split String    ${words_a}[0]    $
    ${price_int} =    Convert To Integer    ${words_b}[1]
    RETURN    ${price_int}

Close Site
    Close Browser
# -
