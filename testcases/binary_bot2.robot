*** Settings ***
Resource          ../common/resource.robot
Resource      ../common/create_account_resource.robot
Library           OperatingSystem
Library             Selenium2Library

*** Variables ***
${TEST FILE URL 1}  ../binary-bot-tests/test-tools.xml
${TEST 1 ALERT}      "Successful: 8 / Failed: 0"

*** Test Cases ***
Test One
    Login To Binary Bot
    Choose File xpath=//form[@id="fileUploadForm"]/input ${TEST FILE URL 1}
    Sleep 10s
    Click Element   xpath=//button[@id="runButton"]
    ${message} = Handle Alert timeout=30s
    Should Be Equal ${message} ${TEST 1 ALERT}


*** Keywords ***
Login To Binary Bot
    Click Element   xpath=//div[@class="intro-login-logout"]/div/button[@id="login"]
    Sleep  5
    wait until element is visible   login
    Input Username  ${VALID USER}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    ${GRANT} =          run keyword and return status  page should not contain   Review Permissions
    run keyword if   ${GRANT}!=1    Grant Permission
    Sleep  10
    Click Element   css=div.account-id
    Click Element   css=div>a>li
    Sleep 10
