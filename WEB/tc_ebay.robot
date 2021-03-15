*** Settings ***
Documentation   Scenario 2: Access a Product via Search
Library         SeleniumLibrary
Library         RequestsLibrary
Resource        ${EXECDIR}/WEB/keyword_ebay.robot
Test Teardown   Close All Browsers

*** Variables ***
${search_item}      MacBook
${category}         Computers/Tablets & Networking

*** Test Cases ***
Scenario 2: Access a Product via Search
    Go to www.ebay.com
    Type any search in the search bar      ${search_item}
    Change the Search category              ${category}
    Verify that the page loads completely
    Verify that the first result name matches with the search       ${search_item}      ${category}
    Close Browser
