*** Settings ***
Resource    ../Resources/App.resource
Variables    ../Variables/customerpage.py
Library     ../Library/CustomLibrary.py


*** Keywords ***
Go To Customers Page
    Click Element    ${nav_btn_customers}
    Wait Until Element Is Visible    ${table}
    
Create Customer
    [Arguments]     ${user}
    Click Element    ${customers_btn_create}
    Wait Until Element Is Visible    ${customer_txt_first_name}
    Input Text    ${customer_txt_first_name}   ${user["name"].split(" ")[0]} 
    Input Text    ${customer_txt_last_name}   ${user["name"].split(" ")[1]}
    Input Text    ${customer_txt_email}   ${user["email"]}
    Input Text    ${customer_txt_birthday}    ${user["birthday"]}
    Input Text    ${customer_txt_address}   ${user["address"]["street"]} ${user["address"]["suite"]}
    Input Text    ${customer_txt_city}   ${user["address"]["city"]}
    Input Text    ${customer_txt_state}   ${user["state"]}
    Input Text    ${customer_txt_zipcode}   ${user["address"]["zipcode"]}
    Input Text    ${customer_txt_password}   ${user["password"]}
    Input Text    ${customer_txt_confirm_password}   ${user["password"]}
    Click Button    ${customer_btn_submit}
    Wait Until Page Contains    Customer created
    

Verify Customer Is Added
    [Arguments]    ${user}
    Wait Until Element Is Visible    ${customer_txt_first_name}

    ${first_name}=    Get Element Attribute    ${customer_txt_first_name}    value
    ${last_name}=    Get Element Attribute    ${customer_txt_last_name}    value
    ${email}=    Get Element Attribute    ${customer_txt_email}    value
    ${birthday_raw}=    Get Element Attribute    ${customer_txt_birthday}    value
    ${birthday_raw_str}=    Convert To String    ${birthday_raw}
    ${birthday}    Remove Birthday Dash    ${birthday_raw_str}
    ${address}=    Get Element Attribute    ${customer_txt_address}    value
    ${city}=    Get Element Attribute    ${customer_txt_city}    value
    ${state}=    Get Element Attribute    ${customer_txt_state}    value
    ${zipcode}=    Get Element Attribute    ${customer_txt_zipcode}    value
    ${password}=    Get Element Attribute    ${customer_txt_password}    value
    ${confirm_password}=    Get Element Attribute    ${customer_txt_confirm_password}    value

    Should Be Equal    ${password}    ${user["password"]}
    Should Be Equal    ${confirm_password}    ${user["password"]}
    Should Be Equal    ${first_name}    ${user["name"].split(" ")[0]}
    Should Be Equal    ${last_name}    ${user["name"].split(" ")[1]}
    Should Be Equal    ${email}    ${user["email"]}
    Should Be Equal     ${birthday}    ${user["birthday"]}
    Should Be Equal    ${address}    ${user["address"]["street"]} ${user["address"]["suite"]}
    Should Be Equal    ${city}    ${user["address"]["city"]}
    Should Be Equal    ${state}    ${user["state"]}
    Should Be Equal    ${zipcode}    ${user["address"]["zipcode"]}

    Log To Console     Customer ${user["name"]} is added successfully

Add Customers
    ${customer_to_be_added}     Get Random Users
    FOR    ${user}    IN    @{customer_to_be_added}
        ${user["state"]}    Generate Password    3
        Create Customer    ${user}
        Verify Customer Is Added    ${user}
        Go To Customers Page
    END