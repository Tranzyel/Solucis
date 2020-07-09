//
//  NewRegisterMemberInfoCell.h
//  Solucis
//
//  Created by Lam Si Mon on 18-09-03.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewRegisterMemberInfoCellDelegate;

@interface NewRegisterMemberInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nationalityLbl;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passportTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTF;
@property (nonatomic, strong) id <NewRegisterMemberInfoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *mobileZone;

@end

@protocol NewRegisterMemberInfoCellDelegate <NSObject>

- (void)memberInfoDropDownDidTouchUp:(id)sender cell:(NewRegisterMemberInfoCell*)cell;
- (void)textFieldDidEndEditing:(UITextField *)textField cell:(NewRegisterMemberInfoCell*)cell;
@end
