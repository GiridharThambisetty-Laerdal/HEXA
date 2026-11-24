*** Settings ***
Library    AppiumLibrary
Library    OperatingSystem
Library    JSONLibrary
Library    Process
Library    String
Library    DateTime

*** Variables ***
# CLI-overridable (defaults below are used when not passed), e.g.:
#   robot -v Device_name:emulator-5554 -v Appium_server:http://10.0.0.5:4723 Tests
#   robot --variable Device_name:5955ce90 Tests/Homepage/Homepage.robot
${Device_name}    5955ce90
${Appium_server}    http://localhost:4723
${appPackage}    com.Laerdal.QCPRinstructor
${appakhtivity}    com.Laerdal.QCPRinstructor/crc64b0e040297c600f0d.MainActivity
${platfrom}    16
${automationName}    uiautomator2

*** Keywords ***

Open App
    [Arguments]    ${Type}="Normal"
    # Set Library Search Order  AppiumLibrary  AppiumSikuliLibrary
    # ${Resource_Variables}    Load Json From File    ${CURDIR}/../Variables/variables.json
    # Set Global Variable    ${Resource_Variables}
    ${Test_Data}    Load Json From File    ${CURDIR}/../Resources/test_data.json
    Set Global Variable    ${Test_Data}
    Run Process    powershell.exe    disable-bt
    Run Process    powershell.exe    clearapp
    IF    ${Type}=="Custom"
        Open Application  ${Appium_server}  platformName=android  platformVersion=${platfrom}  deviceName=${Device_name}  automationName=${automationName}    appPackage=${appPackage}  newCommandTimeout=2500    noReset=${True}    appActivity=${appakhtivity}    forceAppLaunch=${True}    autoGrantPermissions=${True}    fullReset=${False}    setAutoWebview=${True}    allowInvisibleElements=${True}
    ELSE
        Open Application  ${Appium_server}  platformName=android  platformVersion=${platfrom}  deviceName=${Device_name}  automationName=${automationName}    appPackage=${appPackage}  newCommandTimeout=2500    noReset=${True}    appActivity=${appakhtivity}    forceAppLaunch=${True}    autoGrantPermissions=${True}    fullReset=${False}    enableMultiWindows=${False}    allowInvisibleElements=${True}    setAutoWebview=${True}
    END
    Sleep    3s
    Run Process    powershell.exe    enable-bt
    Run Process    powershell.exe    giveaccess
    Sleep    5s

Close App
    Run Process    powershell.exe    clearapp

User Enforced Input
    [Arguments]    ${locator_id}    ${user_input_text}
    Click Element    ${locator_id}
    Run Process    powershell.exe    user_enforced_input${space}${user_input_text}

Get ScreenShot
    [Arguments]    ${nameofthefile}=${EMPTY}    ${Path}=${EXECDIR}/Reports/Screenshots/
    # Set Log Level    NONE
    Capture Page Screenshot    filename=${nameofthefile}.png
    ${status}    Run Keyword And Return Status    Move File    ${EXECDIR}/Reports/${nameofthefile}.png    ${Path}
    IF    ${status} == ${False}
        Move File    ${EXECDIR}/Reports/${nameofthefile}.png    ${Path}
    END

Login With Password
    Click Element    id=com.Laerdal.QCPRinstructor:id/WelcomeView_Button_GetStartedCommand
    Wait Until Page Contains    Sign in or register to continue    timeout=30s
    Switch To Context    NATIVE_APP
    User Enforced Input    android=new UiSelector().resourceId("email")    ${Test_Data['username']}
    Run Process    powershell.exe    go_back
    Sleep    2s
    Click Element    android=new UiSelector().text("Sign in")
    Wait Until Page Contains    Sign in with password    timeout=20s
    Click Element    android=new UiSelector().text("Sign in with password")
    Wait Until Page Contains    Enter password to continue    timeout=20s
    Click Element    android=new UiSelector().resourceId("password")
    ${saved_password_prompt}    Run keyword and return status    Expect Text    Use saved password?    visible
    IF    ${saved_password_prompt} == ${True}
        Run Process    powershell.exe    go_back
    END
    User Enforced Input    android=new UiSelector().resourceId("password")    ${Test_Data['password']}
    Run Process    powershell.exe    go_back
    Sleep    2s
    Click Element    android=new UiSelector().text("Continue with password")
    Wait Until Page Contains Element    id=com.Laerdal.QCPRinstructor:id/BetaInfoView_Button_ContinueCommand    timeout=60s
    Get ScreenShot    Login_Success

Navigate To Intro Tour
    Click Element    id=com.Laerdal.QCPRinstructor:id/BetaInfoView_Button_ContinueCommand
    Wait Until Page Contains Element    id=com.Laerdal.QCPRinstructor:id/NewIntroView_Button_SkipTourCommand    timeout=20s

Navigate To Training Screen
    Navigate To Intro Tour
    Click Element    id=com.Laerdal.QCPRinstructor:id/NewIntroView_Button_SkipTourCommand
    Wait Until Page Contains Element    id=com.Laerdal.QCPRinstructor:id/ChooseTrainingView_Label_TopBarView_Title    timeout=20s