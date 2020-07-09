//
//  WeChatPayTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-11-03.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "WeChatPayTableViewCell.h"

@implementation WeChatPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)weChatPayButtonDidTouchUp:(id)sender
{
    [self.delegate weChatpayButtonDidTouchUpDelegate:self];
}

@end
