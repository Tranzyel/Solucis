//
//  PlaceOrderCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-04.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
@property (weak, nonatomic) IBOutlet UILabel *itemGST;
@property (weak, nonatomic) IBOutlet UILabel *unitBV;
@property (weak, nonatomic) IBOutlet UILabel *unitPV;
@property (weak, nonatomic) IBOutlet UILabel *totalItemDescription;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UIButton *addItemButton;
@property (weak, nonatomic) IBOutlet UIButton *removeItemButton;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;

- (IBAction)addButtonDidTouchUp:(id)sender;
- (IBAction)minusButtonDidTouchUp:(id)sender;

@end
