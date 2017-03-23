//  UserBaseViewController.m

#import "UserBaseViewController.h"


@interface UserBaseViewController ()

@end

@implementation UserBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if([commonUtils getUserDefault:@"current_user_id"] != nil) {
        appController.currentUser = [commonUtils getUserDefaultDicByKey:@"current_user"];
        
        [self navToHomeView];
        return;
    }
    if([[commonUtils getUserDefault:@"logged_out"] isEqualToString:@"1"]) {
        [commonUtils removeUserDefault:@"logged_out"];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
    self.isLoadingUserBase = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) prefersStatusBarHidden {
    return NO;
}

#pragma mark - Nagivate Events
- (void) navToHomeView {
    HomeVC *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:homeVC animated:NO];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

@end
