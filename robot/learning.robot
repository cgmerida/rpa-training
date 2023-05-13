*** Settings ***
Documentation       Template robot main suite.

Resource            keyword-library/excel.robot


*** Tasks ***
# Read Policies as Table
#    ${policy-data} =    Read Excel File WorkSheet As Table    ./data-sets/sampledatainsurance.xlsx    PolicyData
#    @{table-dim} =    Get Table Dimensions    ${policy-data}
#    ${table-row} =    Get Table Row    ${policy-data}    0

#    FOR    ${i}    IN RANGE    ${table-dim}[0]
#    ${row-data} =    Get Table Row    ${policy-data}    ${i}
#    Log    ${row-data}[BusinessType]
#    END

# Create New WorkSheet Task
#    Create New WorkBook From Map    new_workbook.xlsx
#    ${policy-data} =    Read Excel File WorkSheet As Table    new_workbook.xlsx    Sheet

Iterate WorkSheet Example
    Iterate WorkSheets From Workbook    ./data-sets/sampledatainsurance.xlsx
