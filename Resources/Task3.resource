*** Settings ***
Variables    ../Variables/customerpage.py
Library     ../Library/CustomLibrary.py
Resource    ../Resources/Task1.resource


*** Keywords ***
Update User In Table
    ${users}=    Get Last 5 Users
    Go To Customers Page

    ${row}=    Set Variable    6
    FOR    ${user}    IN    @{users}
        Click Element    (${table})[${row}]
        Change User Information    ${user}
        ${row}=    Evaluate    ${row}+1
    END

Clear And Fill Input
    [Arguments]    ${locator}    ${value}
    Click Element    ${locator}
    Press Keys    ${locator}    CTRL+a    BACKSPACE
    Input Text    ${locator}    ${value}

Change User Information
    [Arguments]    ${user}
    Wait Until Element Is Visible    ${customer_txt_first_name}
    
    Clear And Fill Input    ${customer_txt_first_name}    ${user["name"].split(" ")[0]}
    Clear And Fill Input    ${customer_txt_last_name}    ${user["name"].split(" ")[1]}
    Clear And Fill Input    ${customer_txt_email}    ${user["email"]}
    Input Text    ${customer_txt_birthday}    ${user["birthday"]}
    Clear And Fill Input    ${customer_txt_address}    ${user["address"]["street"]} ${user["address"]["suite"]}
    Clear And Fill Input    ${customer_txt_city}    ${user["address"]["city"]}
    Clear And Fill Input    ${customer_txt_state}    ${user["state"]}
    Clear And Fill Input    ${customer_txt_zipcode}    ${user["address"]["zipcode"]}
    Clear And Fill Input    ${customer_txt_password}    ${user["password"]}
    Clear And Fill Input    ${customer_txt_confirm_password}    ${user["password"]}
    
    Click Button    ${customer_btn_submit}
    Wait Until Page Contains    Customer updated
    Log To Console    Updated customer: ${user["name"]}
    Go To Customers Page


