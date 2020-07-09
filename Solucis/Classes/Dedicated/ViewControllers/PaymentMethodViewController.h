//
//  PaymentMethodViewController.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-01.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentMethodViewController : ShopViewController
@property (weak, nonatomic) IBOutlet UIButton *nextPageButton;
@property (nonatomic , strong) NSString *totalPurchasedPrice;
@end
