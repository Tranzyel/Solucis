//
//  MCOPickerView.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MCOPickerView : UIView <UIPickerViewDelegate,UIPickerViewDataSource>
- (id)initWithNib;
- (void)showPickerViewWithType:(PickerType)type withCompletion:(void(^)(NSString *code , NSString *description , NSString *countryCode , NSString *identityCode))completion cancelBlock:(void(^)())cancelBlock;
@end
