//
//  MCOWeChatPayRequestModel.h
//  Solucis
//
//  Created by Lam Si Mon on 17-01-13.
//  Copyright © 2017 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOWeChatPayRequestModel : MTLModel <MTLJSONSerializing>
@property (nonatomic , strong) NSString *appid;
@property (nonatomic , strong) NSString *codeUrl;
@property (nonatomic , strong) NSString *mchID;
@property (nonatomic , strong) NSString *nonceStr;
@property (nonatomic , strong) NSString *notifyURL;
@property (nonatomic , strong) NSString *prePayID;
@property (nonatomic , strong) NSString *resultCode;
@property (nonatomic , strong) NSString *returnCode;
@property (nonatomic , strong) NSString *returnMsg;
@property (nonatomic , strong) NSString *sign;
@property (nonatomic , strong) NSString *tradeType;
@end
