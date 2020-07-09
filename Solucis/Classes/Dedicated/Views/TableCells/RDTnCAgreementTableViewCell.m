//
//  RDTnCAgreementTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-09-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "RDTnCAgreementTableViewCell.h"

@interface RDTnCAgreementTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *tncLoc;

@end

@implementation RDTnCAgreementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tncLoc.text = NSLocalizedString(@"reg_terms_and_conditions_desc", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)acceptTnCAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self.delegate termsButtonDidTouchUp:button cell:self];
}

@end
