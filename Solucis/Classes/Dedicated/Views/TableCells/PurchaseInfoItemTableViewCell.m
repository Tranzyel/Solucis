//
//  PurchaseInfoItemTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PurchaseInfoItemTableViewCell.h"

@interface PurchaseInfoItemTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *gstLoc;
@end

@implementation PurchaseInfoItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.gstLoc.text = NSLocalizedString(@"rep_gst", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
