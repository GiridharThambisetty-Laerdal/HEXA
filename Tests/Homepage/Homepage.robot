*** Settings ***
Library    AppiumLibrary
Resource    ../../keywords/Commons.robot
Resource    ../../keywords/Homepage/Homepage.robot
Suite Setup    RUN KEYWORDS    Open App    AND    Get ScreenShot    HOMEPAGE
Suite Teardown    Close App

***Test Cases***
Verify if welcome screen contains welcome text
    [Tags]    Homepage    Smoke
    Verify if welcome screen contains welcome text

Verify if get help card is visible
    [Tags]    Homepage    Smoke
    Verify if get help card is visible

Verify if instructor card is visible
    [Tags]    Homepage    Smoke
    Verify if instructor card is visible

Verify if learner card is visible
    [Tags]    Homepage    Smoke
    Verify if learner card is visible

Verify if agreements section is visible
    [Tags]    Homepage    Smoke
    Verify if agreements section is visible

Verify if get help card redirects to correct page
    [Tags]    Homepage    Smoke
    Verify if get help card redirects to correct page

Verify if get started button redirects to correct page
    [Tags]    Homepage    Smoke
    Verify if get started button redirects to correct page

Verify if learner button redirects to correct page
    [Tags]    Homepage    Smoke
    Verify if learner button redirects to correct page

Verify if privacy policy link redirects to correct page
    [Tags]    Homepage    Smoke
    Verify if privacy policy link redirects to correct page

Verify if terms and conditions link redirects to correct page
    [Tags]    Homepage    Smoke
    Verify if terms and conditions link redirects to correct page