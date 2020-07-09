//
//  RDPayPalAccountInfoTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-09-06.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaypalNationalityDropDownDelegate;

@interface RDPayPalAccountInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *paypalNationality;
@property (weak, nonatomic) IBOutlet UITextField *paypalEmailTF;
@property (weak, nonatomic) IBOutlet UITextField *ppAccName;

@property (nonatomic, assign) id <PaypalNationalityDropDownDelegate> delegate;
- (IBAction)paypalNationalityDropdown:(id)sender;
@end

@protocol PaypalNationalityDropDownDelegate <NSObject>
- (void)paypalNationalityButtonDidTouchUp:(RDPayPalAccountInfoTableViewCell *)cell;
- (void)paypalEmailTextFieldDidFinishedEditing:(NSString *)text;
- (void)paypalAccountNameTextFieldDidFinishedEditing:(NSString *)text;
@end
