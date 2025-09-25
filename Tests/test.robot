*** Settings ***
Resource    ../Resources/App.resource
Resource    ../Resources/Task1.resource
Resource    ../Resources/Task2.resource
Resource    ../Resources/Task3.resource
Resource    ../Resources/Task4.resource
Resource    ../Resources/Task5.resource
Library     ../Library/CustomLibrary.py

Suite Setup    Launch Browser

*** Test Cases ***

TC-00001 ADD FIRST 5 USERS
    [Documentation]    Add first 5 users
    Login Customer
    Sleep    3s
    Go To Customers Page
    Add Customers

TC-00002 VERIFY TABLE DISPLAY
    [Documentation]    Verify table display
    Go To Customers Page
    Verify User In Table

TC-00003 UPDATE EXISTING CUSTOMERS
    [Documentation]    Update existing customers
    Update User In Table
    
TC-00004 LOG TABLE DATA
    [Documentation]    Log table data
    Log Table Data

TC-00005 ANALYZE CUSTOMER SPENDING
    [Documentation]    Analyze customer spending
    Display Users With Spending
    Calculate Total Spending
    Validate Total Spending


    