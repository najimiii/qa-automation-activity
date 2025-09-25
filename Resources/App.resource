*** Settings ***
Library    SeleniumLibrary
Variables    ../Variables/variables.py
Variables    ../Variables/loginpage.py

*** Keywords ***

Launch Browser
    [Arguments]    ${url}=${URL}
    Open Browser   ${url}   chrome    options=add_argument("--start-maximized")
    Wait Until Keyword Succeeds    5x    .5s    Wait Until Element Is Visible    ${login_txt_username}

Login Customer
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Input Text    ${login_txt_username}    ${username}
    Input Text    ${login_txt_password}    ${password}
    Click Button    ${login_btn_submit}

    ${status}   Run Keyword And Return Status    Element Should Be Visible    ${dashboard_header}

    IF    {${status}}
        Log To Console    "Login Successful"
    ELSE
        Log To Console    "Login Failed"
    END

Refresh Current Page
    Click Button    ${btn_refresh}
    Wait Until Element Is Visible    ${loading_icon}
    Wait Until Element Is Not Visible    ${loading_icon}
