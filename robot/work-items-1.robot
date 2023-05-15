*** Settings ***
Documentation       Testing Cloud Work Items

Library             RPA.Robocorp.WorkItems


*** Variables ***
${TARGET_DIR}       %{ROBOT_ROOT}/Caption


*** Tasks ***
Get Work Item
    ${wi} =    Get Work Item Variable    number of months
    Log    ${wi}
    # Set Work Item Variable    name    value
