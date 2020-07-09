//
//  PaypalPaymentTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "AliPayTableViewCell.h"

@implementation AliPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)aliPayButtonDidTouchUp:(id)sender
{
    [self.delegate alipayButtonDidTouchUpDelegate:self];
}

@end
