//
//  ShopViewController.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-01.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"

#define TOTAL_PAGES 5
#define TOTAL_PAGES_RD 6

typedef NS_ENUM(NSUInteger,DistributorType)
{
    DistributorTypeRepurchase,
    DistributorTypeRegistration,
};

@interface ShopViewController : BaseViewController
@property ( nonatomic , strong ) ProgressView *progressView;
@property ( nonatomic , assign ) DistributorType type;
- (void)navigateToNextPage;
@end
