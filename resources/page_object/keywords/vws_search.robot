*** Settings ***
Library  SeleniumLibrary
Library    OperatingSystem
Variables  ../locators/locators.py

*** Keywords ***
Verify Search Results
    Wait Until Page Contains Element    css:span[aria-current="page"]
    Element Should Contain    css:span[aria-current="page"]    Zoeken
    ${current_url}=    Get Location
    Should Contain    ${current_url}    /zoeken
    Log To Console    Search results page successfully verified\n

Verify Search Result Contains And Click
    [Arguments]    ${expected_text}
    Wait Until Page Contains Element    css:h3
    ${h3_elements}=    Get WebElements    css:h3
    ${found}=    Set Variable    False
    FOR    ${element}    IN    @{h3_elements}
        ${text}=    Get Text    ${element}
        ${contains}=    Run Keyword And Return Status    Should Contain    ${text}    ${expected_text}
        IF    ${contains}
            ${found}=    Set Variable    True
            Log To Console    Search result found with text: "${text}" - click on element
            Click Element    ${element}
            BREAK
        END
    END
    Should Be True    ${found}    No search result found with text: "${expected_text}"
    Log To Console    Search result clicked successfully

Verify Document Title On Current Page
    [Arguments]    ${expected_title}
    Wait Until Page Contains Element    css:h1.download
    ${actual_title}=    Get Text    css:h1.download
    Should Be Equal    ${actual_title}    ${expected_title}
    Log To Console    Document title correct: "${actual_title}"\n

Click On Download URL
    Wait Until Page Contains Element    css:.download a[href$=".pdf"]
    Click Element    css:.download a[href$=".pdf"]
    Log To Console    Download URL clicked\n