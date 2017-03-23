//
//  AuditTypeVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/2/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "AuditTypeVC.h"

@interface AuditTypeVC ()

@end

@implementation AuditTypeVC

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
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeLabel:self.hospitalNameLabel];
    [commonUtils setFontSizeButton:self.completeAuditButton];
    [commonUtils setRoundedRectBorderButton:self.completeAuditButton withBorderRadius:self.completeAuditButton.frame.size.height/2];
}

- (IBAction)pushToChoosenAuditVC:(id)sender {
    ChosenAuditVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChosenAuditVC"];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
}

- (IBAction)pushToLooseItemsAuditVC:(id)sender {
    LooseItemsAuditVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LooseItemsAuditVC"];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
}

- (IBAction)pushToFieldCommissionVC:(id)sender {
    FieldCommissionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FieldCommissionVC"];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    [self.navigationController pushViewController:vc animated:NO];
}

- (IBAction)popToHomeVC:(id)sender {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HomeVC class]]) {
            [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
            [self.navigationController popToViewController:controller animated:NO];
        }
    }
}
@end
