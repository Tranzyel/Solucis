//
//  WeChatPayTableViewCell.h
//  Solucis
//
//  Created by Lam Si Mon on 16-11-03.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeChatPayTableViewCellDelegate;


@interface WeChatPayTableViewCell : UITableViewCell
@property(nonatomic, assign) id <WeChatPayTableViewCellDelegate> delegate;
- (IBAction)weChatPayButtonDidTouchUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *weChatPayButton;

@end

@protocol WeChatPayTableViewCellDelegate <NSObject>
- (void)weChatpayButtonDidTouchUpDelegate:(WeChatPayTableViewCell *)sender;
@end
