*** Settings ***
Library    AppiumLibrary
Resource    ../../keywords/Commons.robot
Resource    ../../keywords/BetaInfo/BetaInfo.robot
Suite Setup    RUN KEYWORDS    Open App    AND    Login With Password    AND    Get ScreenShot    BETAINFO
Suite Teardown    Close App

***Test Cases***
Verify if beta info screen is shown after sign in
    [Tags]    BetaInfo    Smoke
    Verify if beta info screen is shown after sign in

Verify if beta info description is visible
    [Tags]    BetaInfo    Smoke
    Verify if beta info description is visible

Verify if beta info image is visible
    [Tags]    BetaInfo    Smoke
    Verify if beta info image is visible

Verify if continue button on beta info is visible
    [Tags]    BetaInfo    Smoke
    Verify if continue button on beta info is visible

Verify if continue button on beta info redirects to intro tour
    [Tags]    BetaInfo    Smoke
    Verify if continue button on beta info redirects to intro tour