*** Settings ***
Library    SeleniumLibrary
Variables    ../Variables/customerpage.py

*** Keywords ***
Display Users With Spending
    Log To Console    \n
    ${row}=    Set Variable    1
    ${table_rows}=    Get Element Count    ${table}
    ${counter}=    Set Variable    1

    FOR    ${index}    IN RANGE    ${table_rows}
        ${name}=    Get Text    ((${table})[${row}]//td)[2]
        ${total_spent}=    Get Text    ((${table})[${row}]//td)[5]
        ${total_spent_clean}=    Evaluate    str("""${total_spent}""").replace(",", "").replace("$", "").strip()
        ${total_spent_value}=    Convert To Number    ${total_spent_clean}
        IF    ${total_spent_value} > 0
            Log To Console    ${counter}. ${name}: ${total_spent}
            ${counter}=    Evaluate    ${counter}+1
        END
        ${row}=    Evaluate    ${row}+1
    END

    Sleep    10s

Calculate Total Spending
    ${row}=    Set Variable    1
    ${table_rows}=    Get Element Count    ${table}
    ${total}=    Set Variable    0

    FOR    ${index}    IN RANGE    ${table_rows}
        ${total_spent}=    Get Text    ((${table})[${row}]//td)[5]
        ${total_spent_clean}=    Evaluate    str("""${total_spent}""").replace(",", "").replace("$", "").strip()
        ${total_spent_value}=    Convert To Number    ${total_spent_clean}
        ${total}=    Evaluate    ${total}+${total_spent_value}
        ${row}=    Evaluate    ${row}+1
    END

    Log To Console    \n==============================
    Log To Console    \nTotal spending of all customers: $${total}
    Log To Console    \n==============================\n

Validate Total Spending
    ${row}=    Set Variable    1
    ${table_rows}=    Get Element Count    ${table}
    ${total}=    Set Variable    0

    FOR    ${index}    IN RANGE    ${table_rows}
        ${total_spent}=    Get Text    ((${table})[${row}]//td)[5]
        ${total_spent_clean}=    Evaluate    str("""${total_spent}""").replace(",", "").replace("$", "").strip()
        ${total_spent_value}=    Convert To Number    ${total_spent_clean}
        ${total}=    Evaluate    ${total} + ${total_spent_value}
        ${row}=    Evaluate    ${row} + 1
    END

    ${total_rounded}=    Evaluate    round(${total}, 2)
    ${threshold}=    Set Variable    3500

    IF    ${total_rounded} < ${threshold}
        Log To Console    FAIL: Total spending (${total_rounded}) is below minimum threshold ($3,500)
        Fail    Total spending ($${total_rounded}) is below minimum threshold ($3,500)
    ELSE
        Log To Console    PASS: Total spending ($${total_rounded}) meets minimum threshold ($3,500)
    END

