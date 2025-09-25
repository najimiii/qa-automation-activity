*** Settings ***
Library    SeleniumLibrary
Library    String
Variables    ../Variables/customerpage.py


*** Keywords ***
Log Table Data
    ${row}=    Set Variable    1
    ${table_rows}=    Get Element Count    ${table}

    FOR    ${index}    IN RANGE    ${table_rows}
        ${name}=    Get Text    ((${table})[${row}]//td)[2]
        ${last_seen}=    Get Text    ((${table})[${row}]//td)[3]
        ${orders}=    Get Text    ((${table})[${row}]//td)[4]
        ${total_spent}=    Get Text    ((${table})[${row}]//td)[5]
        ${latest_purchase}=    Get Text    ((${table})[${row}]//td)[6]
        ${groups}=    Get Text    ((${table})[${row}]//td)[8]
        
        IF    "\\n" in """${name}"""
            ${name}    Evaluate    """${name}""".replace("\\n", " ")[1:]
        END
        
        Log To Console    ===== ${name} =====
        Log To Console    Name: ${name}
        Log To Console    Last seen: ${last_seen}
        Log To Console    Orders: ${orders}
        Log To Console    Total Spent: ${total_spent}
        Log To Console    Latest Purchase: ${latest_purchase}
        Log To Console    Groups: ${groups}
        Log To Console    ===================\n
        
        ${row}=    Evaluate    ${row}+1
    END