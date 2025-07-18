*** Settings ***
Library  SeleniumLibrary
Library    OperatingSystem
Variables  ../locators/locators.py

*** Keywords ***


Navigate To Rijksoverheid Homepage
    Go To              https://www.rijksoverheid.nl/

Verify Rijksoverheid Homepage Header Text     
    Wait Until Page Contains Element    ${HeaderText}
    ${element_text}=   Get Text    ${HeaderText}
    Should Contain     ${element_text}    Rijksoverheid    ignore_case=True
    Log To Console    Rijksoverheid homepage successfully loaded and verified\n

Verify Rijksoverheid Homepage Breadcrumb
    ${level1}=    Get Text    ${Home}
    Should Be Equal    ${level1}    Home
    Should Not Exist   ${CurrentPage}
    Log To Console    Breadcrumb successfully verified\n

Verify Rijksoverheid Homepage
    Verify Rijksoverheid Homepage Header Text
    Verify Rijksoverheid Homepage Breadcrumb

Click On Ministeries Link
    Wait Until Page Contains Element    ${MinistriesLink}
    Click Element    ${MinistriesLink}
    Log To Console    Ministries link clicked\n