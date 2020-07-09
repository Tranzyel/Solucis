//
//  NewRegisterTeamInfoCell.h
//  Solucis
//
//  Created by Lam Si Mon on 18-09-03.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewRegisterTeamInfoCellDelegate;


@interface NewRegisterTeamInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *companyCodeLbl;
@property (weak, nonatomic) IBOutlet UITextField *sponsorCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *sponsorNameTF;
- (IBAction)companyCodeDropDown:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, assign) id <NewRegisterTeamInfoCellDelegate> delegate;
@end

@protocol NewRegisterTeamInfoCellDelegate <NSObject>
- (void)companyDropDownDidTouchUp:(id)sender cell:(NewRegisterTeamInfoCell *)cell;
- (void)segmentedControlDidTouchUp:(BOOL)selected cell:(NewRegisterTeamInfoCell *)cell;
- (void)sponsorDidFinishEditing:(UITextField *)textField cell:(NewRegisterTeamInfoCell *)cell;
@end
