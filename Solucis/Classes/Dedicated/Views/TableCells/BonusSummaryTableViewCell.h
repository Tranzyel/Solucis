//
//  BonusSummaryTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BonusSummaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *retailProfit;
@property (weak, nonatomic) IBOutlet UILabel *exclusiveProfit;
@property (weak, nonatomic) IBOutlet UILabel *total;

//Localization
@property (weak, nonatomic) IBOutlet UILabel *dateLoc;
@property (weak, nonatomic) IBOutlet UILabel *retailProfitLoc;
@property (weak, nonatomic) IBOutlet UILabel *exclusiveShopLoc;
@property (weak, nonatomic) IBOutlet UILabel *totalLoc;

@end
