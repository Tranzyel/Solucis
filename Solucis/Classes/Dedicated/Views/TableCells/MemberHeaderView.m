//
//  MemberHeaderView.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-04.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "MemberHeaderView.h"

@implementation MemberHeaderView

- (id)initNib
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MemberHeaderView class]) owner:self options:nil];
    
    for (id obj in array)
    {
        if ([obj isKindOfClass:[MemberHeaderView class]])
        {
            return obj;
        }
    }
    return nil;
}

@end
