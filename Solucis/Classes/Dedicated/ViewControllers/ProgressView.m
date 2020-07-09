//
//  ProgressView.m
//  Solucis
//
//  Created by Lam Si Mon on 16-04-03.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@end

@implementation ProgressView

- (id)initNib
{
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ProgressView class]) owner:self options:nil];
    
    for (id nib in array)
    {
        if ([nib isKindOfClass:[ProgressView class]])
        {
            return nib;
        }
    }
    return nil;
}


- (void)adjustPositionForViewController:(UIViewController *)controller
{
    CGRect frame ;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = controller.view.frame.size.width;
    frame.size.height = 45;
    
    self.frame = frame;
    
    [controller.view addSubview:self];
}


- (void)setPageName:(NSString *)name
        currentPage:(NSUInteger)currentPage
          totalPage:(NSUInteger)totalPage
{
    self.pageLabel.text = name;
    self.currentPageLabel.text = [NSString stringWithFormat:@"%lu/%lu" , (unsigned long)currentPage,(unsigned long)totalPage];
    
    float progress = (float)currentPage/(float)totalPage;
    
    [self.progressView setProgress:progress animated:NO];
}

@end
