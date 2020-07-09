//
//  RDBankAccountInfoTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 18-07-17.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,BankAccountFieldType)
{
    BankAccountName = 0,
    BankAccountNumber,
    BankAccountNIRC,
    BankBranch
};

@protocol RDBankAccountInfoTableViewCellDelegate;

@interface RDBankAccountInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chinaBankLbl;
@property (weak, nonatomic) IBOutlet UILabel *chinaBankStateLbl;
@property (weak, nonatomic) IBOutlet UILabel *chinaBankDistrictLbl;

@property (weak, nonatomic) IBOutlet UITextField *bankAccNameTF;
@property (weak, nonatomic) IBOutlet UITextField *bankAccNoTF;
@property (weak, nonatomic) IBOutlet UITextField *bankAccNIRCTF;
@property (weak, nonatomic) IBOutlet UITextField *bankBranch;

@property (nonatomic, assign) id <RDBankAccountInfoTableViewCellDelegate> delegate;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *dropDownButton;
- (IBAction)dropDownButtonDidTouchUp:(id)sender;

@end

@protocol RDBankAccountInfoTableViewCellDelegate <NSObject>
- (void)bankAccountInfoCellDropDownDidTouchUp:(id)sender cell:(RDBankAccountInfoTableViewCell *)cell;
- (void)bankAccountTextFieldDidFinishEditing:(NSString *)text type:(BankAccountFieldType)type;
@end
