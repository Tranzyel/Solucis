//
//  RDDirectorInfo.m
//  Solucis
//
//  Created by Lam Si Mon on 16-08-22.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "RDDirectorInfo.h"

@interface RDDirectorInfo () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *directorNameLoc;
@property (weak, nonatomic) IBOutlet UILabel *directorNIRCLoc;
@property (weak, nonatomic) IBOutlet UILabel *directorMobileLoc;

@end

@implementation RDDirectorInfo

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.directorNameTextField.delegate = self;
    self.directorNIRCTextField.delegate = self;
    self.directorMobileTextField.delegate = self;
    
    self.directorNameLoc.text = NSLocalizedString(@"reg_director_name", "");
    self.directorNIRCLoc.text = NSLocalizedString(@"reg_director_NIRC", "");
    self.directorMobileLoc.text = NSLocalizedString(@"reg_director_mobile", "");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate directorInfoTextFieldDidFinishedEditing:textField.text textField:textField.tag];
}

@end
