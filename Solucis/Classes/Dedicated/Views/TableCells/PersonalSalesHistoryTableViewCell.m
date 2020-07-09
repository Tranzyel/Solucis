//
//  PersonalSalesHistoryTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-08.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PersonalSalesHistoryTableViewCell.h"

#define CELL_OFFSET 10.0

@interface PersonalSalesHistoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *docNoLoc;
@property (weak, nonatomic) IBOutlet UILabel *submittedDateLoc;
@property (weak, nonatomic) IBOutlet UILabel *pvLoc;
@property (weak, nonatomic) IBOutlet UILabel *sdoNoLoc;
@property (weak, nonatomic) IBOutlet UILabel *consignmentLoc;
@property (weak, nonatomic) IBOutlet UILabel *consignmentDateLoc;
@end

@implementation PersonalSalesHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.docNoLoc.text = NSLocalizedString(@"personal_sales_doc_no", "");
    self.submittedDateLoc.text = NSLocalizedString(@"personal_sales_submitted_date", "");;
    self.pvLoc.text = NSLocalizedString(@"personal_sales_PV", "");;
    self.sdoNoLoc.text = NSLocalizedString(@"personal_sales_sdo_no", "");;
    self.consignmentLoc.text = NSLocalizedString(@"personal_sales_consignment_no", "");;
    self.consignmentDateLoc.text = NSLocalizedString(@"personal_sales_consignment_date", "");;
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
