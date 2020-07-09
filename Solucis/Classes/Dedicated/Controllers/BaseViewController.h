//
//  BaseViewController.h
//  Solucis
//
//  Created by Lam Si Mon on 16-03-03.
//  Copyright © 2016 Lam Si Mon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SlideNavigationController.h>

@interface BaseViewController : UIViewController <SlideNavigationControllerDelegate>
- (void)showBackButton;
@end
