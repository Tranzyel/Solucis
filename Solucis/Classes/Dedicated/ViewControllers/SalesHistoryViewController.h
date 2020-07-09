//
//  SalesHistoryViewController.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListingTableViewController.h"

@interface SalesHistoryViewController : ListingTableViewController
@property(nonatomic, assign , readwrite) SalesType salesType;
@end
