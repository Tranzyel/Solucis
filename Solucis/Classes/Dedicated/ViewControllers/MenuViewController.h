//
//  MenuViewController.h
//  Solucis
//
//  Created by Lam Si Mon on 16-03-14.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMenuViewController.h"

@interface MenuViewController : BaseMenuViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *menuCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
