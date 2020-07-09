//
//  DeliveryInfoDeliveryToTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "DeliveryInfoDeliveryToTableViewCell.h"
#define CELL_OFFSET 2.0

@implementation DeliveryInfoDeliveryToTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.deliveryToLoc.text = NSLocalizedString(@"rep_delivery_to", "");
    self.addressLoc.text = NSLocalizedString(@"rep_delivery_address", "");
    self.address2Loc.text = NSLocalizedString(@"rep_delivery_address2", "");
    self.address3Loc.text = NSLocalizedString(@"rep_delivery_address3", "");
    self.address4Loc.text = NSLocalizedString(@"rep_delivery_address4", "");
    self.recevierLoc.text = NSLocalizedString(@"rep_reciever_name", "");
    self.postCodeLoc.text = NSLocalizedString(@"rep_post_code", "");
    self.countryLoc.text = NSLocalizedString(@"rep_country", "");
    self.stateLoc.text = NSLocalizedString(@"rep_state", "");
    self.cityLoc.text = NSLocalizedString(@"rep_city", "");
    self.mobilePhoneLoc.text = NSLocalizedString(@"rep_mobile_phone", "");
    self.icNoLoc.text = NSLocalizedString(@"rep_ic_number", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)radioButtonDidTouchUp:(id)sender
{
    [self.delegate deliveryInfoDeliveryToRadioButtonDidTouchUp:self];
}

- (IBAction)countryButtonDidTouchUp:(id)sender
{
    [self.delegate deliveryInfoCountryButtonDidTouchUp:self];
}

- (IBAction)stateButtonDidTouchUp:(id)sender
{
    [self.delegate deliveryInfoStateButtonDidTouchUp:self];
}

- (IBAction)mobileCountryCodeDidTouchUp:(id)sender
{
    [self.delegate deliveryInfoMobileCountryCodeButtonDidTouchUp:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate deliveryInfoTextFieldDidFinishedEditing:self text:textField];
    NSLog(@"Text Field : %@" , textField.text);
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
