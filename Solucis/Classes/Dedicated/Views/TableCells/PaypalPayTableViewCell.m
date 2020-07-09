//
//  PaypalPayTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-11-29.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "PaypalPayTableViewCell.h"

@implementation PaypalPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)paypalPayButtonDidTouchUp:(id)sender
{
    [self.delegate paypalPayButtonDidTouchUpDelegate:self];
}

@end
