//
//  WithdrawalTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 18-09-05.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WithdrawalTableViewCellDelegate;

@interface WithdrawalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UITextField *epinTF;
@property (weak, nonatomic) IBOutlet UILabel *withdrawMethodLbl;
@property (nonatomic, assign) id <WithdrawalTableViewCellDelegate> delegate;
- (IBAction)withdrawDropDown:(id)sender;

@end

@protocol WithdrawalTableViewCellDelegate <NSObject>
- (void)withdrawDropDownDidTouchUp:(id)sender cell:(WithdrawalTableViewCell *)cell;
- (void)textFieldDidEndEditing:(UITextField *)textField cell:(WithdrawalTableViewCell *)cell;
@end
