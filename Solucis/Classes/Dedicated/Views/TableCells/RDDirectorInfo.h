//
//  RDDirectorInfo.h
//  Solucis
//
//  Created by Lam Si Mon on 16-08-22.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , DirectorInfoTextField)
{
    DirectorNameTextField,
    DirectorIDNumberTextField,
    DirectorMobileNumberTextField
};

@protocol RDDirectorInfoTableCellDelegate;

@interface RDDirectorInfo : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *directorNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *directorNIRCTextField;
@property (weak, nonatomic) IBOutlet UITextField *directorMobileTextField;
@property (weak, nonatomic) IBOutlet UILabel *directorMobileCode;
@property (nonatomic , assign) id <RDDirectorInfoTableCellDelegate> delegate;
@end

@protocol RDDirectorInfoTableCellDelegate <NSObject>
- (void)directorInfoTextFieldDidFinishedEditing:(NSString *)text textField:(DirectorInfoTextField)textField;
@end
