//
//  RDMemberInfoTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-12.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , MemberInfoTextField)
{
    IDTypeTextField,
    MemberNameTextField
};

@protocol RDMemberInfoCellOptionsButtonDidTouchUpDelegate;

@interface RDMemberInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nationality;
@property (weak, nonatomic) IBOutlet UILabel *registerType;
@property (weak, nonatomic) IBOutlet UITextField *identity;
@property (weak, nonatomic) IBOutlet UITextField *memberName;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) IBOutlet UILabel *language;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *dropDownButton;
@property (weak, nonatomic) IBOutlet UILabel *idType;

@property (nonatomic, assign) id <RDMemberInfoCellOptionsButtonDidTouchUpDelegate> delegate;

- (IBAction)pickerButtonDidTouchUp:(id)sender;

@end

@protocol RDMemberInfoCellOptionsButtonDidTouchUpDelegate <NSObject>

- (void)memberInfoCellOptionsButtonDidTouchUp:(id)sender cell:(RDMemberInfoTableViewCell *)cell;
- (void)memberInfoTextFieldDidFinishedEditing:(NSString *)text textField:(MemberInfoTextField)textField;

@end
