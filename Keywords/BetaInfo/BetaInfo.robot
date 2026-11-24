*** Settings ***
Library    AppiumLibrary
Library    Collections
Resource    ../Commons.robot
*** Keywords ***
Verify if beta info screen is shown after sign in
    ${beta_invite_text}    Get Text    id=com.Laerdal.QCPRinstructor:id/BetaInfoView_Label_BetaInfoView_Beta_Invite
    Should Contain    ${beta_invite_text}    invited to the Beta of the QCPR app!
    Get ScreenShot    Beta_Info_Screen

Verify if beta info description is visible
    ${beta_description_text}    Get Text    id=com.Laerdal.QCPRinstructor:id/BetaInfoView_Label_BetaInfoView_Beta_Version_Description
    Should Contain    ${beta_description_text}    The Beta version means early access to new features and functionality.
    Should Contain    ${beta_description_text}    And feel free to share your feedback with us.
    Should Contain    ${beta_description_text}    Happy training!
    Get ScreenShot    Beta_Info_Description

Verify if beta info image is visible
    Page Should Contain Element    id=com.Laerdal.QCPRinstructor:id/BetaInfoView_TintedCachedImage_beta_info
    Get ScreenShot    Beta_Info_Image

Verify if continue button on beta info is visible
    ${continue_button_text}    Get Text    id=com.Laerdal.QCPRinstructor:id/BetaInfoView_Button_ContinueCommand
    Should Be Equal As Strings    ${continue_button_text}    Continue
    Get ScreenShot    Beta_Info_Continue_Button

Verify if continue button on beta info redirects to intro tour
    Click Element    id=com.Laerdal.QCPRinstructor:id/BetaInfoView_Button_ContinueCommand
    Wait Until Page Contains Element    id=com.Laerdal.QCPRinstructor:id/NewIntroView_Label_Onboarding_Existing_New_Intro_Title    timeout=20s
    Get ScreenShot    Beta_Info_Continue_Redirect
    Expect Element    id=com.Laerdal.QCPRinstructor:id/NewIntroView_Button_SkipTourCommand    visible
