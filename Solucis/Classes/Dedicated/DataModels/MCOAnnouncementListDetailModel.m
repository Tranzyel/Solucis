//
//  MCOAnnouncementListDetailModel.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-21.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MCOAnnouncementListDetailModel.h"

@implementation MCOAnnouncementListDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"imageURL": @"image",
             @"itemOptions": @"itemOptions",
             @"url": @"url"
             };
}

@end
