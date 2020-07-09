//
//  ProfileTableViewCell.m
//  Solucis
//
//  Created by Lam Si Mon on 18-07-08.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import "ProfileTableViewCell.h"

@interface ProfileTableViewCell()

@end

@implementation ProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.rankLbl.text = NSLocalizedString(@"profile_rank_title", @"");
    self.memberCodeLbl.text = NSLocalizedString(@"profile_memberCode_title", @"");
    self.nameLbl.text = NSLocalizedString(@"profile_name_title", @"");
    self.icLbl.text = NSLocalizedString(@"profile_ic_title", @"");
    self.joinedDateLbl.text = NSLocalizedString(@"profile_joinedDate_title", @"");
    self.statusLbl.text = NSLocalizedString(@"profile_status_title", @"");
    self.sponsorCodeLbl.text = NSLocalizedString(@"profile_sponsorCode_title", @"");
    self.sponsorNameLbl.text = NSLocalizedString(@"profile_sponsorName_title", @"");
    self.addressLbl.text = NSLocalizedString(@"profile_address_title", @"");
    self.postCodeLbl.text = NSLocalizedString(@"profile_postCode_title", @"");
    self.mobileLbl.text = NSLocalizedString(@"profile_mobile_title", @"");
    self.telHomeLbl.text = NSLocalizedString(@"profile_telHome_title", @"");
    self.telOfficeLbl.text = NSLocalizedString(@"profile_telOffice_title", @"");
    self.faxLbl.text = NSLocalizedString(@"profile_fax_title", @"");
    self.emailLbl.text = NSLocalizedString(@"profile_email_title", @"");
    self.paypalNationLbl.text = NSLocalizedString(@"profile_paypalNation_title", @"");
    self.paypalEmailLbl.text = NSLocalizedString(@"profile_paypalEmail_title", @"");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
