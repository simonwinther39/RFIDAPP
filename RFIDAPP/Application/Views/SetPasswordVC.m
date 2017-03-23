//
//  SetPasswordVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/1/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "SetPasswordVC.h"

@interface SetPasswordVC () {
    UITextField *currentTextField;
    CGFloat movementDistance;
    CGFloat originY;
}

@end

@implementation SetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initUI {
//    Gradient Background
    [commonUtils setGradient:self.mainContainerView startColor:RGBA(99, 99, 99, 1) endColor:RGBA(35, 71, 95, 1)];
//    Rounded Button
    [commonUtils setRoundedRectBorderButton:self.setPasswordButton withBorderRadius:self.setPasswordButton.frame.size.height/2];
    
//    Hide Keybord
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
//    Keyborad show
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    Change Font Size
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeLabel:self.passwordLabel];
    [commonUtils setFontSizeLabel:self.confirmLabel];
    [commonUtils setFontSizeTextField:self.passwordText];
    [commonUtils setFontSizeTextField:self.confirmPasswordText];
    [commonUtils setFontSizeButton:self.setPasswordButton];
    
//    Set Padding
    [commonUtils setPaddingTextField:self.passwordText];
    [commonUtils setPaddingTextField:self.confirmPasswordText];
    
    originY = self.subContainerView.frame.origin.y;
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    CGFloat subContainerViewY = self.subContainerView.frame.origin.y;
    CGFloat textFieldY = currentTextField.frame.origin.y;
    CGFloat textFieldHeight = currentTextField.frame.size.height;
    CGFloat selfOffsetY = self.view.frame.origin.y;
    CGFloat selfHeight = self.view.frame.size.height;
    
    movementDistance =subContainerViewY + textFieldY+selfOffsetY+textFieldHeight+keyboardHeight-selfHeight;
    
    if (movementDistance<0) {
        movementDistance = 0;
        return;
    }
    
    self.subContainerView.frame = CGRectOffset(self.subContainerView.frame, 0, -movementDistance);
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.subContainerView.frame = CGRectMake(self.subContainerView.frame.origin.x, originY, self.subContainerView.frame.size.width, self.subContainerView.frame.size.height);
}

#pragma mark - TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}

#pragma mark - Hide Keyboard
- (void) dismissKeyboard {
    [currentTextField resignFirstResponder];
}


- (IBAction)setPasswordAction:(id)sender {
    
    NSString *password = self.passwordText.text;
    NSString *confirmPassword = self.confirmPasswordText.text;
    
    if([commonUtils isFormEmpty:[@[password, confirmPassword] mutableCopy]]) {
        [commonUtils showVAlertSimple:@"Warning" body:@"Please fill out the forms" duration:1.5];
        return;
    } else if(![password isEqualToString:confirmPassword]) {
        [commonUtils showVAlertSimple:@"Warning" body:@"Password does not match the confirm password." duration:1.5];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
