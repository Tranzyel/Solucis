//
//  UpdateProfileAddressCell.h
//  Solucis
//
//  Created by Lam Si Mon on 18-07-23.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , UpdateProfileTextType)
{
    UpdateAddress1 = 0,
    UpdateAddress2,
    UpdateAddress3,
    UpdateAddress4,
    UpdatePostcode,
    UpdateMobileNumber,
    UpdateEmail,
    UpdateCity
};

typedef NS_ENUM(NSUInteger , UpdateProfileDropDownType)
{
    UpdateProfileCountryCode = 0,
    UpdateProfileCountry,
    UpdateProfileState
};

@protocol UpdateProfileAddressCellDelegate;

@interface UpdateProfileAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *address1;
@property (weak, nonatomic) IBOutlet UITextField *address2;
@property (weak, nonatomic) IBOutlet UITextField *address3;
@property (weak, nonatomic) IBOutlet UITextField *address4;
@property (weak, nonatomic) IBOutlet UITextField *postCode;
@property (weak, nonatomic) IBOutlet UILabel *countryCode;
@property (weak, nonatomic) IBOutlet UILabel *mobileCode;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *dropDownButtonSelected;
- (IBAction)dropDownButtonDidTouchUp:(id)sender;

@property (nonatomic, strong) id <UpdateProfileAddressCellDelegate>delegate;
@end

@protocol UpdateProfileAddressCellDelegate<NSObject>
- (void)profileFieldDidFinishEditing:(NSString *)text cell:(UpdateProfileAddressCell *)cell fieldType:(UpdateProfileTextType)type;
- (void)dropDownButtonDidTouchUp:(UpdateProfileDropDownType)type cell:(UpdateProfileAddressCell *)cell;
@end
