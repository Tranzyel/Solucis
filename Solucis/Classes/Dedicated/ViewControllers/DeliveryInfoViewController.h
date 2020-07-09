//
//  DeliveryInfoViewController.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-04.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryInfoPickUpTableViewCell.h"
#import "DeliveryInfoDeliveryToTableViewCell.h"

@interface DeliveryInfoViewController : ShopViewController <DeliveryInfoDeliveryToDelegate,DeliveryInfoPickUpDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nextPageButton;

@end
