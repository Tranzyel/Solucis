//
//  RDVerifyViewController.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-11.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MobileSignUpInfo;
@interface RDVerifyViewController : ShopViewController
@property (nonatomic, strong) MobileSignUpInfo *signUpInfo;
@property (nonatomic, strong) NSString *tempUserID;
@end
