//
//  LoginVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/1/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//


@interface LoginVC () {
    UITextField *currentTextField;
    CGFloat originY;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void) initUI {
    //    Gradient Background
    [commonUtils setGradient:self.mainContainerView startColor:RGBA(99, 99, 99, 1) endColor:RGBA(35, 71, 95, 1)];
    //    Rounded Button
    [commonUtils setRoundedRectBorderButton:self.loginButton withBorderRadius:self.loginButton.frame.size.height/2];
    
    //    Hide Keybord
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //    Keyborad show/hide
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //    Change Font Size
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeLabel:self.descriptionLabel];
    [commonUtils setFontSizeTextField:self.usernameText];
    [commonUtils setFontSizeTextField:self.passwordText];
    [commonUtils setAttributedFontSizeButton:self.forgotButton];
    [commonUtils setFontSizeButton:self.loginButton];
    
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
    
    CGFloat movementDistance = subContainerViewY + textFieldY+selfOffsetY+textFieldHeight+keyboardHeight-selfHeight;

    if (movementDistance < 0) {
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

- (IBAction)userLogin:(id)sender {
    
//    [self navToHomeView];
    
    if(self.isLoadingUserBase) return;
    
    NSString *userName = self.usernameText.text;
    NSString *password = self.passwordText.text;
    
    if([commonUtils isFormEmpty:[@[userName, password] mutableCopy]]) {
        [commonUtils showVAlertSimple:@"Warning" body:@"Please complete entire form" duration:1.2];
    } else {
        NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
        [paramDic setObject:userName forKey:@"user_name"];
        [paramDic setObject:password forKey:@"password"];
        
        [self requestAPILogin:paramDic];
    }
}

#pragma mark - API Request - User Login
- (void)requestAPILogin:(NSMutableDictionary *)dic {
    self.isLoadingUserBase = YES;
    [commonUtils showActivityIndicatorColored:self.view];
    [NSThread detachNewThreadSelector:@selector(requestDataLogin:) toTarget:self withObject:dic];
}
- (void)requestDataLogin:(id) params {
    NSDictionary *resObj = nil;
    resObj = [commonUtils httpJsonRequest:API_URL_VERIFY_USER withJSON:(NSMutableDictionary *) params];
    self.isLoadingUserBase = NO;
    [commonUtils hideActivityIndicator];
    if (resObj != nil) {
        NSDictionary *result = (NSDictionary *)resObj;
        NSDecimalNumber *status = [result objectForKey:@"Status"];
        if([status intValue] == 1) {
            appController.currentUser = [result objectForKey:@"Message"];
            [commonUtils setUserDefaultDic:@"current_user" withDic:appController.currentUser];
            
            [self performSelector:@selector(requestOverLogin) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
        } else {
            NSString *msg = (NSString *)[resObj objectForKey:@"Message"];
            [commonUtils showVAlertSimple:@"Failed" body:msg duration:2.0];
        }
    } else {
        [commonUtils showVAlertSimple:@"Connection Error" body:@"Please check your internet connection status" duration:1.0];
    }
}
- (void)requestOverLogin {
    [self navToHomeView];
}


@end
