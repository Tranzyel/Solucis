//
//  DeliveryInfoDeliveryToTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeliveryInfoDeliveryToDelegate;

@interface DeliveryInfoDeliveryToTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *address2TextField;
@property (weak, nonatomic) IBOutlet UITextField *address3TextField;
@property (weak, nonatomic) IBOutlet UITextField *address4TextField;
@property (weak, nonatomic) IBOutlet UITextField *receiverTextField;
@property (weak, nonatomic) IBOutlet UITextField *postCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *icNumberTextField;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIButton *radioButton;
@property (weak, nonatomic) IBOutlet UILabel *countryCode;
@property (nonatomic, assign) id <DeliveryInfoDeliveryToDelegate> delegate;

//Localized Label
@property (weak, nonatomic) IBOutlet UILabel *deliveryToLoc;
@property (weak, nonatomic) IBOutlet UILabel *addressLoc;
@property (weak, nonatomic) IBOutlet UILabel *address2Loc;
@property (weak, nonatomic) IBOutlet UILabel *address3Loc;
@property (weak, nonatomic) IBOutlet UILabel *address4Loc;
@property (weak, nonatomic) IBOutlet UILabel *recevierLoc;
@property (weak, nonatomic) IBOutlet UILabel *postCodeLoc;
@property (weak, nonatomic) IBOutlet UILabel *countryLoc;
@property (weak, nonatomic) IBOutlet UILabel *stateLoc;
@property (weak, nonatomic) IBOutlet UILabel *cityLoc;
@property (weak, nonatomic) IBOutlet UILabel *mobilePhoneLoc;
@property (weak, nonatomic) IBOutlet UILabel *icNoLoc;

- (IBAction)radioButtonDidTouchUp:(id)sender;
- (IBAction)countryButtonDidTouchUp:(id)sender;
- (IBAction)stateButtonDidTouchUp:(id)sender;
- (IBAction)mobileCountryCodeDidTouchUp:(id)sender;

@end

@protocol DeliveryInfoDeliveryToDelegate <NSObject>

- (void)deliveryInfoDeliveryToRadioButtonDidTouchUp:(DeliveryInfoDeliveryToTableViewCell *)sender;
- (void)deliveryInfoCountryButtonDidTouchUp:(DeliveryInfoDeliveryToTableViewCell *)sender;
- (void)deliveryInfoStateButtonDidTouchUp:(DeliveryInfoDeliveryToTableViewCell *)sender;
- (void)deliveryInfoMobileCountryCodeButtonDidTouchUp:(DeliveryInfoDeliveryToTableViewCell *)sender;
- (void)deliveryInfoTextFieldDidFinishedEditing:(DeliveryInfoDeliveryToTableViewCell *)sender text:(UITextField *)textField;
@end
