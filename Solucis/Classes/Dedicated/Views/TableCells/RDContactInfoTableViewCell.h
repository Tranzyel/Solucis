//
//  RDContactInfoTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-12.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RDContactInfoTableViewCellCountryCodeButtonDidTouchUpDelegate;

@interface RDContactInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *contactMobileTextField;
@property (weak, nonatomic) IBOutlet UILabel *countryCode;
@property (weak, nonatomic) IBOutlet UILabel *mobileCode;
@property (nonatomic, assign) id <RDContactInfoTableViewCellCountryCodeButtonDidTouchUpDelegate> delegate;

- (IBAction)countryDropDown:(id)sender;

@end

@protocol RDContactInfoTableViewCellCountryCodeButtonDidTouchUpDelegate <NSObject>

- (void)countryCodeButtonDidTouchUp:(id)sender cell:(RDContactInfoTableViewCell *)cell;
- (void)countryCodeMobileTextFieldDidFinishedEditing:(NSString *)text;
@end