*** Comments ***
This is a example test for the VWS ministry using Robot Framework.
Although the test is simple, it demonstrates the use of page objects and keywords for better maintainability and readability.
Also a more advanced feature is included where the contents (raw text) of a downloaded PDF is compared with a baseline PDF.

*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/page_object/keywords/common.robot
Resource          ../resources/page_object/keywords/rijksoverheid_home_page.robot
Resource          ../resources/page_object/keywords/ministries.robot
Resource          ../resources/page_object/keywords/VWS_home_page.robot
Resource          ../resources/page_object/keywords/VWS_search.robot
Library           RequestsLibrary
Library           BuiltIn
Library           ../resources/tools/string_utils.py
Library           Process
Library           OperatingSystem
Variables         ../resources/page_object/locators/locators.py
Suite Setup       Open Browser Setup
Suite Teardown    Close Browser

*** Variables ***
${BROWSER}        Chrome

*** Test Cases ***
Test Demo Ministry VWS pdf comparison
    
    # Setup
    Remove Files In Directory    ${DOWNLOAD_DIR}

    # Navigate to VWS page
    Navigate To Rijksoverheid Homepage
    Verify Rijksoverheid Homepage
    Click On Ministeries Link
    Verify Ministeries Page Is Loaded
    Scroll Element Into View    ${VWSLink}
    Click On Menu Item    ${VWSLink}

    # Search on page
    Click Search Button
    Fill Search Field With Term    filenet
    Submit Search
    Verify Search Results

    # Click search result
    Verify Search Result Contains And Click    Interim auditrapport baten-lastenagentschap Rijksvastgoedbedrijf 2022

    # Download and compare pdf with baseline
    Verify Document Title On Current Page    Interim auditrapport baten-lastenagentschap Rijksvastgoedbedrijf 2022
    Click On Download URL
    Download PDF To Folder    ${DOWNLOAD_DIR}
    Close Browser
    Compare Downloaded PDF With Baseline    ${DOWNLOAD_DIR}/interim-auditrapport-baten-lastenagentschap-rijksvastgoedbedrijf-2022.pdf    ${BASELINE_DIR}/interim-auditrapport-baten-lastenagentschap-rijksvastgoedbedrijf-2022.pdf
    




