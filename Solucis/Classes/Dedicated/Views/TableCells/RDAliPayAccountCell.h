//
//  RDAliPayAccountCell.h
//  Solucis
//
//  Created by Lam Si Mon on 18-07-17.
//  Copyright © 2018 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,AliPayFieldType)
{
    AlipayAccountNumber = 0,
    AlipayAccountName,
};

@protocol AlipayAccountCellDelegate;

@interface RDAliPayAccountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *alipayAccNoTF;
@property (weak, nonatomic) IBOutlet UITextField *alipayAccNameTF;
@property (nonatomic, assign) id <AlipayAccountCellDelegate> delegate;
@end

@protocol AlipayAccountCellDelegate
- (void)alipayAccountFieldDidFinishEditing:(NSString *)text fieldType:(AliPayFieldType)type;
@end

