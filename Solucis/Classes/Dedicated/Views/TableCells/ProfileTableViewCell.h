//
//  ProfileTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 18-07-08.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankLbl;
@property (weak, nonatomic) IBOutlet UILabel *rankTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *memberCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *memberCodeTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *icLbl;
@property (weak, nonatomic) IBOutlet UILabel *icTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *joinedDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *joinedDateTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *sponsorCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *sponsorCodeTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *sponsorNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *sponsorNameTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *postCodeLbl;
@property (weak, nonatomic) IBOutlet UILabel *postCodeTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *mobileLbl;
@property (weak, nonatomic) IBOutlet UILabel *mobileTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *telHomeLbl;
@property (weak, nonatomic) IBOutlet UILabel *telHomeTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *telOfficeLbl;
@property (weak, nonatomic) IBOutlet UILabel *telOfficeTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *faxLbl;
@property (weak, nonatomic) IBOutlet UILabel *faxTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *paypalNationLbl;
@property (weak, nonatomic) IBOutlet UILabel *paypalNationTextLbl;

@property (weak, nonatomic) IBOutlet UILabel *paypalEmailLbl;
@property (weak, nonatomic) IBOutlet UILabel *paypalEmailTextLbl;

@end
