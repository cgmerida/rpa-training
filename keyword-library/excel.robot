*** Settings ***
Documentation       Excel Operation Keyword File

Library             RPA.Tables
Library             RPA.Excel.Files
Library             String
# +


*** Keywords ***
Read Excel File WorkSheet As Table
    [Arguments]    ${EXCEL_FILE}    ${WORK_SHEET_NAME}
    Open Workbook    ${EXCEL_FILE}
    ${worksheet} =    Read Worksheet    name=${WORK_SHEET_NAME}    header=${TRUE}
    Close Workbook
    ${policies} =    Create table    ${worksheet}
    RETURN    ${policies}

Create New WorkBook From Map
    [Arguments]    ${EXCEL_FILE_NAME}
    Create Workbook    ${EXCEL_FILE_NAME}
    FOR    ${index}    IN RANGE    15
        ${ret} =    Generate Random String
        &{row} =    Create Dictionary
        ...    Order ID    ${index}
        ...    Amount    ${index * 25}
        ...    Invoice No    ${ret}
        Append Rows to Worksheet    ${row}    header=${TRUE}
    END
    Save Workbook

Iterate WorkSheets From Workbook
    [Arguments]    ${EXCEL_FILE}
    Open Workbook    ${EXCEL_FILE}
    @{work_sheets} =    List Worksheets
    FOR    ${work_sheet}    IN    @{work_sheets}
        ${wsheet_data} =    Read Worksheet    ${work_sheet}
        ${rows} =    Get Length    ${wsheet_data}
        ${emp_row} =    Find Empty Row    ${work_sheet}
        Log    Worksheet '${work_sheet}' conatin ${rows} rows with first empty row at ${emp_row}
    END
    Close Workbook
