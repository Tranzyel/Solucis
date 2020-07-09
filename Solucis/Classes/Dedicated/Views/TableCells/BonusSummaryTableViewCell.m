//
//  BonusSummaryTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "BonusSummaryTableViewCell.h"

#define CELL_OFFSET 10.0

@implementation BonusSummaryTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.dateLoc.text = NSLocalizedString(@"sales_bonus_date", "");
    self.retailProfitLoc.text = NSLocalizedString(@"sales_bonus_retail_profit", "");
    self.exclusiveShopLoc.text = NSLocalizedString(@"sales_bonus_exclusive_shop_profit", "");
    self.totalLoc.text = NSLocalizedString(@"sales_bonus_total", "");
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.size.width -= CELL_OFFSET * 2;
    contentViewFrame.size.height -= CELL_OFFSET * 2;
    
    contentViewFrame.origin.x += CELL_OFFSET;
    contentViewFrame.origin.y += CELL_OFFSET;
    
    self.contentView.frame = contentViewFrame;
}
@end
