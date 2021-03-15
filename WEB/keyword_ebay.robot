*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Resource        ${EXECDIR}/WEB/element_ebay.robot

***Keywords
Go to www.ebay.com
    Open Browser         url=${url}          browser=${browser}
    Maximize Browser Window

Type any search in the search bar
    [Arguments]         ${input}
    Wait Until Element Is Visible       ${txt_search}
    Input Text          ${txt_search}        ${input}

Change the Search category
    [Arguments]         ${category}
    Wait Until Element Is Visible       ${ddl_allCaterories}
    Wait Until Element Is Visible       //option[contains(text(),'${category}')]
    Wait Until Element Is Visible       ${btn_search}
    Click Element                       ${ddl_allCaterories}
    Click Element                       //option[contains(text(),'${category}')]
    Click Element                       ${btn_search}

Verify that the page loads completely
    Wait Until Page Contains Element           ${txt_verify_allList}

Verify that the first result name matches with the search
    [Arguments]     ${search_item}      ${category}
    Wait Until Element Is Visible       //span[contains(text(),'${search_item}')]
    Wait Until Element Is Visible       //span[contains(text(),'${category}')]


