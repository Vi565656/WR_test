*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary

*** Variables ***
${alias}=           run
${payload}=         none
${base_url}=        https://run.mocky.io/v3/
${data_json}=       ${EXECDIR}/API/data.json
${params}=          none


*** Keywords ***
Start API Connection
    [Arguments]     ${URI}
    Create Session                  ${alias}     ${URI}     verify=True    

Send POST Request API
    [arguments]             ${URI}      ${data_json}        ${payload}
    ${response}=            Post Request    ${alias}        uri=${URI}     data=${data_json}
    Log                     ${response.content}
    Log                     ${response.headers}
    [Return]                ${response}

Send GET Request API
    [arguments]             ${URI}      ${params}
    ${response}=            Get Request     ${alias}    ${URI}      params=${params}
    Log                     ${response.content}
    Log                     ${response.headers}
    [return]                ${response}

*** Test Cases ***
Exercise 3 - TC1 response_code [200]
    [Documentation]     TC Send valid parameter
    ...                 Status Code 200. this code appears when data is working properly
    ${URI}=     Set Variable        ${base_url}48de0e04-cc19-4c9e-837f-15e312eac886
    Start API Connection        ${URI}
    ${response}=    Send GET Request API     ${URI}      ${params}
    Run Keyword And Continue On Failure     Should Be Equal As Strings  ${response.status_code}     200
    Run Keyword And Continue On Failure     Should Be Equal As Strings  ${response.json()['metadata']['message']}    Get data [200] OK

Exercise 3 - TC2 response_code [500]
    [Documentation]     Status Code 500. 
    ...                 this code appears when the server encountered an unexpected condition that prevented it from fulfilling the request
    ${URI}=     Set Variable        ${base_url}aeba51c0-d5df-4aca-be37-5c369d613b3b
    Start API Connection        ${URI}
    ${response}=    Send GET Request API     ${URI}      ${params}
    Run Keyword And Continue On Failure     Should Be Equal As Strings  ${response.status_code}     500
    Run Keyword And Continue On Failure     Should Be Equal As Strings  ${response.json()['message']}     Failed connecting to server [500]

Exercise 3 - TC3 response_code [400]
    [Documentation]     Send Not Found Parameter
    ...                 this code appears when Server does not understand client request syntax
    ${URI}=     Set Variable        ${base_url}8f247270-d93c-4428-8ab0-4d1081e6d3ea
    Start API Connection        ${URI}
    ${response}=    Send GET Request API     ${URI}      ${params}
    Run Keyword And Continue On Failure     Should Be Equal As Strings  ${response.status_code}     400
    Run Keyword And Continue On Failure     Should Be Equal As Strings  ${response.json()['message']}     Invalid Paramater request [400]

Exercise 3 - TC4 response_code [404]
    [Documentation]     TC Send valid parameter
    ...                 The HTTP 404 Not Found client error response code indicates that the server can't find the requested resource. 
    ...                 Links that lead to a 404 page are often called broken or dead links
    ${URI}=     Set Variable        ${base_url}e1fbf600-4024-44f1-9f63-2eeab6f8127b
    Start API Connection        ${URI}
    ${response}=    Send GET Request API     ${URI}      ${params}
    Run Keyword And Continue On Failure     Should Be Equal As Strings  ${response.status_code}     404
    Run Keyword And Continue On Failure     Should Be Equal As Strings  ${response.json()['message']}     Not Found Request [404]
