*** Settings ***
Library    AppiumLibrary
Library    Collections
Resource    ../Commons.robot
*** Keywords ***
Verify if welcome screen contains welcome text
    ${welcome_text_1}    Get Text    id=WelcomeView_Label_WelcomeView_Title
    ${welcome_text_2}    Get Text    id=WelcomeView_Label_WelcomeView_Description
    Should Be Equal As Strings    ${welcome_text_1}    Welcome to QCPR,
    Should Be Equal As Strings    ${welcome_text_2}    your app for quality feedback!
    Get ScreenShot    welcome_text

Verify if get help card is visible
    ${issues_with_sign_in_text}    Get Text    id=WelcomeView_Label_WelcomeView_Issues_SigningIn_With_Browser
    Should Contain    ${issues_with_sign_in_text}    Issues signing in with browser
    Should Contain    ${issues_with_sign_in_text}    Get Help
    Get ScreenShot    Get_Help

Verify if instructor card is visible
    Page Should Contain Element    id=WelcomeView_Button_GetStartedCommand
    Page Should Contain Text    Join for free to unlock more features
    Page Should Contain Text    Are you an instructor?
    Get ScreenShot    Instructor_Card

Verify if learner card is visible
    Page Should Contain Element    id=WelcomeView_Button_ContinueCommand
    Page Should Contain Text    Are you a learner?
    Page Should Contain Text    Continue to get individual feedback.
    Get ScreenShot    Learner_Card

Verify if agreements section is visible
    Page Should Contain Element    id=WelcomeView_Label_WelcomeView_Agreements
    Page Should Contain Text    By continuing, you agree to Laerdal Medical’s Terms &amp; Conditions and Privacy Policy
    Get ScreenShot    Agreements_Section

Verify if get help card redirects to correct page
    Click Element    id=WelcomeView_TintedCachedImage_manage_account
    Wait Until Page Contains    MOBILE APPLICATIONS    timeout=20s
    Get ScreenShot    Get_Help_Redirect
    Run Process    powershell.exe    go_back
    Expect Element    id=WelcomeView_TintedCachedImage_manage_account    visible

Verify if get started button redirects to correct page
    Click Element    id=WelcomeView_Button_GetStartedCommand
    Wait Until Page Contains    Sign in or register to continue    timeout=20s
    Get ScreenShot    Get_Started_Redirect
    Run Process    powershell.exe    go_back
    Expect Element    id=WelcomeView_TintedCachedImage_manage_account    visible

Verify if learner button redirects to correct page
    Click Element    id=WelcomeView_Button_ContinueCommand
    Run Process    powershell.exe    trueaccess
    Run Process    powershell.exe    enable-bt
    ${Okay_text}    Run keyword and return status    Expect Text    Okay    visible
    IF    ${Okay_text} == ${True}
        Click Text    Okay
    END
    Wait Until Page Contains    Turn on your manikin
    Run Process    powershell.exe    go_back
    Expect Element    id=WelcomeView_TintedCachedImage_manage_account    visible

Verify if privacy policy link redirects to correct page
    Click Element    id=WelcomeView_Label_WelcomeView_Agreements
    Get ScreenShot    Privacy_Policy_Redirect
    Wait Until Page Contains    Privacy Statement
    Run Process    powershell.exe    go_back
    Expect Element    id=WelcomeView_TintedCachedImage_manage_account    visible

Verify if terms and conditions link redirects to correct page
    ${location}=    Get Element Rect    id=WelcomeView_Label_WelcomeView_Agreements
    ${height}=    Get From Dictionary    ${location}    height
    ${width}=     Get From Dictionary    ${location}    width
    ${x}=         Get From Dictionary    ${location}    x
    ${y}=         Get From Dictionary    ${location}    y
    @{firstFinger}=    Create List    ${height}    ${width}
    @{secondFinger}=   Create List    ${x}    ${y}
    @{fingerPositions}  create list      ${secondFinger}    ${firstFinger}
    Tap With Positions    100ms   @{fingerPositions}
    Sleep    5s
    Get ScreenShot    Terms_and_Conditions_Redirect
    Run Process    powershell.exe    go_back
    Run Process    powershell.exe    go_back
    Expect Element    id=WelcomeView_TintedCachedImage_manage_account    visible

