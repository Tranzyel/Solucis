//
//  LeftSideRevealViewController.h
//  Solucis
//
//  Created by Lam Si Mon on 16-03-14.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Page)
{
    Home = 0,
    Dashboard,
    Repurchase,
    RegisterDistributor,
    PersonalSalesHistory,
    AllSaleHistory,
    EAccount,
    EAccountTransfer,
    Withdrawal,
    SalesBonus,
    EPoint,
    Announcement,
    AboutUs,
    ExclusiveStore,
    Profile,
    LogOut,
};


@interface LeftSideRevealViewController : UIViewController
@property ( nonatomic , strong ) UITableView *sideTableView;
@end

