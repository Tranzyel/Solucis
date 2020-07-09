//
//  PaypalPayTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-11-29.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaypalTableViewCellDelegate;

@interface PaypalPayTableViewCell : UITableViewCell
@property(nonatomic, assign) id <PaypalTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *paypalPayButton;
- (IBAction)paypalPayButtonDidTouchUp:(id)sender;
@end

@protocol PaypalTableViewCellDelegate <NSObject>
- (void)paypalPayButtonDidTouchUpDelegate:(PaypalPayTableViewCell *)sender;
@end
