*** Settings ***
Variables    ../Variables/customerpage.py
Library     ../Library/CustomLibrary.py
Library     String
Library     SeleniumLibrary


*** Keywords ***
Verify User In Table
    ${customers_to_be_verified}=    Get Random Users
    ${reversed_users}=    Reverse List    ${customers_to_be_verified}

    ${row}=    Set Variable    1
    FOR    ${user}    IN    @{reversed_users}
        ${user_in_table}=    Get Text    ((${table})[${row}]//td)[2]
        IF    "\\n" in """${user_in_table}"""
            ${user_in_table}    Evaluate    """${user_in_table}""".replace("\\n", " ")[1:].strip()
        END
        Should Be Equal As Strings   ${user_in_table}    ${user["name"]}
        ${row}=    Evaluate    ${row}+1
        Log To Console    Found customer in table: ${user_in_table}
    END



