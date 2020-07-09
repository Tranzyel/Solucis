//
//  ExclusiveStoreListTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-08-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "ExclusiveStoreListTableViewCell.h"

#define CELL_OFFSET 10.0

@implementation ExclusiveStoreListTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

     self.memberCodeLoc.text = NSLocalizedString(@"esl_member_code", "");
     self.nameLoc.text = NSLocalizedString(@"esl_name", "");
     self.sponsorCodeLoc.text = NSLocalizedString(@"esl_sponsor_code", "");
     self.mobileLoc.text = NSLocalizedString(@"esl_mobile", "");
     self.joinedDateLoc.text = NSLocalizedString(@"esl_joined_date", "");
     self.rankLoc.text = NSLocalizedString(@"esl_rank", "");
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
    contentViewFrame.size.height -= CELL_OFFSET * 2;
    
    contentViewFrame.origin.x += CELL_OFFSET;
    contentViewFrame.origin.y += CELL_OFFSET;
    
    self.contentView.frame = contentViewFrame;
}
@end
