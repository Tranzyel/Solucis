//
//  EAccountStatementTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-08.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "EAccountStatementTableViewCell.h"

#define CELL_OFFSET 5.0

@implementation EAccountStatementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

  self.docNoLoc.text = NSLocalizedString(@"ePoint_doc_no", "");
  self.transDateLoc.text = NSLocalizedString(@"ePoint_trans_date", "");
  self.inAmtLoc.text = NSLocalizedString(@"ePoint_in", "");
  self.outAmtLoc.text = NSLocalizedString(@"ePoint_out", "");
  self.balanceLoc.text = NSLocalizedString(@"ePoint_balance", "");
  self.remarkLoc.text = NSLocalizedString(@"ePoint_description", "");
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.size.width -= CELL_OFFSET * 2;
    contentViewFrame.size.height -= CELL_OFFSET;
    
    contentViewFrame.origin.x += CELL_OFFSET;
    contentViewFrame.origin.y += CELL_OFFSET;
    
    self.contentView.frame = contentViewFrame;
}

@end
