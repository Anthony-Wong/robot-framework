*** Settings ***

*** Test Cases ***
Test Robot Framework Logging
    Log To Console    Test Logging

Test My Robot Framework Logging
    My Logging    My Message    WARN

*** Keywords ***
My Logging
    [Arguments]    ${msg}    ${level}
    Log To Console   ${msg}    ${level}