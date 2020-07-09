//
//  PreProductTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-09-16.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PreProductTableViewCell.h"

@implementation PreProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.gstLoc.text = NSLocalizedString(@"rep_gst", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
