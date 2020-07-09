//
//  MCOAnnoucementListModel.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-21.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCOAnnoucementListModel : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy, readonly) NSDate *startDate;
@property(nonatomic, copy, readonly) NSDate *endDate;
@property(nonatomic, copy, readonly) NSString *f_id;
@property(nonatomic, copy, readonly) NSString *f_title;
@property(nonatomic, copy, readonly) NSString *f_detail;

@end
