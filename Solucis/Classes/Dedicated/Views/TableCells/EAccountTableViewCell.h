//
//  EAccountTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-27.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EAccountTableViewCellDelegate;

@interface EAccountTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *accountTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalPurchase;
@property (weak, nonatomic) IBOutlet UILabel *eAccountBalance;
@property (weak, nonatomic) IBOutlet UILabel *balanceAfPurchase;
@property (weak, nonatomic) IBOutlet UITextField *ePinTextField;
@property (weak, nonatomic) IBOutlet UIButton *eAccountButton;
@property (nonatomic, assign) id <EAccountTableViewCellDelegate> delegate;
- (IBAction)eAccountButtonDidTouchUp:(id)sender;
- (void)activateEpinResponder;
@end

@protocol EAccountTableViewCellDelegate <NSObject>

- (void)eAccountButtonDidTouchUp:(EAccountTableViewCell *)sender;
- (void)ePinDidFinishedEditing:(NSString *)ePin sender:(EAccountTableViewCell *)sender;

@end
