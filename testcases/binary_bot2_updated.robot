*** Settings ***
Resource          ../common/resource.robot
Resource      ../common/create_account_resource.robot
Library           OperatingSystem
Library             Selenium2Library

*** Variables ***
${TEST FILE URL 1}      ${EXECDIR}${/}common/test-tools.xml
${TEST 1 ALERT}         Successful: 1 / Failed: 0
${TEST 2 ALERT}         Successful: 3 / Failed: 0
${TEST 3 ALERT}         Successful: 4 / Failed: 0
${BROWSER}        Chrome
${HOME URL}      https://bot.binary.com/bot.html

*** Test Cases ***
Test Tools
    Login To Binary Bot
    Choose File  xpath=//form[@id="fileUploadForm"]/input    ${TEST FILE URL 1}
    Sleep   10
    Click Element   xpath=//a[@class="button-secondary"]/span
    Click Element   xpath=//button[@id="runButton"]
    ${message} =    Handle Alert   timeout=30 s
    Should Be Equal     ${message}      ${TEST 1 ALERT}
    ${message} =    Handle Alert   timeout=30 s
    Should Be Equal     ${message}      ${TEST 2 ALERT}
    ${message} =    Handle Alert   timeout=30 s
    Should Be Equal     ${message}      ${TEST 3 ALERT}
#    Testing


*** Keywords ***
Testing
#    Handle Alert   timeout=30 s
#    set global variable     ${message}

Login To Binary Bot
    Open Browser    ${HOME URL}    ${BROWSER}
    wait until element is visible   id=login
    Click Element   id=login
    wait until element is visible   login
    Input Username  ${VALID USER}
    Input Password  ${VALID PASSWORD}
    Submit Credentials
    ${GRANT} =          run keyword and return status  page should not contain   Review Permissions
    run keyword if   ${GRANT}!=1    Grant Permission
    Sleep  10
    Click Element   css=div.account-id
    Click Element   css=div>a>li
    Sleep   10
