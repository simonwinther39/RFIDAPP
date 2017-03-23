//
//  LoginVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/1/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

@interface LoginVC : UserBaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *mainContainerView;
@property (strong, nonatomic) IBOutlet UIView *subContainerView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;


@property (strong, nonatomic) IBOutlet UITextField *usernameText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *forgotButton;

- (IBAction)userLogin:(id)sender;

@end
