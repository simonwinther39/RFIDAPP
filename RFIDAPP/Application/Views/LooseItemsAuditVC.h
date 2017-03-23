//
//  LooseItemsAuditVC.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LooseItemsAuditVC : UIViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *hospitalNameLabel;

@property (strong, nonatomic) IBOutlet UITextField *barcodeNumberText;
@property (strong, nonatomic) IBOutlet UITextField *itemDescriptionText;
@property (strong, nonatomic) IBOutlet UITextField *quantityText;

@property (strong, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) IBOutlet UITableView *looseItemsAuditTable;


- (IBAction)add:(id)sender;
- (IBAction)complete:(id)sender;
- (IBAction)completeUpload:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)cancel:(id)sender;

@end
