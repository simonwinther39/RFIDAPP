//
//  ManualAuditVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "ManualAuditVC.h"

@interface ManualAuditVC () {
    UITextField *currentTextField;
}

@end

@implementation ManualAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    
    self.assetIdText.delegate = self;
    self.assetDescriptionText.delegate = self;
    self.itemNumberText.delegate = self;
    self.rfidTagIdText.delegate = self;
    
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeLabel:self.hospitalNameLabel];
    [commonUtils setFontSizeLabel:self.takePhotoLabel];
    
    [commonUtils setFontSizeTextField:self.assetIdText];
    [commonUtils setFontSizeTextField:self.assetDescriptionText];
    [commonUtils setFontSizeTextField:self.itemNumberText];
    [commonUtils setFontSizeTextField:self.rfidTagIdText];
    
    [commonUtils setRoundedRectBorderImage:self.photoImage withBorderRadius:self.photoImage.frame.size.height/6];
    
    //    Hide Keybord
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - UIButton Actions
//    Take Photo from Camera
- (IBAction)takePhoto:(id)sender {
    
    //    Set Error Message for Camera
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [commonUtils showAlert:@"Warring" withMessage:@"Device has no camera" withViewController:self];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

//    Complete
- (IBAction)complete:(id)sender {
    [self popViewController];
}

//    Complete Upload
- (IBAction)completeUpload:(id)sender {
    [self popViewController];
}

//    Clear
- (IBAction)clear:(id)sender {
    [self.assetIdText setText:nil];
    [self.assetDescriptionText setText:nil];
    [self.itemNumberText setText:nil];
    [self.rfidTagIdText setText:nil];
    
    [self.photoImage setImage:nil];
}

//    Cancel
- (IBAction)cancel:(id)sender {
    [self popViewController];
}

//    Pop ViewController
- (void)popViewController {
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentTextField = textField;
}

//    Hide Keyboard
- (void) dismissKeyboard {
    [currentTextField resignFirstResponder];
}

#pragma mark - ImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    UIImage *chosenImage = info[UIImagePickerControllerEditedImage]; //allowsEditing = YES
    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage]; //allowsEditing = NO

    self.photoImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker  {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
