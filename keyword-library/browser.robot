*** Settings ***
Documentation       Browser Related Keyword Flow

Library             RPA.Browser.Selenium
Library             Collections


*** Variables ***    ***
# DOWNLOAD CHOME DRIVER : https://chromedriver.chromium.org/downloads
# ${DRIVER_PATH}    /Users/sandipmac/Projects/RoboCorp RPA/FirstRPAProj/browser-driver/chromedriver
${SourceLanButton}      //button[@aria-label="More source languages"]
${DestLanButton}        //button[@aria-label="More target languages"]
${SourceLanText}        //input[@aria-label="Search languages"]
${srcTextArea}          //textarea[@aria-label="Source text"]
${copyClipButton}       //button[@aria-label="Copy translation"]
${clearText}            //button[@aria-label="Clear source text"]

# +


*** Keywords ***
Open Google Translate Page
    Set Selenium Timeout    30
    Open Browser    https://translate.google.com/    browser=Chrome
    Wait Until Element Is Visible    ${SourceLanButton}

Set Source Language
    [Arguments]    ${SourceLan}
    Click Element    ${SourceLanButton}
    Input Text When Element Is Visible    ${SourceLanText}    ${SourceLan}
    sleep    1
    Click Element At Coordinates    ${SourceLanText}    xoffset=0    yoffset=60
    sleep    1

Set Target Language
    [Arguments]    ${DesLan}
    Click Element    ${DestLanButton}
    Input Text When Element Is Visible    dom:document.activeElement    ${DesLan}
    Sleep    1
    Click Element At Coordinates    dom:document.activeElement    xoffset=0    yoffset=60
    Sleep    1

Convert Sentence And Copy To ClipBoard
    [Arguments]    ${sentence}
    Input Text When Element Is Visible    ${srcTextArea}    ${sentence}
    # Wait Until Element Is Visible    ${copyClipButton}
    # Click Element    ${copyClipButton}
    Click Button When Visible    ${copyClipButton}
    sleep    1
    Click Element    ${clearText}

Close Current Browser
    sleep    2
    Close Browser
