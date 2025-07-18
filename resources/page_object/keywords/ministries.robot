*** Settings ***
Library  SeleniumLibrary
Variables  ../locators/locators.py

*** Keywords ***

Verify Ministeries Page Is Loaded
    Wait Until Page Contains Element    css:h1
    Location Should Contain    /ministeries
    Page Should Contain    Ministeries
    Log To Console    Ministries page successfully loaded

Click On Menu Item
    [Arguments]    ${menu_selector}
    Wait Until Page Contains Element    ${menu_selector}
    Click Element    ${menu_selector}
    Log To Console    Menu item clicked: ${menu_selector}\n