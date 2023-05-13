*** Settings ***
Documentation       RPA Browser Related Keywords Example

Resource            ../keyword-library/browser.robot
Library             RPA.FileSystem
Library             String
Library             RPA.Desktop


*** Variables ***
${SRC_DIR}          ./data-sets/Captions
${TARGET_LANG}      French
${status}           ${False}


*** Tasks ***
Example of Browser Selenium Library
    Open Google Translate Page
    Set Source Language    English
    Set Target Language    ${TARGET_LANG}

    ${DIR_NAME} =    Catenate    SEPARATOR=/    ${SRC_DIR}    ${TARGET_LANG}
    Create Directory    ${DIR_NAME}

    ${files} =    List Files In Directory    ${SRC_DIR}
    FOR    ${file}    IN    @{files}
        ${ext} =    Get File Extension    ${file}
        IF    "${ext}" != ".vtt"            CONTINUE

        ${src_file_name} =    Get File Name    ${file}
        ${DEST_FILE_NAME} =    Catenate    SEPARATOR=/    ${DIR_NAME}    ${src_file_name}
        Create File    ${DEST_FILE_NAME}

        Convert Document    ${file}    ${DEST_FILE_NAME}
    END


*** Keywords ***
Convert Document
    [Arguments]    ${file}    ${DEST_FILE_NAME}
    ${FileContent} =    Read File    ${file}
    ${content} =    Split To Lines    ${FileContent}

    FOR    ${line}    IN    @{content}
        IF    ${status}
            Convert Sentence And Copy To ClipBoard    ${line}
        ELSE
            Set clipboard value    ${line}
        END

        ${converted_text} =    Get Clipboard Value
        Append To File    ${DEST_FILE_NAME}    ${converted_text}${\n}

        ${status} =
        ...    Run Keyword And Return Status
        ...    Should Contain    ${line}    -->
    END
