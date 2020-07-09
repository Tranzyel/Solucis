//
//  MCOWeChatPayRequestModel.m
//  Solucis
//
//  Created by Lam Si Mon on 17-01-13.
//  Copyright © 2017 Lam Si Mon. All rights reserved.
//

#import "MCOWeChatPayRequestModel.h"

@implementation MCOWeChatPayRequestModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"appid":@"appid",
             @"codeUrl":@"code_url",
             @"mchID":@"mch_id",
             @"nonceStr":@"nonce_str",
             @"notifyURL":@"notify_url",
             @"prePayID":@"prepay_id",
             @"resultCode":@"result_code",
             @"returnCode":@"return_code",
             @"returnMsg":@"return_msg",
             @"sign":@"sign",
             @"tradeType":@"trade_type"
             };
}

@end
