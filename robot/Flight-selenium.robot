*** Settings ***
Documentation       Book the cheapest flight to location

Library             RPA.Browser.Selenium
Library             Collections


*** Variables ***
${FROM}     Mexico City
${TO}       Berlin


*** Tasks ***
Reserve Flights
    Open Browser    https://blazedemo.com/    browser=chrome
    Select Single value from Select    css:select.form-inline[name=fromPort]    ${FROM}
    Select Single value from Select    css:select.form-inline[name=toPort]    ${TO}
    Click Button    Find Flights
    Location Should Contain    reserve

    ${rows} =    Get WebElements    tag:table >> tag:tbody >> tag:tr
    ${rows_len} =    Get Length    ${rows}
    ${limit} =    Evaluate    ${rows_len} + ${2}

    ${prices} =    Create List

    # # Ignore the header
    FOR    ${i}    IN RANGE    2    ${limit}
        ${cell} =    Get Table Cell    tag:table    ${i}    ${-1}
        Append To List    ${prices}    ${cell}
    END

    ${best_deal} =    Evaluate    min(${prices})
    ${best_deal_idx} =    Evaluate    ${prices}.index('${best_deal}')+1

    Click Element    tag:table >> tag:tbody >> css:tr:nth-child(${best_deal_idx}) >> tag:input

    Location Should Contain    purchase

    Click Button    Purchase Flight

    ${header} =    Get WebElement    tag:h1
    ${success_txt} =    Get Text    ${header}

    Should Be Equal    ${success_txt}    Thank you for your purchase today!

    Capture Page Screenshot


*** Keywords ***
Select Single value from Select
    [Arguments]    ${select}    ${value}
    ${from_select} =    Get WebElement    ${select}
    Select From List By Value    ${from_select}    ${value}
