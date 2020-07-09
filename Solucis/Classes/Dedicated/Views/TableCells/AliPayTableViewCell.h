//
//  PaypalPaymentTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AliPayTableViewCellDelegate;

@interface AliPayTableViewCell : UITableViewCell
@property(nonatomic, assign) id <AliPayTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *aliPayButton;
- (IBAction)aliPayButtonDidTouchUp:(id)sender;
@end

@protocol AliPayTableViewCellDelegate <NSObject>
- (void)alipayButtonDidTouchUpDelegate:(AliPayTableViewCell *)sender;
@end
