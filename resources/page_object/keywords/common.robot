
*** Settings ***
Documentation     Gemeenschappelijke resources en keywords voor alle tests
Library           SeleniumLibrary
Library           RequestsLibrary
Library           BuiltIn
Library           ${CURDIR}/../../tools/string_utils.py
Library           Process
Library           OperatingSystem
Variables         ${CURDIR}/../locators/locators.py

*** Variables ***
${DEFAULT_TIMEOUT}    10s
${SCREENSHOT_DIR}    ${CURDIR}/../../results/screenshots
${DOWNLOAD_DIR}    ${CURDIR}/../../pdf_compare/to_verify
${BASELINE_DIR}    ${CURDIR}/../../pdf_compare/baseline

*** Keywords ***
Take Screenshot On Failure
    Run Keyword If Test Failed    Capture Page Screenshot    ${SCREENSHOT_DIR}/failure_${TEST_NAME}.png

Wait For Element And Click
    [Arguments]    ${locator}    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Click Element    ${locator}

Wait For Element And Input Text
    [Arguments]    ${locator}    ${text}    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

Verify Page Title Contains
    [Arguments]    ${expected_text}
    ${title}=    Get Title
    Should Contain    ${title}    ${expected_text}    ignore_case=True

Verify Element Text Contains
    [Arguments]    ${locator}    ${expected_text}
    ${actual_text}=    Get Text    ${locator}
    Should Contain    ${actual_text}    ${expected_text}    ignore_case=True

Navigate To URL And Verify
    [Arguments]    ${url}    ${expected_element}
    Go To    ${url}
    Wait Until Element Is Visible    ${expected_element}    timeout=${DEFAULT_TIMEOUT}

Open Browser Setup
    [Arguments]    ${browser}=${BROWSER}    ${download_dir}=${DOWNLOAD_DIR}
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    &{prefs}=    Create Dictionary    download.default_directory=${DOWNLOAD_DIR}    plugins.plugins_disabled=['Chrome PDF Viewer']
    Call Method    ${chrome options}    add_experimental_option    prefs    ${prefs}
    ${arg}=    Set Variable    --log-level=3
    Call Method    ${chrome options}    add_argument    ${arg}
    ${arg}=    Set Variable    --disable-logging
    Call Method    ${chrome options}    add_argument    ${arg}
    Open Browser    about:blank    ${BROWSER}    options=${chrome options}
    Maximize Browser Window
    Set Selenium Speed    0.5s

# PDF compare functions
Create Download Directory When Not Present
    [Arguments]    ${dir}
    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${dir}
    IF    not ${exists}
        Create Directory    ${dir}
    END
    Log To Console    Download directory created or already exists: ${dir}\n        ${dir}

Remove Files In Directory
    [Arguments]    ${dir}
    ${files}=    List Files In Directory    ${dir}
    FOR    ${file}    IN    @{files}
        Remove File    ${dir}/${file}
    END

Download PDF To Folder
    [Arguments]    ${download_dir}
    Create Directory    ${download_dir}
    ${pdf_link}=    Get Element Attribute    css:.download a[href$=".pdf"]    href
    Log To Console    PDF link found: ${pdf_link}
    # Download the file
    ${file_name}=    Get File Name From Url    ${pdf_link}
    ${target_path}=    Set Variable    ${download_dir}/${file_name}
    Download File    ${pdf_link}    ${target_path}
    Sleep    5s
    Log To Console    PDF downloaded to: ${target_path}\n

Get File Name From Url
    [Arguments]    ${url}
    ${file_name}=    Extract File Name From Url    ${url}
    [Return]    ${file_name}

Download File
    [Arguments]    ${url}    ${target_path}
    Evaluate    __import__('urllib3').disable_warnings()    sys
    Create Session    session    ${url}    verify=False
    ${resp}=    GET On Session    session    ${url}
    write_binary_file    ${target_path}    ${resp.content}
    Delete All Sessions

Compare Downloaded PDF With Baseline
    [Arguments]    ${downloaded}    ${baseline}
    File Should Exist    ${baseline}    Baseline PDF not found: ${baseline}
    ${downloaded_text}=    Get Text From PDF    ${downloaded}
    ${baseline_text}=    Get Text From PDF    ${baseline}
    Should Be Equal    ${downloaded_text}    ${baseline_text}    PDF texts differ!
    Log To Console    PDF texts are identical\n

Get Text From PDF
    [Arguments]    ${pdf_path}
    ${result}=    Run Process    python   ${CURDIR}/../../tools/extract_pdf_text.py    ${pdf_path}    shell=True    stdout=STDOUT    stderr=STDERR
    ${text}=    Set Variable    ${result.stdout}
    Run Keyword If    ${result.rc} != 0    Log    ${result.stderr}    ERROR
    Should Be Equal As Strings    ${result.rc}    0    PDF text extraction failed! See log for details.
    [Return]    ${text}

