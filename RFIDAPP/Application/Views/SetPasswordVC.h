//
//  SetPasswordVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/1/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPasswordVC : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *mainContainerView;
@property (strong, nonatomic) IBOutlet UIView *subContainerView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;
@property (strong, nonatomic) IBOutlet UILabel *confirmLabel;


@property (strong, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordText;

@property (strong, nonatomic) IBOutlet UIButton *setPasswordButton;

- (IBAction)setPasswordAction:(id)sender;
@end
