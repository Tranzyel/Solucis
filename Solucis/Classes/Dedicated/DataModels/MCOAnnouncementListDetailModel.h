//
//  MCOAnnouncementListDetailModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-21.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOAnnouncementListDetailModel : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSString *imageURL;
@property (nonatomic, copy, readonly) NSString *itemOptions;
@property (nonatomic, copy, readonly) NSString *url;
@property (nonatomic, strong) UIImage *bannerImage;
@end
