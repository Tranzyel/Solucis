//
//  PersonalSalesHistoryTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-08.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "AllSalesHistoryTableViewCell.h"

#define CELL_OFFSET 10.0

@interface AllSalesHistoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *docNoLoc;
@property (weak, nonatomic) IBOutlet UILabel *typeLoc;
@property (weak, nonatomic) IBOutlet UILabel *submittedDateLoc;
@property (weak, nonatomic) IBOutlet UILabel *PVLoc;
@property (weak, nonatomic) IBOutlet UILabel *memberLoc;

@end

@implementation AllSalesHistoryTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.docNoLoc.text = NSLocalizedString(@"all_sales_doc_no", "");
    self.typeLoc.text = NSLocalizedString(@"all_sales_type", "");;
    self.submittedDateLoc.text = NSLocalizedString(@"all_sales_submitted_date", "");;
    self.PVLoc.text = NSLocalizedString(@"all_sales_pv", "");;
    self.memberLoc.text = NSLocalizedString(@"all_sales_member", "");;
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
