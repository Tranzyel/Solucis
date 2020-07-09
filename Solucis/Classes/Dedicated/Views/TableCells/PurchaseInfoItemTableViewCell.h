//
//  PurchaseInfoItemTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseInfoItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
@property (weak, nonatomic) IBOutlet UILabel *itemGST;
@property (weak, nonatomic) IBOutlet UILabel *totalItem;
@property (weak, nonatomic) IBOutlet UILabel *unitBV;
@property (weak, nonatomic) IBOutlet UILabel *unitPV;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;

@end
