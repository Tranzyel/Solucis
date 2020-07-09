//
//  EAccountTransferTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-10-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EAccountTransferDelegate;


@interface EAccountTransferTableViewCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *memberIDTF;
@property (weak, nonatomic) IBOutlet UITextField *memberNameTF;
- (IBAction)verifyAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UITextField *remarkTF;
@property (weak, nonatomic) IBOutlet UITextField *ePinTF;
@property (nonatomic , assign) id <EAccountTransferDelegate> delegate;
@end

@protocol EAccountTransferDelegate <NSObject>

- (void)eAccountTransferTextFieldDidFinishEditing:(NSString *)text textField:(UITextField *)textField sender:(EAccountTransferTableViewCell *)sender;

@end
