//
//  RDTnCAgreementTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-09-07.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RDTermsTableViewCellTnCButtonDidTouchUpDelegate;

@interface RDTnCAgreementTableViewCell : UITableViewCell
@property (nonatomic, assign) id <RDTermsTableViewCellTnCButtonDidTouchUpDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *acceptTnCButton;
- (IBAction)acceptTnCAction:(id)sender;
@end

@protocol RDTermsTableViewCellTnCButtonDidTouchUpDelegate <NSObject>

- (void)termsButtonDidTouchUp:(id)sender cell:(RDTnCAgreementTableViewCell *)cell;

@end
