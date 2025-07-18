*** Settings ***
Library  SeleniumLibrary
Library    OperatingSystem
Variables  ../locators/locators.py

*** Keywords ***
Click Search Button
    Wait Until Page Contains Element    css:button#search-submit
    Click Element    css:button#search-submit
    Log To Console    Search button clicked - search field opened\n

Fill Search Field With Term
    [Arguments]    ${search_term}
    Wait Until Page Contains Element    css:input#search-keyword
    Input Text    css:input#search-keyword    ${search_term}
    Log To Console    Search term '${search_term}' filled in\n

Submit Search
    Wait Until Page Contains Element    css:button#search-submit
    Click Element    css:button#search-submit
    # Wait for page navigation to search results
    Wait Until Location Contains    /zoeken
    Wait Until Page Contains Element    css:h1
    Log To Console    Search query submitted and results page loaded\n