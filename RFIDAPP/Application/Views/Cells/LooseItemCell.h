//
//  LooseItemCell.h
//  RFIDAPP
//
//  Created by Apple Developer on 4/5/16.
//  Copyright © 2016 Apple Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LooseItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;

@end
