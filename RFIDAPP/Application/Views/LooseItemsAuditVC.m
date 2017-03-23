//
//  LooseItemsAuditVC.m
//  RFIDAPP
//
//  Created by Apple Developer on 4/4/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import "LooseItemsAuditVC.h"
#import "LooseItemObject.h"
#import "LooseItemCell.h"

@interface LooseItemsAuditVC () {
    NSMutableArray *looseItems;
}

@end

@implementation LooseItemsAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    looseItems = [[NSMutableArray alloc]init];
    
    LooseItemObject *looseItem = [[LooseItemObject alloc] initWithLooseItem:@"None" andDescription:@"Sterile Item 1" andQuantity:@"4"];
    
    for (int i = 0; i < 10; i++) {
        [looseItems addObject:looseItem];
    }
    
    self.looseItemsAuditTable.delegate = self;
    self.looseItemsAuditTable.dataSource = self;
    
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI {
    [commonUtils setFontSizeLabel:self.titleLabel];
    [commonUtils setFontSizeLabel:self.hospitalNameLabel];
    
    [commonUtils setFontSizeTextField:self.barcodeNumberText];
    [commonUtils setFontSizeTextField:self.itemDescriptionText];
    [commonUtils setFontSizeTextField:self.quantityText];
    
    [commonUtils setRoundedRectBorderButton:self.addButton withBorderRadius:self.addButton.frame.size.height/8];
    
}


- (IBAction)add:(id)sender {
}

- (IBAction)complete:(id)sender {
    [self popViewController];
}

- (IBAction)completeUpload:(id)sender {
    [self popViewController];
}

- (IBAction)clear:(id)sender {
    [self.barcodeNumberText setText:nil];
    [self.itemDescriptionText setText:nil];
    [self.quantityText setText:nil];
}

- (IBAction)cancel:(id)sender {
    [self popViewController];
}

- (void)popViewController {
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

//    UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return looseItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"LooseItemCell";
    
    LooseItemCell *cell = (LooseItemCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    LooseItemObject *object = [looseItems objectAtIndex:indexPath.row];
    
    [cell.itemDescriptionLabel setText:[NSString stringWithString:object.itemDescription]];
    [cell.quantityLabel setText:[NSString stringWithString:object.quantity]];
    
    return cell;
}

@end
