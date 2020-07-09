//
//  ProgressView.h
//  Solucis
//
//  Created by Lam Si Mon on 16-04-03.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPageLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

- (id)initNib;
- (void)adjustPositionForViewController:(UIViewController *)controller;
- (void)setPageName:(NSString *)name
        currentPage:(NSUInteger)currentPage
          totalPage:(NSUInteger)totalPage;
@end
