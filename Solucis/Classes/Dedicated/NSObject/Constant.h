//
//  Constant.h
//  Solucis
//
//  Created by Lam Si Mon on 16-05-12.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

static NSString *const NavigateToNextViewControllerNotification = @"NavigateToNextViewControllerNotification";
static NSString *const LanguageDidChangedNotification = @"LanguageDidChangedNotification";
static NSString *const RememberMeDidActivate = @"RememberMeUserDefaults";
static NSString *const DOC_SUB_TYPE_REP = @"REP";
static NSString *const DOC_SUB_TYPE_REG = @"REG";

//AliPay
static NSString *const AliPayPaymentType = @"ALIPAY";
static NSString *const AliPayPID = @"2088911803175535";
static NSString *const AliPayAppID = @"2016062801561979";
static NSString *const AliPayPrivateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALbW9i+1xfuPqssNXbmF+RVqs2UHl8KvOL86pzs5YWT6Chz11QggMQRYK7ukXc/25ItqzSNxE/HotZt+vlyRWjpLkSWze9Bt/V8fgKaDlM8TPBxXVs1KH1eQ0G9e0TR73J6ND2EpzcRi+igqlA8aZUcLiFArVZiM+VKX38iZ/+nfAgMBAAECgYEAhlF6v+fojvqm/M5P6SfLqXkeWvzt9x6kMI+VJQPtUbICVe4e1v5XJBrl3c5NAKcelHEcTIoYneFX8Oh2TiiVv/mtS97my8BGwB6izIC1je8riV2zSD1YcudZ+0PaPFsoAVL8RKQq6egKc1phu6QruXsFIUNpJzweiE68hFho9RECQQDcubvxeuq8NkHgV8fZCUNniKLygKDmJXXmXmoPs4SkXcaaYuaKaFCK3zNwir69c5RhgP480wpeyz1RKNeuMgM3AkEA1A9Ajv3LNswa5PlOWk6jXa2iCw0RuJjIEG/DT9zv90p0iqd2I0snJIy/sBT9ktv76TMo0M+ROyZrLOEBbn7ymQJBALTLig+NQBK0WpdZL4AuH0EB4X7DL4f0LTNqKHP99mrvyQqScgXy1e46Txci/oON1X9cOmM19iuZS/tbefbcTlcCQDhfbZwVn8YLcELae5fKO+eVVvR1Hvbhtp2X+GXsp+YnZt/NMLylJ9yxheu7SMWXsVoG/Zy08Ti2N9uQXR8QpFECQFUE9U24AzJywTvi+W4hK/AmZ89sm9kQ8Et4x+H8yPZE82xigF62YEHFH5vvWM4rY3xcFD3gkT/87VpuW0myecw=";


#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

#endif /* Constant_h */
